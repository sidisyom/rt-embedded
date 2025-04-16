with System;
with Ada.Real_Time;
with Task_Control;
with Common_Values;

package Task_Types is

   task type ADC_Handler (Period : access constant Ada.Real_Time.Time_Span) with Priority => System.Max_Priority;
   task type EXTI4_Handler (Worker_Queue : access Task_Control.Job_Queue) with Priority => System.Max_Priority - 1;
   task type Green_Light_Controller (Period       : access constant Ada.Real_Time.Time_Span;
                                     Worker_Queue : access Task_Control.Job_Queue) with Priority => System.Max_Priority - 2;

   ADC_Handler_Period : aliased constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (50);
   AH                 : ADC_Handler (Period => ADC_Handler_Period'Access);

   EH : EXTI4_Handler (Common_Values.Worker_Queue'Access);

   Green_Light_Controller_Period : aliased Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds (25);
   GLH : Green_Light_Controller (Period       => Green_Light_Controller_Period'Access,
                                 Worker_Queue => Common_Values.Worker_Queue'Access);
end Task_Types;
