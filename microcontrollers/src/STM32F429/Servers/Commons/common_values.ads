with Interfaces;

package Common_Values is

   Measured_ADC_Value : Interfaces.Unsigned_16 with Volatile, Atomic;
   Generated_Random : Interfaces.Unsigned_32 with Volatile, Atomic;

   --   TODO: Declare queue here

end Common_Values;
