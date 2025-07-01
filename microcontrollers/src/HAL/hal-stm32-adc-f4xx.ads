package Hal.Stm32.Adc.f4xx is

   type ADC_Device is (ADC1, ADC2, ADC3);

   type Channel_Number is range 0 .. 18;
   type Sequence_Number is range 1 .. 16;
   type Conversion_Sequence is array (Sequence_Number range <>) of Channel_Number;

   type ADC_Configuration_Request is
      record
         Device : ADC_Device;
      end record;

   procedure Configure (CR : ADC_Configuration_Request);

end Hal.Stm32.Adc.f4xx;
