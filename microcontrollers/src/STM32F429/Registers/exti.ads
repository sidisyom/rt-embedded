with Common_Types;
with System;

package EXTI is
   
   Base_Address : constant  := 16#40013C00#;
   EXTI_IMR_Offset : constant := 16#00#;
   EXTI_FTSR_Offset : constant := 16#0C#;
   EXTI_PR_Offset : constant := 16#14#;
   
   type EXTI_IMR_Register is
      record
         MR0 : Common_Types.Bit_State;
         MR1 : Common_Types.Bit_State;
         MR2 : Common_Types.Bit_State;
         MR3 : Common_Types.Bit_State;
         MR4 : Common_Types.Bit_State;
         MR5 : Common_Types.Bit_State;
         MR6 : Common_Types.Bit_State;
         MR7 : Common_Types.Bit_State;
         MR8 : Common_Types.Bit_State;
         MR9 : Common_Types.Bit_State;
         MR10 : Common_Types.Bit_State;
         MR11 : Common_Types.Bit_State;
         MR12 : Common_Types.Bit_State;
         MR13 : Common_Types.Bit_State;
         MR14 : Common_Types.Bit_State;
         MR15 : Common_Types.Bit_State;
         MR16 : Common_Types.Bit_State;
         MR17 : Common_Types.Bit_State;
         MR18 : Common_Types.Bit_State;
         MR19 : Common_Types.Bit_State;
         MR20 : Common_Types.Bit_State;
         MR21 : Common_Types.Bit_State;
         MR22 : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 9);
      end record
     with 
       Volatile_Full_Access, 
       Bit_Order => System.Low_Order_First,
       Object_Size => 32;
      
   for EXTI_IMR_Register use
      record
         MR0 at 0 range 0 .. 0;
         MR1 at 0 range 1 .. 1;
         MR2 at 0 range 2 .. 2;
         MR3 at 0 range 3 .. 3;
         MR4 at 0 range 4 .. 4;
         MR5 at 0 range 5 .. 5;
         MR6 at 0 range 6 .. 6;
         MR7 at 0 range 7 .. 7;
         MR8 at 0 range 8 .. 8;
         MR9 at 0 range 9 .. 9;
         MR10 at 0 range 10 .. 10;
         MR11 at 0 range 11 .. 11;
         MR12 at 0 range 12 .. 12;
         MR13 at 0 range 13 .. 13;
         MR14 at 0 range 14 .. 14;
         MR15 at 0 range 15 .. 15;
         MR16 at 0 range 16 .. 16;
         MR17 at 0 range 17 .. 17;
         MR18 at 0 range 18 .. 18;
         MR19 at 0 range 19 .. 19;
         MR20 at 0 range 20 .. 20;
         MR21 at 0 range 21 .. 21;
         MR22 at 0 range 22 .. 22;
         Unmapped at 0 range 23 .. 31;
      end record;
   
   type EXTI_FTSR_Register is
      record
         TR0 : Common_Types.Bit_State;
         TR1 : Common_Types.Bit_State;
         TR2 : Common_Types.Bit_State;
         TR3 : Common_Types.Bit_State;
         TR4 : Common_Types.Bit_State;
         TR5 : Common_Types.Bit_State;
         TR6 : Common_Types.Bit_State;
         TR7 : Common_Types.Bit_State;
         TR8 : Common_Types.Bit_State;
         TR9 : Common_Types.Bit_State;
         TR10 : Common_Types.Bit_State;
         TR11 : Common_Types.Bit_State;
         TR12 : Common_Types.Bit_State;
         TR13 : Common_Types.Bit_State;
         TR14 : Common_Types.Bit_State;
         TR15 : Common_Types.Bit_State;
         TR16 : Common_Types.Bit_State;
         TR17 : Common_Types.Bit_State;
         TR18 : Common_Types.Bit_State;
         TR19 : Common_Types.Bit_State;
         TR20 : Common_Types.Bit_State;
         TR21 : Common_Types.Bit_State;
         TR22 : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 9);
      end record
     with 
       Volatile_Full_Access, 
       Bit_Order => System.Low_Order_First,
       Object_Size => 32;
   
   for EXTI_FTSR_Register use
      record
         TR0 at 0 range 0 .. 0;
         TR1 at 0 range 1 .. 1;
         TR2 at 0 range 2 .. 2;
         TR3 at 0 range 3 .. 3;
         TR4 at 0 range 4 .. 4;
         TR5 at 0 range 5 .. 5;
         TR6 at 0 range 6 .. 6;
         TR7 at 0 range 7 .. 7;
         TR8 at 0 range 8 .. 8;
         TR9 at 0 range 9 .. 9;
         TR10 at 0 range 10 .. 10;
         TR11 at 0 range 11 .. 11;
         TR12 at 0 range 12 .. 12;
         TR13 at 0 range 13 .. 13;
         TR14 at 0 range 14 .. 14;
         TR15 at 0 range 15 .. 15;
         TR16 at 0 range 16 .. 16;
         TR17 at 0 range 17 .. 17;
         TR18 at 0 range 18 .. 18;
         TR19 at 0 range 19 .. 19;
         TR20 at 0 range 20 .. 20;
         TR21 at 0 range 21 .. 21;
         TR22 at 0 range 22 .. 22;
         Unmapped at 0 range 23 .. 31;
      end record;
   
   type EXTI_PR_Register is
      record
         PR0 : Common_Types.Bit_State;
         PR1 : Common_Types.Bit_State;
         PR2 : Common_Types.Bit_State;
         PR3 : Common_Types.Bit_State;
         PR4 : Common_Types.Bit_State;
         PR5 : Common_Types.Bit_State;
         PR6 : Common_Types.Bit_State;
         PR7 : Common_Types.Bit_State;
         PR8 : Common_Types.Bit_State;
         PR9 : Common_Types.Bit_State;
         PR10 : Common_Types.Bit_State;
         PR11 : Common_Types.Bit_State;
         PR12 : Common_Types.Bit_State;
         PR13 : Common_Types.Bit_State;
         PR14 : Common_Types.Bit_State;
         PR15 : Common_Types.Bit_State;
         PR16 : Common_Types.Bit_State;
         PR17 : Common_Types.Bit_State;
         PR18 : Common_Types.Bit_State;
         PR19 : Common_Types.Bit_State;
         PR20 : Common_Types.Bit_State;
         PR21 : Common_Types.Bit_State;
         PR22 : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 9);
      end record with 
     Volatile_Full_Access, 
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;
   
   for EXTI_PR_Register use
      record
         PR0 at 0 range 0 .. 0;
         PR1 at 0 range 1 .. 1;
         PR2 at 0 range 2 .. 2;
         PR3 at 0 range 3 .. 3;
         PR4 at 0 range 4 .. 4;
         PR5 at 0 range 5 .. 5;
         PR6 at 0 range 6 .. 6;
         PR7 at 0 range 7 .. 7;
         PR8 at 0 range 8 .. 8;
         PR9 at 0 range 9 .. 9;
         PR10 at 0 range 10 .. 10;
         PR11 at 0 range 11 .. 11;
         PR12 at 0 range 12 .. 12;
         PR13 at 0 range 13 .. 13;
         PR14 at 0 range 14 .. 14;
         PR15 at 0 range 15 .. 15;
         PR16 at 0 range 16 .. 16;
         PR17 at 0 range 17 .. 17;
         PR18 at 0 range 18 .. 18;
         PR19 at 0 range 19 .. 19;
         PR20 at 0 range 20 .. 20;
         PR21 at 0 range 21 .. 21;
         PR22 at 0 range 22 .. 22;
         Unmapped at 0 range 23 .. 31;
      end record;
      
   EXTI_IMR_Reg : EXTI_IMR_Register with Import, Address => System'To_Address (Base_Address + EXTI_IMR_Offset);
   EXTI_FTSR_Reg : EXTI_FTSR_Register with Import, Address => System'To_Address (Base_Address + EXTI_FTSR_Offset);
   EXTI_PR_Reg : EXTI_PR_Register with Import, Address => System'To_Address (Base_Address + EXTI_PR_Offset);
end EXTI;
