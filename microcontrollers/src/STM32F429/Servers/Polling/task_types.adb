with Common_Types;
with RCC;
with GPIO;
with ADC;
with SYSCFG;
with EXTI;
with Interrupt_Handlers;
with RNG;
with Interfaces;

package body Task_Types is
   task body Poller_Server is
      Next_Activation : Ada.Real_Time.Time := Ada.Real_Time.Clock;
      use type Ada.Real_Time.Time;
   begin
      loop
         declare
            J : Common_Types.Job;
            Valid : Boolean := False;
         begin
            Worker_Queue.Take (J, Valid);

            if Valid then
               null;
            end if;
         end;

         Next_Activation := Next_Activation + Period.all;
         delay until Next_Activation;
      end loop;
   end Poller_Server;

   --   Emulates some typical work carried out by a task by reading an ADC-converted value (i.e. the "sensor")
   --   and mapping the constituent bits of this value to a number of GPIO pins (the "actuator").
   --   Task is periodic.
   task body ADC_Handler is
      type Pin_Bits is new Integer range 1 .. 4;
      type Value_Bits is array (Pin_Bits) of Boolean with Component_Size => 1;
      Pins : Value_Bits with Address => Common_Values.Measured_ADC_Value'Address;
      Port_G : Common_Types.GPIO_Port renames Common_Types.G;
      Pin_Set : constant array (Pin_Bits) of Common_Types.GPIO_Pin := (9, 11, 13, 15); --   "Actuator" pins

      procedure Setup_Ports_And_Pins is
         --   According to Datasheet "PA1" is bound to "ADC123_IN1" ("ADC1" will be used here)
         Port_A : constant Common_Types.GPIO_Port := Common_Types.A;
         Pin_1 : constant Common_Types.GPIO_Pin := 1;
      begin
         --   "Actuator" setup
         RCC.RCC_AHB1ENR_Reg.GPIO_PORT_G := Common_Types.Enabled;
         for P of Pin_Set loop
            GPIO.GPIO_Registers (Port_G).MODER (P) := GPIO.Output;
         end loop;
         --   "Sensor" setup
         RCC.RCC_AHB1ENR_Reg.GPIO_PORT_A := Common_Types.Enabled;
         GPIO.GPIO_Registers (Port_A).MODER (Pin_1) := GPIO.Analog; --   i.e. the external analog voltage pin
      end Setup_Ports_And_Pins;

      --   ADC1 setup
      procedure Setup_ADC_Module is
      begin
         --   According to Datasheet the max clock speed for a Vdda = 2.4 .. 3.6 is 36MHz so selecting the default HSI (i.e. 16MHz) as the primary clock source will be safe
         RCC.RCC_APB2ENR_Reg.ADC1_EN := Common_Types.On; --   turn ADC module clock on
         delay 1.0E-6; --   Stabilization time. RM isn't particularly specific about the required duration (see 13.3.6 in RM)
         ADC.ADC1_SMPR2_Reg.SMP1 := ADC.Cycles_3; --   Set sampling time for channel "1"
         ADC.ADC1_CR2_Reg.ALIGN := ADC.Right; --  Set conversion data alignment (also see register declaration)
         ADC.ADC1_CR1_Reg.DISCNUM := 0; --   000 => 1 Channel
         ADC.ADC1_SQR1_Reg.L := 0; --   According to RM, value zero corresponds to one conversion
         ADC.ADC1_SQR3_Reg.SQ1 := 1; --   Set conversion channel "1"
         ADC.ADC1_CR2_Reg.ADON := Common_Types.On; --   Turn ADC module on
         ADC.ADC1_CR2_Reg.CONT := Common_Types.On; --   Set convert continuosly/one-shot
         ADC.ADC1_CR1_Reg.EOCIE := Common_Types.On; --   Enable/Disable interrupts
         ADC.ADC1_CR2_Reg.SWSTART := Common_Types.On; --   Start conversions
      end Setup_ADC_Module;

      procedure Set_Pins is
      begin
         for I in Pin_Set'Range loop
            GPIO.GPIO_Registers (Port_G).ODR.Pin_Values (Pin_Set (Pin_Set'Last - I + 1)) := --   (TODO: Investigate why bit order is reveresed)
              (if Pins (I) then Common_Types.On else Common_Types.Off);
         end loop;
      end Set_Pins;

      Next_Activation : Ada.Real_Time.Time := Ada.Real_Time.Clock;
      use Ada.Real_Time;
   begin
      --   Wait here till system is ready
      Task_Control.IC.Wait_For_Initialization;
      Setup_Ports_And_Pins;
      Setup_ADC_Module;
      --   And here till all tasks arrive at their critical instant
      --   TODO: Implement when more than one period tasks are declared
      loop
         Set_Pins; --   values in "Pins" are memory-mapped to the converted value (see declaration of "Pins")

         declare
            Vref : constant Float := 3.3;
            Actual_Volts : Float := 0.0;
         begin
            Actual_Volts := Float (Common_Values.Measured_ADC_Value) * (Vref / Float (4096));
            Actual_Volts := 0.0;
         end;

         Next_Activation := Next_Activation + Period.all;
         delay until Next_Activation;
      end loop;
   end ADC_Handler;

   --   EXTI4 Handler (Driven by interrupt handler entry which is sporadic)
   task body EXTI4_Handler is
      procedure Setup_External_Interrupt is
      begin
         RCC.RCC_APB2ENR_Reg.SYSCFG_EN := Common_Types.On; --   Turn-on system configuration controller clock
         SYSCFG.SYSCFG_EXTICR_Regs (2).EXTIO := SYSCFG.PB; --   Setting-up for PB4
         EXTI.EXTI_FTSR_Reg.TR4 := Common_Types.On;
         EXTI.EXTI_IMR_Reg.MR4 := Common_Types.On; -- Enable interrupt initially
      end Setup_External_Interrupt;
      procedure Setup_Random_Number_Generator is
      begin
         RCC.RCC_AHB2ENR_Reg.RNGEN := Common_Types.On; --   Turn RNG clock on
         RNG.RNG_CR_Reg.IE := Common_Types.On; --   Enable interrupt
         RNG.RNG_CR_Reg.RNGEN := Common_Types.On; --   Enable random number generation
      end Setup_Random_Number_Generator;

   begin
      Task_Control.IC.Wait_For_Initialization; --   Wait here till system is ready
      Setup_External_Interrupt;
      Setup_Random_Number_Generator;
      loop
         declare
            Job : constant Common_Types.Job := (Payload => Common_Values.Generated_Random);
         begin
            Worker_Queue.Put (Job);
         end;
         Interrupt_Handlers.EIH.Wait_For_Next_Interrupt; --   Effectively the period is the same as the interrupt handler
      end loop;
   end EXTI4_Handler;

   task body Green_Light_Controller is
      use Ada.Real_Time;
      use Interfaces;

      Green_Led_Port : Common_Types.GPIO_Port renames Common_Types.G;
      Green_Led_Pin : constant Common_Types.GPIO_Pin := 13;

      procedure Setup_Green_Led is
      begin
         --   According to user-manual, green light is bound to PG13a
         RCC.RCC_AHB1ENR_Reg.GPIO_PORT_G := Common_Types.Enabled;
         GPIO.GPIO_Registers (Green_Led_Port).MODER (Green_Led_Pin) := GPIO.Output;
      end Setup_Green_Led;

      Next_Activation : Ada.Real_Time.Time := Ada.Real_Time.Clock;
      On_Threshold : constant Interfaces.Unsigned_32 := Interfaces.Unsigned_32'Last / 3; --   Just some random threshold..
   begin
      Setup_Green_Led;
      loop
         declare
            R   :  Interfaces.Unsigned_32 := Common_Values.Generated_Random;
         begin
            for I in 1 .. 100 loop
               R := R + Interfaces.Unsigned_32 (I);
            end loop;

            if R > On_Threshold then
               GPIO.GPIO_Registers (Green_Led_Port).ODR.Pin_Values (Green_Led_Pin) := Common_Types.On;
            else
               GPIO.GPIO_Registers (Green_Led_Port).ODR.Pin_Values (Green_Led_Pin) := Common_Types.Off;
            end if;
         end;

         Next_Activation := Next_Activation + Period.all;
         delay until Next_Activation;
      end loop;
   end Green_Light_Controller;
end Task_Types;
