with Ada.Interrupts.Names;
with System;
with Ada.Real_Time;
with Ada.Real_Time.Timing_Events;

package Interrupt_Handlers with Elaborate_Body is
   --   ADC
   protected ADC_Interrupt_Handler with
     Interrupt_Priority => System.Max_Interrupt_Priority
   is
      procedure Handle with
        Attach_Handler => Ada.Interrupts.Names.ADC_Interrupt;
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

   EXTI4_MIT : aliased Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (1_00);
   EIH : EXTI4_Interrupt_Handler (MIT => EXTI4_MIT'Access);

end Interrupt_Handlers;
