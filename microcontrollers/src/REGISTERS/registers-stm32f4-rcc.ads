with Hal;
with System;

package Registers.Stm32f4.Rcc is

   --  Address definitions
   Base_Address : constant := 16#4002_3800#;
   RCC_CR_Offset : constant := 16#00#;
   RCC_PLLCFGR_Offset : constant := 16#04#;
   RCC_CFGR_Offset : constant := 16#08#;
   RCC_AHB1ENR_Offset : constant := 16#30#;
   RCC_AHB2ENR_Offset : constant := 16#34#;
   RCC_APB1ENR_Offset : constant := 16#40#;
   RCC_APB2ENR_Offset : constant := 16#44#;

   type HSITRIM_Value is mod 2**5;
   for HSITRIM_Value'Size use 5;

   type Clock_Source is (HSI, HSE, PLL);
   for Clock_Source use (HSI => 2#00#,
                         HSE => 2#01#,
                         PLL => 2#10#);
   for Clock_Source'Size use 2;

   type AHB_Prescaler_Value is (AHB_Not_Divided, AHB_Pre_2, AHB_Pre_4, AHB_Pre_8, AHB_Pre_16, AHB_Pre_64, AHB_Pre_128, AHB_Pre_256, AHB_Pre_512);
   for AHB_Prescaler_Value use (AHB_Not_Divided => 2#0000#,
                                AHB_Pre_2 => 2#1000#,
                                AHB_Pre_4 => 2#1001#,
                                AHB_Pre_8 => 2#1010#,
                                AHB_Pre_16 => 2#1011#,
                                AHB_Pre_64 => 2#1100#,
                                AHB_Pre_128 => 2#1101#,
                                AHB_Pre_256 => 2#1110#,
                                AHB_Pre_512     => 2#1111#);
   for AHB_Prescaler_Value'Size use 4;

   type APB_Prescaler_Value is (APB_NO_DIV, APB_DIV_2, APB_DIV_4, APB_DIV_8, APB_DIV_16);
   for APB_Prescaler_Value use (APB_NO_DIV => 2#000#,
                                APB_DIV_2 => 2#100#,
                                APB_DIV_4 => 2#101#,
                                APB_DIV_8 => 2#110#,
                                APB_DIV_16 => 2#111#);
   for APB_Prescaler_Value'Size use 3;

   type RTC_Prescaler_Value is range 0 .. 31 with Size => 5; -- A value of "2" configures division by 2, of "3" division by 3 and so on.1 Values 0,1 configure no division.

   type MCO1_Clock_Source is (HSI, LSE, HSE, PLL);
   for MCO1_Clock_Source use (HSI => 2#00#,
                              LSE => 2#01#,
                              HSE => 2#10#,
                              PLL => 2#11#);
   for MCO1_Clock_Source'Size use 2;

   type MCO2_Clock_Source is (SYSCLK, PLLI2S, HSE, PLL);
   for MCO2_Clock_Source use (SYSCLK => 2#00#,
                              PLLI2S => 2#01#,
                              HSE => 2#10#,
                              PLL    => 2#11#);
   for MCO2_Clock_Source'Size use 2;

   type MCO1_Prescaler is (MCO1_Pre_No_Div, MCO1_Pre_Two, MCO1_Pre_Three, MCO1_Pre_Four, MCO1_Pre_Five);
   for MCO1_Prescaler use (MCO1_Pre_No_Div => 2#011#,
                           MCO1_Pre_Two => 2#100#,
                           MCO1_Pre_Three => 2#101#,
                           MCO1_Pre_Four => 2#110#,
                           MCO1_Pre_Five => 2#111#);
   for MCO1_Prescaler'Size use 3;

   type PLLM_Values is range 2 .. 63;
   for PLLM_Values'Size use 6;

   type PLLN_Values is range 2 .. 432;
   for PLLN_Values'Size use 9;

   type PLLP_Prescaler is (PLLP_Pre_2, PLLP_Pre_4, PLLP_Pre_6, PLLP_Pre_8);
   for PLLP_Prescaler use (PLLP_Pre_2 => 2#00#,
                           PLLP_Pre_4 => 2#01#,
                           PLLP_Pre_6 => 2#10#,
                           PLLP_Pre_8 => 2#11#);
   for PLLP_Prescaler'Size use 2;

   type PLL_Source is (PLL_Src_HSI, PLL_Src_HSE);
   for PLL_Source use (PLL_Src_HSI => 2#0#,
                       PLL_Src_HSE => 2#1#);
   for PLL_Source'Size use 1;

   type PLLQ_Values is range 2 .. 15;
   for PLLQ_Values'Size use 4;

   type RCC_CR_Register is
      record
         HSI_On : Binary_State;
         HSI_Rdy : Binary_State;
         HSITRIM : HSITRIM_Value;
         HSE_On : Binary_State;
         HSE_Rdy : Binary_State;
         PLLON : Binary_State;
         PLLRDY : Binary_State;
         PLLI2SON : Binary_State;
         PLLI2SRDY : Binary_State;
         --  Unmapped : Hal.Unmapped_Range (1 .. 4);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_CR_Register use
      record
         HSI_On at 0 range 0 .. 0;
         HSI_Rdy at 0 range 1 .. 1;
         HSITRIM at 0 range 3 .. 7;
         HSE_On at 0 range 16 .. 16;
         HSE_Rdy at 0 range 17 .. 17;
         PLLON at 0 range 24 .. 24;
         PLLRDY at 0 range 25 .. 25;
         PLLI2SON at 0 range 26 .. 26;
         PLLI2SRDY at 0 range 27 .. 27;
         --  Unmapped at 0 range  28 .. 31;
      end record;

   type RCC_CFGR_Register is
      record
         SW : Clock_Source;
         SWS : Clock_Source;
         HPRE : AHB_Prescaler_Value;
         PPRE1 : APB_Prescaler_Value;
         PPRE2 : APB_Prescaler_Value;
         RTCPRE : RTC_Prescaler_Value;
         MCO1 : MCO1_Clock_Source;
         I2SSCR : Binary_State;
         MCO1PRE : MCO1_Prescaler;
         MCO2PRE : MCO1_Prescaler;
         MCO2 : MCO2_Clock_Source;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_CFGR_Register use
      record
         SW at 0 range 0 .. 1;
         SWS at 0 range 2 .. 3;
         HPRE at 0 range 4 .. 7;
         PPRE1 at 0 range 10 .. 12;
         PPRE2 at 0 range 13 .. 15;
         RTCPRE at 0 range 16 .. 20;
         MCO1 at 0 range 21 .. 22;
         I2SSCR at 0 range 23 .. 23;
         MCO1PRE at 0 range 24 .. 26;
         MCO2PRE at 0 range 27 .. 29;
         MCO2 at 0 range 30 .. 31;
      end record;

   type RCC_AHB1ENR_Register is
      record
         PORT_CLOCK_EN : Compact_Ports;
         CRCEN          : Binary_State;
         BKPSRAMEN      : Binary_State;
         CCMDATARAMEN   : Binary_State;
         DMA1EN         : Binary_State;
         DMA2EN         : Binary_State;
         DMA2DEN        : Binary_State;
         ETHMACEN       : Binary_State;
         ETHMACTXEN     : Binary_State;
         ETHMACRXEN     : Binary_State;
         ETHMACPTPEN    : Binary_State;
         OTGHSEN        : Binary_State;
         OTGHSULPIEN    : Binary_State;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_AHB1ENR_Register use
      record
         PORT_CLOCK_EN at 0 range 0 .. 10;
         CRCEN at 0 range 12 .. 12;
         BKPSRAMEN at 0 range 18 .. 18;
         CCMDATARAMEN at 0 range 20 .. 20;
         DMA1EN at 0 range 21 .. 21;
         DMA2EN at 0 range 22 .. 22;
         DMA2DEN at 0 range 23 .. 23;
         ETHMACEN at 0 range 25 .. 25;
         ETHMACTXEN at 0 range 26 .. 26;
         ETHMACRXEN at 0 range 27 .. 27;
         ETHMACPTPEN at 0 range 28 .. 28;
         OTGHSEN at 0 range 29 .. 29;
         OTGHSULPIEN at 0 range 30 .. 30;
      end record;

   type RCC_AHB2ENR_Register is
      record
         DCMIEN : Binary_State;
         CRYPEN    : Binary_State;
         HASHEN    : Binary_State;
         RNGEN     : Binary_State;
         OTGFSEN   : Binary_State;
         Unmapped : Hal.Unmapped_Range (1 .. 23);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_AHB2ENR_Register use
      record
         DCMIEN at 0 range 0 .. 0;
         CRYPEN at 0 range 4 .. 4;
         HASHEN at 0 range 5 .. 5;
         RNGEN at 0 range 6 .. 6;
         OTGFSEN at 0 range 7 .. 7;
         Unmapped at 0 range 8 .. 31;
      end record;

   type RCC_PLLCFGR_Register is
      record
         PLLM : PLLM_Values;
         PLLN : PLLN_Values;
         PLLP : PLLP_Prescaler;
         PLLSRC : PLL_Source;
         PLLQ : PLLQ_Values;
         Unmapped : Hal.Unmapped_Range (1 .. 4);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_PLLCFGR_Register use
      record
         PLLM at 0 range 0 .. 5;
         PLLN at 0 range 6 .. 14;
         PLLP at 0 range 16 .. 17;
         PLLSRC at 0 range 22 .. 22;
         PLLQ at 0 range 24 .. 27;
         Unmapped at 0 range 28 .. 31;
      end record;

   type RCC_APB1ENR_Register is
      record
         TIM2_EN : Binary_State;
         TIM3_EN : Binary_State;
         TIM4_EN : Binary_State;
         TIM5_EN : Binary_State;
         TIM6_EN : Binary_State;
         TIM7_EN : Binary_State;
         TIM12_EN : Binary_State;
         TIM13_EN : Binary_State;
         TIM14_EN : Binary_State;
         WWDG_En : Binary_State;
         SPI2_EN : Binary_State;
         SPI3_EN : Binary_State;
         USART2_EN : Binary_State;
         USART3_EN : Binary_State;
         UART4_EN : Binary_State;
         UART5_EN : Binary_State;
         I2C1_EN : Binary_State;
         I2C2_EN : Binary_State;
         I2C3_EN : Binary_State;
         CAN1_EN : Binary_State;
         CAN2_EN  : Binary_State;
         PWR_EN : Binary_State;
         DAC_EN : Binary_State;
         UART7_EN : Binary_State;
         UART8_EN : Binary_State;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_APB1ENR_Register use
      record
         TIM2_EN at 0 range 0 .. 0;
         TIM3_EN at 0 range 1 .. 1;
         TIM4_EN at 0 range 2 .. 2;
         TIM5_EN at 0 range 3 .. 3;
         TIM6_EN at 0 range 4 .. 4;
         TIM7_EN at 0 range 5 .. 5;
         TIM12_EN at 0 range 6 .. 6;
         TIM13_EN at 0 range 7 .. 7;
         TIM14_EN at 0 range 8 .. 8;
         WWDG_En at 0 range 11 .. 11;
         SPI2_EN at 0 range 14 .. 14;
         SPI3_EN at 0 range 15 .. 15;
         USART2_EN at 0 range 17 .. 17;
         USART3_EN at 0 range 18 .. 18;
         UART4_EN at 0 range 19 .. 19;
         UART5_EN at 0 range 20 .. 20;
         I2C1_EN at 0 range 21 .. 21;
         I2C2_EN at 0 range 22 .. 22;
         I2C3_EN at 0 range 23 .. 23;
         CAN1_EN at 0 range 25 .. 25;
         CAN2_EN at 0 range 26 .. 26;
         PWR_EN at 0 range 28 .. 28;
         DAC_EN at 0 range 29 .. 29;
         UART7_EN at 0 range 30 .. 30;
         UART8_EN at 0 range 31 .. 31;
      end record;

   type RCC_APB2ENR_Register is
      record
         TIM1_EN : Binary_State;
         TIM8_EN : Binary_State;
         USART1_EN : Binary_State;
         USART6_EN : Binary_State;
         ADC1_EN : Binary_State;
         ADC2_EN : Binary_State;
         ADC3_EN : Binary_State;
         SDIO_EN : Binary_State;
         SPI1_EN : Binary_State;
         SPI4_EN : Binary_State;
         SYSCFG_EN : Binary_State;
         TIM9_EN : Binary_State;
         TIM10_EN : Binary_State;
         TIM11_EN : Binary_State;
         SPI5_EN : Binary_State;
         SPI6_EN : Binary_State;
         SAI1_EN : Binary_State;
         LTDC_EN : Binary_State;
         Unmapped : Hal.Unmapped_Range (1 .. 5);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_APB2ENR_Register use
      record
         TIM1_EN at 0 range 0 .. 0;
         TIM8_EN at 0 range 1 .. 1;
         USART1_EN at 0 range 4 .. 4;
         USART6_EN at 0 range 5 .. 5;
         ADC1_EN at 0 range 8 .. 8;
         ADC2_EN at 0 range 9 .. 9;
         ADC3_EN at 0 range 10 .. 10;
         SDIO_EN at 0 range 11 .. 11;
         SPI1_EN at 0 range 12 .. 12;
         SPI4_EN at 0 range 13 .. 13;
         SYSCFG_EN at 0 range 14 .. 14;
         TIM9_EN at 0 range 16 .. 16;
         TIM10_EN at 0 range 17 .. 17;
         TIM11_EN at 0 range 18 .. 18;
         SPI5_EN at 0 range 20 .. 20;
         SPI6_EN at 0 range 21 .. 21;
         SAI1_EN at 0 range 22 .. 22;
         LTDC_EN at 0 range 26 .. 26;
         Unmapped at 0 range 27 .. 31;
      end record;

   --   Access objects
   RCC_CR_Reg : RCC_CR_Register with Import, Address => System'To_Address (Base_Address + RCC_CR_Offset);
   RCC_CFGR_Reg : RCC_CFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_CFGR_Offset);
   RCC_AHB1ENR_Reg : RCC_AHB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB1ENR_Offset);
   RCC_AHB2ENR_Reg : RCC_AHB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB2ENR_Offset);
   RCC_PLLCFGR_Reg : RCC_PLLCFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_PLLCFGR_Offset);
   RCC_APB1ENR_Reg : RCC_APB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB1ENR_Offset);
   RCC_APB2ENR_Reg : RCC_APB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB2ENR_Offset);

end Registers.Stm32f4.Rcc;
