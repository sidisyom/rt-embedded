with Registers.Stm32f4;

package Hal.Stm32 is

   type GPIO_Configuration_Request is
      record
         Port : Registers.Stm32f4.GPIO_Port;
         Pin  : Registers.Stm32f4.GPIO_Pin;
         Mode : Registers.Stm32f4.Pin_Mode := Registers.Stm32f4.Output;
      end record;
end Hal.Stm32;
