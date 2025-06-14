with Registers.Stm32f4.Rcc.B32f429;
with Registers.Stm32f4.Gpio.B32f429;

package body Hal.Stm32.Stm32f429 is

   procedure Configure_Gpio (CR : GPIO_Configuration_Request) is
   begin
      Registers.Stm32f4.Rcc.B32f429.RCC_AHB1ENR_Reg.PORT_CLOCK_EN (CR.Port) := Registers.Stm32f4.On;
      Registers.Stm32f4.Gpio.B32f429.GPIO_Registers (CR.Port).MODER (CR.Pin) := CR.Mode;
   end Configure_Gpio;

   procedure Set_Pin_State (Port : Registers.Stm32f4.GPIO_Port;
                            Pin   : Registers.Stm32f4.GPIO_Pin;
                            State : Registers.Stm32f4.Binary_State) is
   begin
      Registers.Stm32f4.Gpio.B32f429.GPIO_Registers (Port).ODR.Pin_Values (Pin) := State;
   end Set_Pin_State;

end Hal.Stm32.Stm32f429;
