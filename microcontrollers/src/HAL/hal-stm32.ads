with Registers;

package Hal.Stm32 is

   type GPIO_Port is (A, B, C, D, E, F, G, H, I, J, K);
   type GPIO_Pin is range 0 .. 15;
   type Pin_Mode is (Input, Output, Alternate_Function, Analog);
   type Binary_State is (Off, On);

   --   Probably, best not to inline the To_Internal_** functions as these are called quite often
   function To_Internal_Port (P : GPIO_Port) return Registers.GPIO_Port is (case P is
                                                                                when A => Registers.A,
                                                                                when B => Registers.B,
                                                                                when C => Registers.C,
                                                                                when D => Registers.D,
                                                                                when E => Registers.E,
                                                                                when F => Registers.F,
                                                                                when G => Registers.G,
                                                                                when H => Registers.H,
                                                                                when I => Registers.I,
                                                                                when J => Registers.J,
                                                                               when K => Registers.K);

   function To_Internal_Pin (P : GPIO_Pin) return Registers.GPIO_Pin is (Registers.GPIO_Pin (P));

   function To_Internal_Pin_Mode (M : Pin_Mode) return Registers.Pin_Mode is (case M is
                                                                                 when Input => Registers.Input,
                                                                                 when Output => Registers.Output,
                                                                                 when Alternate_Function => Registers.Alternate_Function,
                                                                                 when Analog             => Registers.Analog);

   function To_Internal_Binary_State (S : Binary_State) return Registers.Binary_State is (case S is
                                                                                             when Off => Registers.Off,
                                                                                             when On => Registers.On);
end Hal.Stm32;
