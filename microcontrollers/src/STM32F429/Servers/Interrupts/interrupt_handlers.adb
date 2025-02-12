with Common_Values;
with ADC;

package body Interrupt_Handlers is

   protected body ADC_Interrupt_Handler is
      procedure Handle is
      begin
         Common_Values.Measured_ADC_Value := ADC.ADC1_DR_Reg;
      end Handle;
   end ADC_Interrupt_Handler;
end Interrupt_Handlers;
