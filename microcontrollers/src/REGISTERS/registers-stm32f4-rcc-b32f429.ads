package Registers.Stm32f4.Rcc.B32f429 is

   --  Address definitions
   Base_Address : constant := 16#4002_3800#;
   RCC_CR_Offset : constant := 16#00#;
   RCC_PLLCFGR_Offset : constant := 16#04#;
   RCC_CFGR_Offset : constant := 16#08#;
   RCC_AHB1ENR_Offset : constant := 16#30#;
   RCC_AHB2ENR_Offset : constant := 16#34#;
   RCC_APB1ENR_Offset : constant := 16#40#;
   RCC_APB2ENR_Offset : constant := 16#44#;

   --   Access objects
   RCC_CR_Reg : RCC_CR_Register with Import, Address => System'To_Address (Base_Address + RCC_CR_Offset);
   RCC_CFGR_Reg : RCC_CFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_CFGR_Offset);
   RCC_AHB1ENR_Reg : RCC_AHB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB1ENR_Offset);
   RCC_AHB2ENR_Reg : RCC_AHB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_AHB2ENR_Offset);
   RCC_PLLCFGR_Reg : RCC_PLLCFGR_Register with Import, Address => System'To_Address (Base_Address + RCC_PLLCFGR_Offset);
   RCC_APB1ENR_Reg : RCC_APB1ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB1ENR_Offset);
   RCC_APB2ENR_Reg : RCC_APB2ENR_Register with Import, Address => System'To_Address (Base_Address + RCC_APB2ENR_Offset);

end Registers.Stm32f4.Rcc.B32f429;
