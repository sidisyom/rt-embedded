with Hal.Stm32.Stm32f429;
with Registers.Stm32f4;

with System.BB.CPU_Primitives;

procedure Microcontrollers is
begin
   declare
      use Registers.Stm32f4;
      Request : constant Hal.Stm32.GPIO_Configuration_Request := (Port => Registers.Stm32f4.G,
                                                                  Pin  => 13,
                                                                  Mode => Registers.Stm32f4.Output);
      Current_State : Registers.Stm32f4.Binary_State := Registers.Stm32f4.On;
   begin
      Hal.Stm32.Stm32f429.Configure_Gpio (Request);
      loop
         Hal.Stm32.Stm32f429.Set_Pin_State (Port => Request.Port, Pin => Request.Pin, State => Current_State);
         Current_State := (if Current_State = Registers.Stm32f4.On then Registers.Stm32f4.Off else Registers.Stm32f4.On);

         delay 2.0;
      end loop;
   end;
end Microcontrollers;
