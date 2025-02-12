with Common_Types;
with RCC;
with GPIO;
with ADC;
with Common_Values;
with Task_Control;

package body Task_Types is
   --   Emulates some typical work carried out by a task by reading an ADC-converted value (i.e. the "sensor")
   --   and mapping the constituent bits of this value to a number of GPIO pins (the "actuator").
   task body ADC_Handler is
      type Pin_Bits is new Integer range 1 .. 4;
      type Value_Bits is array (Pin_Bits) of Boolean with Component_Size => 1;
      Pins               : Value_Bits with Address => Common_Values.Measured_ADC_Value'Address;
      Port_G : constant Common_Types.GPIO_Port := Common_Types.G;
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
         ADC.ADC1_SQR1_Reg.L := 0; --   Value zero corresponds to one conversion, according to RM
         ADC.ADC1_SQR3_Reg.SQ1 := 1; --   Set conversion channel "1"
         ADC.ADC1_CR2_Reg.ADON := Common_Types.On; --   Turn ADC module on
         ADC.ADC1_CR2_Reg.CONT := Common_Types.On; --   Set convert continuosly
         ADC.ADC1_CR1_Reg.EOCIE := Common_Types.Off; --   Enable interrupts
         --  ADC.ADC1_CR2_Reg.SWSTART := Common_Types.On; --   Start conversions
      end Setup_ADC_Module;
            
      procedure Set_Pins is
      begin
         for I in Pin_Set'Range loop
            GPIO.GPIO_Registers (Port_G).ODR.Pin_Values (Pin_Set (Pin_Set'Last - I + 1)) := --   (TODO: Investigate why bit order is reveresed)
              (if Pins (I) then Common_Types.On else Common_Types.Off);
         end loop;
      end Set_Pins;
      use Common_Types;
   begin
      --   Wait here till system is ready
      Task_Control.IC.Wait_For_Initialization;
      Setup_Ports_And_Pins;
      Setup_ADC_Module;
      --   And here till all tasks arrive at their critical instant
      --   TODO
      loop
         ADC.ADC1_CR2_Reg.SWSTART := Common_Types.On;
         loop
            exit when ADC.ADC1_SR_Reg.EOC = Common_Types.On;
         end loop;
         Common_Values.Measured_ADC_Value := ADC.ADC1_DR_Reg;
         --  Set_Pins; --   values in "Pins" are memory-mapped to the converted value (see declaration of "Pins")
         --  delay 1.0; The periodic delay value
      end loop;
   end ADC_Handler;
end Task_Types;
