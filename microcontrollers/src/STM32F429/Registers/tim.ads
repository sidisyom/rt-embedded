with Common_Types;
with System;
with Interfaces;

package TIM is

   TIM6_Base_Address : constant := 16#40001000#;

   TIM_6_7_CR1_Offset : constant := 16#00#;
   TIM_6_7_CR2_Offset : constant := 16#04#;
   TIM_6_7_DIER_Offset : constant := 16#0C#;
   TIM_6_7_SR_Offset   : constant := 16#10#;
   TIM_6_7_EGR_Offset  : constant := 16#14#;
   TIM_6_7_CNT_Offset  : constant := 16#24#;
   TIM_6_7_PSC_Offset  : constant := 16#28#;
   TIM_6_7_ARR_Offset  : constant := 16#2C#;

   type TIM_6_7_CR1_Register is
      record
         CEN : Common_Types.Bit_State;
         UDIS : Common_Types.Bit_State;
         URS  : Common_Types.Bit_State;
         OPM  : Common_Types.Bit_State;
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 3);
         ARPE      : Common_Types.Bit_State;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 8);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_CR1_Register use
      record
         CEN at 0 range 0 .. 0;
         UDIS at 0 range 1 .. 1;
         URS at 0 range 2 .. 2;
         OPM at 0 range 3 .. 3;
         Unmapped1 at 0 range 4 .. 6;
         ARPE at 0 range 7 .. 7;
         Unmapped2 at 0 range 8 .. 15;
      end record;

   type Master_Mode_Selection is (Reset, Enable, Update);
   for Master_Mode_Selection use (Reset  => 2#000#,
                                  Enable => 2#001#,
                                  Update => 2#010#);

   type TIM_6_7_CR2_Register is
      record
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 4);
         MMS       : Master_Mode_Selection;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 9);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_CR2_Register use
      record
         Unmapped1 at 0 range 0 .. 3;
         MMS at 0 range 4 .. 6;
         Unmapped2 at 0 range 7 .. 15;
      end record;

   type TIM_6_7_DIER_Register is
      record
         UIE : Common_Types.Bit_State;
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 7);
         UDE       : Common_Types.Bit_State;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 7);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_DIER_Register use
      record
         UIE at 0 range 0 .. 0;
         Unmapped1 at 0 range 1 .. 7;
         UDE at 0 range 8 .. 8;
         Unmapped2 at 0 range 9 .. 15;
      end record;

   type TIM_6_7_SR_Register is
      record
         UIF : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 15);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_SR_Register use
      record
         UIF at 0 range 0 .. 0;
         Unmapped at 0 range 1 .. 15;
      end record;

   type TIM_6_7_EGR_Register is
      record
         UG : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 15);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_EGR_Register use
      record
         UG at 0 range 0 .. 0;
         Unmapped at 0 range 1 .. 15;
      end record;

   type TIM_6_7_CNT_Register is
      record
         CNT : Interfaces.Unsigned_16;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_CNT_Register use
      record
         CNT at 0 range 0 .. 15;
      end record;

   type TIM_6_7_PSC_Register is
      record
         PSC : Interfaces.Unsigned_16;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_PSC_Register use
      record
         PSC at 0 range 0 .. 15;
      end record;

   type TIM_6_7_ARR_Register is
      record
         ARR : Interfaces.Unsigned_16;
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 16;

   for TIM_6_7_ARR_Register use
      record
         ARR at 0 range 0 .. 15;
      end record;

   TIM6_CR1_Reg : TIM_6_7_CR1_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_CR1_Offset);
   TIM6_CR2_Reg : TIM_6_7_CR2_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_CR2_Offset);
   TIM6_DIER_Reg : TIM_6_7_DIER_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_DIER_Offset);
   TIM6_SR_Reg   : TIM_6_7_SR_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_SR_Offset);
   TIM6_EGR_Reg  : TIM_6_7_EGR_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_EGR_Offset);
   TIM6_CNT_Reg  : TIM_6_7_CNT_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_CNT_Offset);
   TIM6_PSC_Reg  : TIM_6_7_PSC_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_PSC_Offset);
   TIM6_CR1_ARR : TIM_6_7_ARR_Register with Import, Address => System'To_Address (TIM6_Base_Address + TIM_6_7_ARR_Offset);

end TIM;
