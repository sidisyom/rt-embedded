with Common_Types; use Common_Types;
with System;

--   Provides access to the configuration of GPIO ports and the values of their associated pins
package GPIO is
      
   Base_Address : constant := 16#4002_0000#;
            
   type Pin_Mode is (Input,
                     Output,
                     Alternate_Function,
                     Analog);
   for Pin_Mode use (Input => 2#00#,
                     Output => 2#01#,
                     Alternate_Function => 2#10#,
                     Analog => 2#11#);
   
   type Port_Speed is (Low,
                       Medium,
                       High,
                       Very_High);
   for Port_Speed use (Low => 2#00#,
                       Medium => 2#01#,
                       High => 2#10#,
                       Very_High => 2#11#);
   
   type Pull_Configuration is (No_Pull,
                               Pull_Up,
                               Pull_Down);
   for Pull_Configuration use (No_Pull => 2#00#,
                               Pull_Up => 2#01#,
                               Pull_Down => 2#10#);
   
   type Alternate_Function_Type is (AF0,
                               AF1,
                               AF2,
                               AF3,
                               AF4,
                               AF5,
                               AF6,
                               AF7,
                               AF8,
                               AF9,
                               AF10,
                               AF11,
                               AF12,
                               AF13,
                               AF14,
                               AF15);
   for Alternate_Function_Type use (AF0 => 2#0000#,
                               AF1 => 2#0001#,
                               AF2 => 2#0010#,
                               AF3 => 2#0011#,
                               AF4 => 2#0100#,
                               AF5 => 2#0101#,
                               AF6 => 2#0110#,
                               AF7 => 2#0111#,
                               AF8 => 2#1000#,
                               AF9 => 2#1001#,
                               AF10 => 2#1010#,
                               AF11 => 2#1011#,
                               AF12 => 2#1100#,
                               AF13 => 2#1101#,
                               AF14 => 2#1110#,
                               AF15 => 2#1111#);
   
   type MODER_Register is array (GPIO_Pin) of Pin_Mode with
     Volatile_Components,
     Size => 32,
     Component_Size => 2;
   
   type OTYPER_Register is
      record
         OT0 : Bit_State;
         OT1 : Bit_State;
         OT2 : Bit_State;
         OT3 : Bit_State;
         OT4 : Bit_State;
         OT5 : Bit_State;
         OT6 : Bit_State;
         OT7 : Bit_State;
         OT8 : Bit_State;
         OT9 : Bit_State;
         OT10 : Bit_State;
         OT11 : Bit_State;
         OT12 : Bit_State;
         OT13 : Bit_State;
         OT14 : Bit_State;
         OT15 : Bit_State;
         Unmapped : Arbitrary_Unmapped_Space (1 .. 16);
      end record with Volatile, Object_Size => 32;
   
   for OTYPER_Register use
      record
         OT0 at 0 range 0 .. 0;
         OT1 at 0 range 1 .. 1;
         OT2 at 0 range 2 .. 2;
         OT3 at 0 range 3 .. 3;
         OT4 at 0 range 4 .. 4;
         OT5 at 0 range 5 .. 5;
         OT6 at 0 range 6 .. 6;
         OT7 at 0 range 7 .. 7;
         OT8 at 0 range 8 .. 8;
         OT9 at 0 range 9 .. 9;
         OT10 at 0 range 10 .. 10;
         OT11 at 0 range 11 .. 11;
         OT12 at 0 range 12 .. 12;
         OT13 at 0 range 13 .. 13;
         OT14 at 0 range 14 .. 14;
         OT15 at 0 range 15 .. 15;
         Unmapped at 0 range 16 .. 31;
      end record;
   
   type OSPEEDR_Register is array (GPIO_Pin) of Port_Speed with
     Volatile_Components,
     Size => 32,
     Component_Size => 2;
         
   type Pin_Values is
      record
         Pin_Values : Compact_Pins;
         Unmapped : Byte_Unmapped_Space (1 .. 2) with Unreferenced;
      end record with Volatile, Object_Size => 32;
   
   for Pin_Values use
      record
         Pin_Values at 0 range 0 .. 15;
         Unmapped at 0 range 16 .. 31;
      end record;
   
   type PUPDR_Register is array (GPIO_Pin) of Pull_Configuration with
     Volatile_Components,
     Size => 32,
     Component_Size => 2;
      
   type AFRLH_Register is array (GPIO_Pin) of Alternate_Function_Type with
     Volatile_Components,
     Size => 64,
     Component_Size => 4;
         
   type GPIO_Register is
      record
         MODER : MODER_Register;
         OTYPER : OTYPER_Register;
         OSPEEDR : OSPEEDR_Register;
         PUPDR : PUPDR_Register;
         IDR : Pin_Values;
         ODR : Pin_Values;
         Unmapped2 : Byte_Unmapped_Space (1 .. 8); -- following 2 words worth of registers are currently unmapped
         AFRLH : AFRLH_Register;
         Unmapped3 : Byte_Unmapped_Space (1 .. 984); -- required for allignment on the 1024 boundary
      end record with
     Size => 16#400# * 8;
   
   for GPIO_Register use
      record
         MODER at 0 range 0 .. 31;
         OTYPER at 0 range 32 .. 63;
         OSPEEDR at 0 range 64 .. 95;
         PUPDR at 0 range 96 .. 127;
         IDR at 0 range 128 .. 159;
         ODR at 0 range 160 .. 191;
         Unmapped2 at 0 range 192 .. 255;
         AFRLH at 0 range 256 .. 319;
         Unmapped3 at 0 range 320 .. 8191;
      end record;
   
   type GPIO_Registers_Array is array (GPIO_Port) of GPIO_Register with
     Volatile_Components,
     Component_Size => 8192;
   
   --  According to the User Manual, the green LED is connected to I/O PG13,
   --  so the GPIO_Port we're after is "G" and the GPIO_Pin is "13".
   Green_LED_Port : constant GPIO_Port := G;
   Green_LED_Pin : constant GPIO_Pin := 13;
   
   GPIO_Registers : GPIO_Registers_Array with Address => System'To_Address (Base_Address);
end GPIO;
