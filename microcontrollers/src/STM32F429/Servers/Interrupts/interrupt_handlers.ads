with Ada.Interrupts.Names;
with System;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;

package Interrupt_Handlers with Elaborate_Body is
   --   ADC
   protected type ADC_Interrupt_Handler (MIT : access constant Ada.Real_Time.Time_Span) with
     Interrupt_Priority => System.Max_Interrupt_Priority is
   private
      procedure Handle_Interrupt with
        Attach_Handler => Ada.Interrupts.Names.ADC_Interrupt;
      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event);
      Event : Ada.Real_Time.Timing_Events.Timing_Event;
   end ADC_Interrupt_Handler;

   --   EXTI4
   protected type EXTI4_Interrupt_Handler (MIT : access constant Ada.Real_Time.Time_Span) with
     Interrupt_Priority => System.Max_Interrupt_Priority
   is
      entry Wait_For_Next_Interrupt;
   private
      procedure Handle_Interrupt with
        Attach_Handler => Ada.Interrupts.Names.EXTI4_Interrupt;
      procedure Handle_Timeout (E : in out Ada.Real_Time.Timing_Events.Timing_Event);
      Event : Ada.Real_Time.Timing_Events.Timing_Event;
      Arrived : Boolean;
   end EXTI4_Interrupt_Handler;

   ADC_MIT : aliased Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (200);
   ADCH : ADC_Interrupt_Handler (MIT => ADC_MIT'Access);

   EXTI4_MIT : aliased Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (100);
   EIH : EXTI4_Interrupt_Handler (MIT => EXTI4_MIT'Access);

end Interrupt_Handlers;
