package Registers is
   type GPIO_Port is (A, B, C, D, E, F, G, H, I, J, K) with Size => 4;

   type GPIO_Pin is range 0 .. 15;

   type Binary_State is (Off, On) with Size => 1;

   type Pin_Mode is (Input,
                     Output,
                     Alternate_Function,
                     Analog) with Size => 2;

   type Compact_Pins is array (GPIO_Pin) of Binary_State with
     Size => 16,
     Component_Size => 1;

   type Compact_Ports is array (GPIO_Port) of Binary_State with
     Size => 11,
     Component_Size => 1;
end Registers;
