package Registers.Stm32f4 is

   type GPIO_Port is (A, B, C, D, E, F, G, H, I, J, K) with Size => 4;
   for GPIO_Port use (A => 2#0000#,
                      B => 2#0001#,
                      C => 2#0010#,
                      D => 2#0011#,
                      E => 2#0100#,
                      F => 2#0101#,
                      G => 2#0110#,
                      H => 2#0111#,
                      I => 2#1000#,
                      J => 2#1001#,
                      K => 2#1010#);

   type GPIO_Pin is mod 16;

   type Binary_State is (Off, On) with Size => 1;
   for Binary_State use (Off => 2#0#,
                         On  => 2#1#);

   type Pin_Mode is (Input,
                     Output,
                     Alternate_Function,
                     Analog) with Size => 2;
   for Pin_Mode use (Input => 2#00#,
                     Output => 2#01#,
                     Alternate_Function => 2#10#,
                     Analog             => 2#11#);

   type Compact_Pins is array (GPIO_Pin) of Binary_State with
     Size => 16,
     Component_Size => 1;

   type Compact_Ports is array (GPIO_Port) of Binary_State with
     Size => 11,
     Component_Size => 1;
end Registers.Stm32f4;
