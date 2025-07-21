with Hal.Stm32.Gpio;
with Hal.Stm32.Adc.f4xx;
with Hal_Interrupt_Handlers;
with Registers.Stm32f4.Rcc.B32f429;

procedure Hal_Sandbox is
begin
   declare
      --   Setting-up channel#1 which according to Datasheet is bound to "PA1" (i.e. ADC123_IN1)
      PA1_Conf_Request : constant Hal.Stm32.Gpio.GPIO_Configuration_Request := (Port => Hal.Stm32.A,
                                                                                Pin  => 1,
                                                                                Mode => Hal.Stm32.Analog);
      --   Setting-up channel#12 which according to Datasheet is bound to "PC2" (i.e. ADC123_IN12)
      PC2_Conf_Request : constant Hal.Stm32.Gpio.GPIO_Configuration_Request := (Port => Hal.Stm32.C,
                                                                                Pin  => 2,
                                                                                Mode => Hal.Stm32.Analog);

      ADC_Configuration_Request : constant Hal.Stm32.Adc.f4xx.ADC_Configuration_Request := (Total_Conversions => 2,
                                                                                            Channels => 1,
                                                                                            Device => Hal.Stm32.Adc.ADC1,
                                                                                            Conversions       => (1 => 1, 2 => 12),
                                                                                            Sampling_Times    => (0 => Hal.Stm32.Adc.Cycles_3, 1 => Hal.Stm32.Adc.Cycles_3),
                                                                                            Data_Alignment    =>  Hal.Stm32.Adc.Right,
                                                                                            Conv_Type   => Hal.Stm32.Adc.Continuous,
                                                                                            Conversion_Interrupt => Hal.Stm32.Adc.Enabled,
                                                                                            Scan_Md => Hal.Stm32.Scan_Mode_On);
   begin
      Registers.Stm32f4.Rcc.B32f429.RCC_CFGR_Reg.SW := Registers.Stm32f4.Rcc.HSI;
      Hal.Stm32.Gpio.Configure_Gpio (PA1_Conf_Request);
      Hal.Stm32.Gpio.Configure_Gpio (PC2_Conf_Request);
      Hal.Stm32.Adc.f4xx.Configure (ADC_Configuration_Request);
      loop
         --   Read common adc-conversion variable
         null;
      end loop;
   end;
end Hal_Sandbox;
