with Hal.Stm32.Gpio;
with Hal.Stm32.Adc.f4xx;
with Hal_Interrupt_Handlers;

procedure Hal_Sandbox is
begin
   declare
      --   Setting-up ADC for channel#1 which according to Datasheet is bound to "PA1" (i.e. ADC123_IN1)
      Conf_Request : constant Hal.Stm32.Gpio.GPIO_Configuration_Request := (Port => Hal.Stm32.A,
                                                                            Pin  => 1,
                                                                            Mode => Hal.Stm32.Analog);

      ADC_Configuration_Request : constant Hal.Stm32.Adc.f4xx.ADC_Configuration_Request := (Total_Conversions => 1,
                                                                                            Channels => 0,
                                                                                            Device => Hal.Stm32.Adc.ADC1,
                                                                                            Conversions       => (1 => 1),
                                                                                            Sampling_Times    => (0 => Hal.Stm32.Adc.Cycles_3),
                                                                                            Data_Alignment    =>  Hal.Stm32.Adc.Right,
                                                                                            CT                => Hal.Stm32.Adc.Continuous,
                                                                                            CIS               =>    Hal.Stm32.Adc.Enabled);
   begin
      Hal.Stm32.Gpio.Configure_Gpio (Conf_Request);
      Hal.Stm32.Adc.f4xx.Configure (ADC_Configuration_Request);
      loop
         --   Read common adc-conversion variable
         null;
      end loop;
   end;
end Hal_Sandbox;
