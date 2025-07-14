with Ada.Interrupts.Names;
with System;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;

package Hal_Interrupt_Handlers is

   --  TODO: Do we want to parameterise with ADC module?

   --   ADC
   protected type ADC_Interrupt_Handler (MIT : access constant Ada.Real_Time.Time_Span) with
     Interrupt_Priority => System.Max_Interrupt_Priority is
   private
      procedure Handle_Interrupt with
        Attach_Handler => Ada.Interrupts.Names.ADC_Interrupt;
      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event);
      Event : Ada.Real_Time.Timing_Events.Timing_Event;
   end ADC_Interrupt_Handler;

   ADC_MIT : aliased Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (200);
   ADCH : ADC_Interrupt_Handler (MIT => ADC_MIT'Access);

end Hal_Interrupt_Handlers;
