with Registers.Stm32f4.Rcc.B32f429;
with Registers.Stm32f4.Gpio.B32f429;

package body Hal.Stm32.Stm32f429 is

   procedure Configure_Gpio (CR : GPIO_Configuration_Request) is
   begin
      Registers.Stm32f4.Rcc.B32f429.RCC_AHB1ENR_Reg.PORT_CLOCK_EN (To_Internal_Port (CR.Port)) := Registers.On;
      Registers.Stm32f4.Gpio.B32f429.GPIO_Registers (To_Internal_Port (CR.Port)).MODER (To_Internal_Pin (CR.Pin)) := To_Internal_Pin_Mode (CR.Mode);
   end Configure_Gpio;

   procedure Set_Pin_State (Port : GPIO_Port;
                            Pin   : GPIO_Pin;
                            State : Binary_State) is
   begin
      Registers.Stm32f4.Gpio.B32f429.GPIO_Registers (To_Internal_Port (Port)).ODR.Pin_Values (To_Internal_Pin (Pin)) := To_Internal_Binary_State (State);
   end Set_Pin_State;
end Hal.Stm32.Stm32f429;
