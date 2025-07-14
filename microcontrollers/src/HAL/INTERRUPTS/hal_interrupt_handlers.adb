with Registers.Adc.Stm32f4xx;
with Hal_Common_Values;

package body Hal_Interrupt_Handlers is

   protected body ADC_Interrupt_Handler is
      procedure Handle_Interrupt is
         use Ada.Real_Time;
      begin
         Hal_Common_Values.Measured_ADC_Value := Registers.Adc.Stm32f4xx.ADC1_DR_Reg;

         Registers.Adc.Stm32f4xx.ADC1_CR1_Reg.EOCIE := Registers.Off; --  Disable interrupts
         Ada.Real_Time.Timing_Events.Set_Handler (Event, Ada.Real_Time.Clock + MIT.all, Handle_Timeout'Access); -- setup interrupt-enable event to fire after MIT
      end Handle_Interrupt;

      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event) is
         pragma Unreferenced (E);
      begin
         Registers.Adc.Stm32f4xx.ADC1_CR1_Reg.EOCIE := Registers.On; -- Enable interrupts
      end Handle_Timeout;
   end ADC_Interrupt_Handler;

end Hal_Interrupt_Handlers;
