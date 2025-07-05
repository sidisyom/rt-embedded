package Hal.Stm32.Adc.f4xx is

   type ADC_Configuration_Request (Total_Conversions : Sequence_Number) is
      record
         Device : ADC_Device;
         Conversions : Conversion_Sequence (1 .. Total_Conversions);
         Sampling_Time : Channel_Sampling_Time;
         Data_Alignment : Conversion_Data_Alignment;
      end record;

   procedure Configure (CR : ADC_Configuration_Request);

end Hal.Stm32.Adc.f4xx;
