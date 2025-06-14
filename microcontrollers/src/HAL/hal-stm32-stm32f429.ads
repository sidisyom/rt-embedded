with Registers.Stm32f4;

package Hal.Stm32.Stm32f429 is

   procedure Configure_Gpio (CR : GPIO_Configuration_Request);

   procedure Set_Pin_State (Port : Registers.Stm32f4.GPIO_Port;
                            Pin   : Registers.Stm32f4.GPIO_Pin;
                            State : Registers.Stm32f4.Binary_State);

end Hal.Stm32.Stm32f429;
