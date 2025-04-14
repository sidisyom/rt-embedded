with System;
with Common_Types; use Common_Types;

package RCC is

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

   type AHB_Prescaler_Value is (AHB_Not_Divided, AHB_Pre_2, AHB_Pre_4, AHB_Pre_8, AHB_Pre_16, AHB_Pre_64, AHB_Pre_128, AHB_Pre_256, AHB_Pre_512);
   for AHB_Prescaler_Value use (AHB_Not_Divided => 2#0#,
                                AHB_Pre_2 => 2#1000#,
                                AHB_Pre_4 => 2#1001#,
                                AHB_Pre_8 => 2#1010#,
                                AHB_Pre_16 => 2#1011#,
                                AHB_Pre_64 => 2#1100#,
                                AHB_Pre_128 => 2#1101#,
                                AHB_Pre_256 => 2#1110#,
                                AHB_Pre_512 => 2#1111#);

   type APB_Prescaler_Value is (APB_NO_DIV, APB_DIV_2, APB_DIV_4, APB_DIV_8, APB_DIV_16);
   for APB_Prescaler_Value use (APB_NO_DIV => 2#000#,
                                APB_DIV_2 => 2#100#,
                                APB_DIV_4 => 2#101#,
                                APB_DIV_8 => 2#110#,
                                APB_DIV_16 => 2#111#);

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
                              PLL => 2#11#);

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
         HSI_On : Bit_State;
         HSI_Rdy : Bit_State;
         Unmapped1 : Arbitrary_Unmapped_Space (1 .. 1);
         HSITRIM : HSITRIM_Value;
         Unmapped2 : Arbitrary_Unmapped_Space (1 .. 8);
         HSE_On : Bit_State;
         HSE_Rdy : Bit_State;
         Unmapped3 : Arbitrary_Unmapped_Space (1 .. 6);
         PLLON : Bit_State;
         PLLRDY : Bit_State;
         PLLI2SON : Bit_State;
         PLLI2SRDY : Bit_State;
         Unmapped4 : Arbitrary_Unmapped_Space (1 .. 4);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_CR_Register use
      record
         HSI_On at 0 range 0 .. 0;
         HSI_Rdy at 0 range 1 .. 1;
         Unmapped1 at 0 range 2 .. 2;
         HSITRIM at 0 range 3 .. 7;
         Unmapped2 at 0 range 8 .. 15;
         HSE_On at 0 range 16 .. 16;
         HSE_Rdy at 0 range 17 .. 17;
         Unmapped3 at 0 range 18 .. 23;
         PLLON at 0 range 24 .. 24;
         PLLRDY at 0 range 25 .. 25;
         PLLI2SON at 0 range 26 .. 26;
         PLLI2SRDY at 0 range 27 .. 27;
         Unmapped4 at 0 range  28 .. 31;
      end record;

   type RCC_CFGR_Register is
      record
         SW : Clock_Source;
         SWS : Clock_Source;
         HPRE : AHB_Prescaler_Value;
         Reserved : Arbitrary_Unmapped_Space (1 .. 2);
         PPRE1 : APB_Prescaler_Value;
         PPRE2 : APB_Prescaler_Value;
         RTCPRE : RTC_Prescaler_Value;
         MCO1 : MCO1_Clock_Source;
         I2SSCR : Bit_State;
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
         Reserved at 0 range 8 .. 9;
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
         GPIO_PORT_A : Peripheral_State;
         GPIO_PORT_B : Peripheral_State;
         GPIO_PORT_C : Peripheral_State;
         GPIO_PORT_D : Peripheral_State;
         GPIO_PORT_E : Peripheral_State;
         GPIO_PORT_F : Peripheral_State;
         GPIO_PORT_G : Peripheral_State;
         GPIO_PORT_H : Peripheral_State;
         GPIO_PORT_I : Peripheral_State;
         Unmapped : Arbitrary_Unmapped_Space (1 .. 23);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_AHB1ENR_Register use
      record
         GPIO_PORT_A at 0 range 0 .. 0;
         GPIO_PORT_B at 0 range 1 .. 1;
         GPIO_PORT_C at 0 range 2 .. 2;
         GPIO_PORT_D at 0 range 3 .. 3;
         GPIO_PORT_E at 0 range 4 .. 4;
         GPIO_PORT_F at 0 range 5 .. 5;
         GPIO_PORT_G at 0 range 6 .. 6;
         GPIO_PORT_H at 0 range 7 .. 7;
         GPIO_PORT_I at 0 range 8 .. 8;
         Unmapped at 0 range 9 .. 31;
      end record;

   type RCC_AHB2ENR_Register is
      record
         DCMIEN : Common_Types.Bit_State;
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 3);
         CRYPEN    : Common_Types.Bit_State;
         HASHEN    : Common_Types.Bit_State;
         RNGEN     : Common_Types.Bit_State;
         OTGFSEN   : Common_Types.Bit_State;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 23);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_AHB2ENR_Register use
      record
         DCMIEN at 0 range 0 .. 0;
         Unmapped1 at 0 range 1 .. 3;
         CRYPEN at 0 range 4 .. 4;
         HASHEN at 0 range 5 .. 5;
         RNGEN at 0 range 6 .. 6;
         OTGFSEN at 0 range 7 .. 7;
         Unmapped2 at 0 range 8 .. 31;
      end record;

   type RCC_PLLCFGR_Register is
      record
         PLLM : PLLM_Values;
         PLLN : PLLN_Values;
         Unmapped1 : Arbitrary_Unmapped_Space (1 .. 1);
         PLLP : PLLP_Prescaler;
         Unmapped2 : Arbitrary_Unmapped_Space (1 .. 4);
         PLLSRC : PLL_Source;
         Unmapped3 : Arbitrary_Unmapped_Space (1 .. 1);
         PLLQ : PLLQ_Values;
         Unmapped4 : Arbitrary_Unmapped_Space (1 .. 4);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_PLLCFGR_Register use
      record
         PLLM at 0 range 0 .. 5;
         PLLN at 0 range 6 .. 14;
         Unmapped1 at 0 range 15 .. 15;
         PLLP at 0 range 16 .. 17;
         Unmapped2 at 0 range 18 .. 21;
         PLLSRC at 0 range 22 .. 22;
         Unmapped3 at 0 range 23 .. 23;
         PLLQ at 0 range 24 .. 27;
         Unmapped4 at 0 range 28 .. 31;
      end record;

   type RCC_APB1ENR_Register is
      record
         TIM2_EN : Bit_State;
         TIM3_EN : Bit_State;
         TIM4_EN : Bit_State;
         TIM5_EN : Bit_State;
         TIM6_EN : Bit_State;
         TIM7_EN : Bit_State;
         TIM12_EN : Bit_State;
         TIM13_EN : Bit_State;
         TIM14_EN : Bit_State;
         Reserved_1 : Arbitrary_Unmapped_Space (1 .. 2);
         WWDG_En : Bit_State;
         Reserved_2 : Arbitrary_Unmapped_Space (1 .. 2);
         SPI2_EN : Bit_State;
         SPI3_EN : Bit_State;
         Reserved_3 : Arbitrary_Unmapped_Space (1 .. 1);
         USART2_EN : Bit_State;
         USART3_EN : Bit_State;
         UART4_EN : Bit_State;
         UART5_EN : Bit_State;
         I2C1_EN : Bit_State;
         I2C2_EN : Bit_State;
         I2C3_EN : Bit_State;
         Reserved_4 : Arbitrary_Unmapped_Space (1 .. 1);
         CAN1_EN : Bit_State;
         CAN2_EN  : Bit_State;
         Reserved_5 : Arbitrary_Unmapped_Space (1 .. 1);
         PWR_EN : Bit_State;
         DAC_EN : Bit_State;
         UART7_EN : Bit_State;
         UART8_EN : Bit_State;
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
         Reserved_1 at 0 range 9 .. 10;
         WWDG_En at 0 range 11 .. 11;
         Reserved_2 at 0 range 12 .. 13;
         SPI2_EN at 0 range 14 .. 14;
         SPI3_EN at 0 range 15 .. 15;
         Reserved_3 at 0 range 16 .. 16;
         USART2_EN at 0 range 17 .. 17;
         USART3_EN at 0 range 18 .. 18;
         UART4_EN at 0 range 19 .. 19;
         UART5_EN at 0 range 20 .. 20;
         I2C1_EN at 0 range 21 .. 21;
         I2C2_EN at 0 range 22 .. 22;
         I2C3_EN at 0 range 23 .. 23;
         Reserved_4 at 0 range 24 .. 24;
         CAN1_EN at 0 range 25 .. 25;
         CAN2_EN at 0 range 26 .. 26;
         Reserved_5 at 0 range 27 .. 27;
         PWR_EN at 0 range 28 .. 28;
         DAC_EN at 0 range 29 .. 29;
         UART7_EN at 0 range 30 .. 30;
         UART8_EN at 0 range 31 .. 31;
      end record;

   type RCC_APB2ENR_Register is
      record
         TIM1_EN : Bit_State;
         TIM8_EN : Bit_State;
         Unmapped_1 : Arbitrary_Unmapped_Space (1 .. 2);
         USART1_EN : Bit_State;
         USART6_EN : Bit_State;
         Unmapped_2 : Arbitrary_Unmapped_Space (1 .. 2);
         ADC1_EN : Bit_State;
         ADC2_EN : Bit_State;
         ADC3_EN : Bit_State;
         SDIO_EN : Bit_State;
         SPI1_EN : Bit_State;
         SPI4_EN : Bit_State;
         SYSCFG_EN : Bit_State;
         Unmapped_3 : Arbitrary_Unmapped_Space (1 .. 1);
         TIM9_EN : Bit_State;
         TIM10_EN : Bit_State;
         TIM11_EN : Bit_State;
         Unmapped_4 : Arbitrary_Unmapped_Space (1 .. 1);
         SPI5_EN : Bit_State;
         SPI6_EN : Bit_State;
         SAI1_EN : Bit_State;
         Unmapped_5 : Arbitrary_Unmapped_Space (1 .. 3);
         LTDC_EN : Bit_State;
         Unmapped_6 : Arbitrary_Unmapped_Space (1 .. 5);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RCC_APB2ENR_Register use
      record
         TIM1_EN at 0 range 0 .. 0;
         TIM8_EN at 0 range 1 .. 1;
         Unmapped_1 at 0 range 2 .. 3;
         USART1_EN at 0 range 4 .. 4;
         USART6_EN at 0 range 5 .. 5;
         Unmapped_2 at 0 range 6 .. 7;
         ADC1_EN at 0 range 8 .. 8;
         ADC2_EN at 0 range 9 .. 9;
         ADC3_EN at 0 range 10 .. 10;
         SDIO_EN at 0 range 11 .. 11;
         SPI1_EN at 0 range 12 .. 12;
         SPI4_EN at 0 range 13 .. 13;
         SYSCFG_EN at 0 range 14 .. 14;
         Unmapped_3 at 0 range 15 .. 15;
         TIM9_EN at 0 range 16 .. 16;
         TIM10_EN at 0 range 17 .. 17;
         TIM11_EN at 0 range 18 .. 18;
         Unmapped_4 at 0 range 19 .. 19;
         SPI5_EN at 0 range 20 .. 20;
         SPI6_EN at 0 range 21 .. 21;
         SAI1_EN at 0 range 22 .. 22;
         Unmapped_5 at 0 range 23 .. 25;
         LTDC_EN at 0 range 26 .. 26;
         Unmapped_6 at 0 range 27 .. 31;
      end record;

   RCC_CR_Reg : RCC_CR_Register with Import, Address => System'To_Address (Base_Address + RCC_CR_Offset);
   RCC_CFGR_Reg : RCC_CFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_CFGR_Offset);
   RCC_AHB1ENR_Reg : RCC_AHB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB1ENR_Offset);
   RCC_AHB2ENR_Reg : RCC_AHB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB2ENR_Offset);
   RCC_PLLCFGR_Reg : RCC_PLLCFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_PLLCFGR_Offset);
   RCC_APB1ENR_Reg : RCC_APB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB1ENR_Offset);
   RCC_APB2ENR_Reg : RCC_APB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB2ENR_Offset);
end RCC;
