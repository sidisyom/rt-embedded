package Hal.Stm32.Gpio is

   type GPIO_Configuration_Request is
      record
         Port : GPIO_Port;
         Pin  : GPIO_Pin;
         Mode : Pin_Mode := Output;
      end record;

   procedure Configure_Gpio (CR : GPIO_Configuration_Request);

   procedure Set_Pin_State (Port : GPIO_Port;
                            Pin   : GPIO_Pin;
                            State : Binary_State);

end Hal.Stm32.Gpio;
