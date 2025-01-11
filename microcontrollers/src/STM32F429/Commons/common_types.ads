package Common_Types is

   type Peripheral_State is (Disabled,
                             Enabled);
   for Peripheral_State use (Disabled => 2#0#,
                             Enabled => 2#1#);
   
   type Bit_State is (Off,
                      On) with Size => 1;
   for Bit_State use (Off => 2#0#,
                      On => 2#1#);
   
   type GPIO_Port is (A, B, C, D, E, F, G, H, I);
   for GPIO_Port use (A => 0,
                      B => 1,
                      C => 2,
                      D => 3,
                      E => 4,
                      F => 5,
                      G => 6,
                      H => 7,
                      I => 8);
   
   type Unsigned_4 is mod 2 ** 4 with Size => 4;
   type Unsigned_8 is mod 2**8;
   type Unsigned_24 is mod 2**24;
   type GPIO_Pin is mod 16;
   type ADC_Channel is mod 19 with Size => 5;
   type Conversion_Count is mod 16 with Size => 4;
   
   type Compact_Pins is array (GPIO_Pin) of Bit_State with
     Size => 16,
     Component_Size => 1;
   
   type Arbitrary_Unmapped_Space is array (Positive range <>) of Boolean with
     Component_Size => 1, Unreferenced;
   
   type Byte_Unmapped_Space is array (Positive range <>) of Unsigned_8 with
     Component_Size => Unsigned_8'Size, Unreferenced;
      
   type Partially_Mapped is array (GPIO_Port) of Boolean with
     Size => 32, Component_Size => 1, Unreferenced;
   
   subtype Interrupt_Channel is Integer range 1 .. 91; -- STM32F42xxx supports up to 91 interrupt channels
   
   type Bit_Array is array (Natural range <>) of Bit_State with Component_Size => 1;

end Common_Types;
