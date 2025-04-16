with Interfaces;
with Task_Control;

package Common_Values is

   Measured_ADC_Value : Interfaces.Unsigned_16 with Volatile, Atomic;
   Generated_Random   : Interfaces.Unsigned_32 with Volatile, Atomic;

   Worker_Queue : aliased Task_Control.Job_Queue;
end Common_Values;
