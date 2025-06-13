with Common_Values;
with ADC;
with EXTI;
with Common_Types;
with RNG;
with Ada.Synchronous_Barriers;

with System.BB.CPU_Primitives;

package body Interrupt_Handlers is

   protected body ADC_Interrupt_Handler is
      procedure Handle_Interrupt is
         use Ada.Real_Time;
      begin
         Common_Values.Measured_ADC_Value := ADC.ADC1_DR_Reg;

         ADC.ADC1_CR1_Reg.EOCIE := Common_Types.Off; --  Disable interrupts
         Ada.Real_Time.Timing_Events.Set_Handler (Event, Ada.Real_Time.Clock + MIT.all, Handle_Timeout'Access); -- setup interrupt-enable event to fire after MIT
      end Handle_Interrupt;

      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         ADC.ADC1_CR1_Reg.EOCIE := Common_Types.On; -- Enable the interrupt
      end Handle_Timeout;
   end ADC_Interrupt_Handler;

   --   EXTI4
   protected body EXTI4_Interrupt_Handler is
      procedure Handle_Interrupt is
         use Ada.Real_Time;
      begin
         EXTI.EXTI_IMR_Reg.MR4 := Common_Types.Off; -- disable interrupt
         EXTI.EXTI_PR_Reg.PR4 := Common_Types.On; -- clear pending status (bit needs to be set **HIGH** in order to do that)
         Ada.Real_Time.Timing_Events.Set_Handler (Event, Ada.Real_Time.Clock + MIT.all, Handle_Timeout'Access); -- setup interrupt-enable event to fire after MIT
         Arrived := True;
      end Handle_Interrupt;

      entry Wait_For_Next_Interrupt when Arrived is
      begin
         Arrived := False;
      end Wait_For_Next_Interrupt;

      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         EXTI.EXTI_IMR_Reg.MR4 := Common_Types.On; -- enable the interrupt
      end Handle_Timeout;
   end EXTI4_Interrupt_Handler;

   --  RNG
   protected body RNG_Interrupt_Handler is
      procedure Handle_Interrupt is
         use Ada.Real_Time;
         use Common_Types;
      begin
         --   Perhaps, not ideal that error handling is taking place inside the
         --   interrupt handler but the logic is fairly simple and quick
         if RNG.RNG_SR_Reg.CEIS = Common_Types.On then
            --   Clock error, first, clear CEIS bit
            RNG.RNG_SR_Reg.CEIS := Common_Types.Off;
            --   Clock configuration should be checked
            raise RNG_Clock_Configuration_Error;
         end if;

         if RNG.RNG_SR_Reg.SEIS = Common_Types.On then
            --   Seed error, number generation is currently halted
            --   Recovery involves two steps:
            --   First, clear SEIS
            RNG.RNG_SR_Reg.SEIS := Common_Types.Off;
            --   Then flip the RNGEN bit to reinitialize and restart the RNG
            RNG.RNG_CR_Reg.RNGEN := Common_Types.Off;
            RNG.RNG_CR_Reg.RNGEN := Common_Types.On;
            --   Generated value cannot be used as the required entropy might not have been accumulated
         else
            if RNG.RNG_SR_Reg.DRDY = Common_Types.On then
               Common_Values.Generated_Random := RNG.RNG_DR_Reg.RNDATA;
            end if;
            --   If RNG.RNG_SR_Reg.DRDY isn't set then this interrupt was caused by an error which has already beed handled above
         end if;

         RNG.RNG_CR_Reg.IE := Common_Types.Off; --  Disable interrupts
         Ada.Real_Time.Timing_Events.Set_Handler (Event, Ada.Real_Time.Clock + MIT.all, Handle_Timeout'Access); -- setup interrupt-enable event to fire after MIT
      end Handle_Interrupt;

      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event) is
      begin
         RNG.RNG_CR_Reg.IE := Common_Types.On; -- Enable the interrupt
      end Handle_Timeout;
   end RNG_Interrupt_Handler;
end Interrupt_Handlers;
