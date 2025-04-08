with Common_Types;
with System;
with Interfaces;

package RNG is

   RGN_Base_Address : constant := 16#50060800#;
   RNG_CR_Offset    : constant := 16#00#;
   RNG_SR_Offset    : constant := 16#04#;
   RNG_DR_Offset    : constant := 16#08#;

   type RNG_CR_Register is
      record
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 2);
         RNGEN     : Common_Types.Bit_State;
         IE        : Common_Types.Bit_State;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 28);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RNG_CR_Register use
      record
         Unmapped1 at 0 range 0 .. 1;
         RNGEN at 0 range 2 .. 2;
         IE at 0 range 3 .. 3;
         Unmapped2 at 0 range 4 .. 31;
      end record;

   type RNG_SR_Register is
      record
         DRDY : Common_Types.Bit_State;
         CECS : Common_Types.Bit_State;
         SECS : Common_Types.Bit_State;
         Reserved1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 2);
         CEIS      : Common_Types.Bit_State;
         SEIS      : Common_Types.Bit_State;
         Reserved2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 24);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RNG_SR_Register use
      record
         DRDY at 0 range 0 .. 0;
         CECS at 0 range 1 .. 1;
         SECS at 0 range 2 .. 2;
         Reserved1 at 0 range 3 .. 4;
         CEIS at 0 range 5 .. 5;
         SEIS at 0 range 6 .. 6;
         Reserved2 at 0 range 7 .. 31;
      end record;

   type RNG_DR_Register is
      record
         RNDATA : Interfaces.Unsigned_32;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;

   for RNG_DR_Register use
      record
         RNDATA at 0 range 0 .. 31;
      end record;

   RNG_CR_Reg : RNG_CR_Register with Import, Address => System'To_Address (RGN_Base_Address + RNG_CR_Offset);
   RNG_SR_Reg : RNG_SR_Register with Import, Address => System'To_Address (RGN_Base_Address + RNG_SR_Offset);
   RNG_DR_Reg : RNG_DR_Register with Import, Address => System'To_Address (RGN_Base_Address + RNG_DR_Offset);
end RNG;
