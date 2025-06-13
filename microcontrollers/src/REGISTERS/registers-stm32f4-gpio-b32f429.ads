package Registers.Stm32f4.Gpio.B32f429 is

   Base_Address : constant := 16#4002_0000#;

   GPIO_Registers : GPIO_Registers_Array with Import, Address => System'To_Address (Base_Address);

end Registers.Stm32f4.Gpio.B32f429;
