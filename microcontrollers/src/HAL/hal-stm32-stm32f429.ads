package Hal.Stm32.Stm32f429 is

   procedure Configure_Gpio (CR : GPIO_Configuration_Request);

   procedure Set_Pin_State (Port : GPIO_Port;
                            Pin   : GPIO_Pin;
                            State : Binary_State);

end Hal.Stm32.Stm32f429;
