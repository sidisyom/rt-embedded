with Common_Values;
with ADC;
with EXTI;
with Common_Types;

package body Interrupt_Handlers is

   protected body ADC_Interrupt_Handler is
      procedure Handle is
      begin
         Common_Values.Measured_ADC_Value := ADC.ADC1_DR_Reg;
      end Handle;
   end ADC_Interrupt_Handler;

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
end Interrupt_Handlers;
