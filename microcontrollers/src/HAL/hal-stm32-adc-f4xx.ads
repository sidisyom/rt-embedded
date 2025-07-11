package Hal.Stm32.Adc.f4xx is

   type ADC_Configuration_Request (Total_Conversions : Sequence_Number; Total_Channels : Channel_Number) is
      record
         Device : ADC_Device;
         Conversions : Conversion_Sequence (1 .. Total_Conversions);
         Sampling_Times : Channel_Sampling_Configuration (0 .. Total_Channels);
         Data_Alignment : Conversion_Data_Alignment;
         CT             : Conversion_Type;
         CIS            : Conversion_Interrupt_Status;
      end record;
   procedure Configure (CR : ADC_Configuration_Request);

end Hal.Stm32.Adc.f4xx;
