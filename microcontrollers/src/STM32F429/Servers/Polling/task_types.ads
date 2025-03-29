with System;
with Ada.Real_Time;

package Task_Types is

   task type ADC_Handler (Period : access constant Ada.Real_Time.Time_Span) with Priority => System.Max_Priority;
   task type EXTI4_Handler with Priority => System.Max_Priority - 1;

   ADC_Handler_Period : aliased constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (50);
   AH                 : ADC_Handler (Period => ADC_Handler_Period'Access);

   EH : EXTI4_Handler;
end Task_Types;
