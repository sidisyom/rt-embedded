with Ada.Interrupts.Names;
with System;

package Interrupt_Handlers with Elaborate_Body is

   protected ADC_Interrupt_Handler with
     Interrupt_Priority => System.Max_Interrupt_Priority
   is
      procedure Handle with
        Attach_Handler => Ada.Interrupts.Names.ADC_Interrupt;
   end ADC_Interrupt_Handler;
end Interrupt_Handlers;
