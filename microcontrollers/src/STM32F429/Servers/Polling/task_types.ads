with System;

package Task_Types is
   
   task type ADC_Handler with Priority => System.Max_Priority;
   task type EXTI4_Handler with Priority => System.Max_Priority;
   
   --  AH : ADC_Handler;
   EH : EXTI4_Handler;
end Task_Types;
