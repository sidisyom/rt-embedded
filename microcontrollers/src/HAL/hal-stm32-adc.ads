with Registers.Adc.Stm32f4xx;

package Hal.Stm32.Adc is

   type ADC_Device is (ADC1, ADC2, ADC3);

   type Channel_Number is range 0 .. 18;
   type Sequence_Number is range 1 .. 16;

   type Channel_Sampling_Time is (Cycles_3, Cycles_15, Cycles_28, Cycles_56, Cycles_84, Cycles_112, Cycles_144, Cycles_480) with Size => 3;
   type Conversion_Data_Alignment is (Right, Left) with Size => 1;

   type Conversion_Sequence is array (Sequence_Number range <>) of Channel_Number;
   type Channel_Sampling_Configuration is array (Channel_Number range <>) of Channel_Sampling_Time;

   type Conversion_Type is (Continuous, One_Shot);
   type Conversion_Interrupt_Status is (Enabled, Disabled);

   --   Probably, best not to inline the To_Internal_** functions as these are called quite frequently
   function To_Internal_Adc_Channel (C : Channel_Number)
                                     return Registers.Adc.Stm32f4xx.ADC_Channel is (Registers.Adc.Stm32f4xx.ADC_Channel (C));
   function To_Internal_Adc_Channel_Sampling_Time (S : Channel_Sampling_Time)
                                                   return Registers.Adc.Stm32f4xx.Channel_Sampling_Time is (case S is
                                                                                                               when Cycles_3 => Registers.Adc.Stm32f4xx.Cycles_3,
                                                                                                               when Cycles_15 => Registers.Adc.Stm32f4xx.Cycles_15,
                                                                                                               when Cycles_28 => Registers.Adc.Stm32f4xx.Cycles_28,
                                                                                                               when Cycles_56 => Registers.Adc.Stm32f4xx.Cycles_56,
                                                                                                               when Cycles_84 => Registers.Adc.Stm32f4xx.Cycles_84,
                                                                                                               when Cycles_112 => Registers.Adc.Stm32f4xx.Cycles_112,
                                                                                                               when Cycles_144 => Registers.Adc.Stm32f4xx.Cycles_144,
                                                                                                               when Cycles_480 => Registers.Adc.Stm32f4xx.Cycles_480
                                                                                                           );
   function To_Internal_Conversion_Data_Alignment (A : Conversion_Data_Alignment) return Registers.Adc.Stm32f4xx.Conversion_Data_Alignment  is (case A is
                                                                                                                                                   when Right => Registers.Adc.Stm32f4xx.Right,
                                                                                                                                                   when Left  => Registers.Adc.Stm32f4xx.Left
                                                                                                                                               );
end Hal.Stm32.Adc;
