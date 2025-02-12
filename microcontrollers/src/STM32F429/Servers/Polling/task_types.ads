with System;

package Task_Types is
   
   task type ADC_Handler with Priority => System.Max_Priority;
   
   ADC_T : ADC_Handler;
end Task_Types;
