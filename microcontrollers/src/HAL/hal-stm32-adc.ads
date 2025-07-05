with Registers.Adc.Stm32f4xx;

package Hal.Stm32.Adc is

   type ADC_Device is (ADC1, ADC2, ADC3);

   type Channel_Number is range 0 .. 18;
   type Sequence_Number is range 1 .. 16;
   type Conversion_Sequence is array (Sequence_Number range <>) of Channel_Number;

   type Channel_Sampling_Time is (Cycles_3, Cycles_15, Cycles_28, Cycles_56, Cycles_84, Cycles_112, Cycles_144, Cycles_480) with Size => 3;
   type Conversion_Data_Alignment is (Right, Left) with Size => 1;

   type Channel_Sampling_Configuration is array (Channel_Number) of Channel_Sampling_Time;

   function To_Internal_Adc_Channel (C : Channel_Number)
                                     return Registers.Adc.Stm32f4xx.ADC_Channel is (Registers.Adc.Stm32f4xx.ADC_Channel (C));
end Hal.Stm32.Adc;
