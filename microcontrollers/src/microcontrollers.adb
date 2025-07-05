with Hal.Stm32;
with Hal.Stm32.Stm32f429;

procedure Microcontrollers is
begin
   declare
      use Hal.Stm32;
      Request : constant Hal.Stm32.GPIO_Configuration_Request := (Port => G,
                                                                  Pin  => 13,
                                                                  Mode => Output);
      Current_State : Binary_State := On;
   begin
      Hal.Stm32.Stm32f429.Configure_Gpio (Request);
      loop
         Hal.Stm32.Stm32f429.Set_Pin_State (Port => Request.Port, Pin => Request.Pin, State => Current_State);
         Current_State := (if Current_State = On then Off else On);
         delay 2.0;
      end loop;
   end;
end Microcontrollers;
