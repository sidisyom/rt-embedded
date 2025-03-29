with Common_Types;
with System;

package SYSCFG is
   
   Base_Address : constant := 16#40013800#;
   EXTICR_Offset : constant := 16#08#;
   
   type EXTI_Port is (PA,
                      PB,
                      PC,
                      PD,
                      PE,
                      PF,
                      PG,
                      PH,
                      PI) with size => 4;
   for EXTI_Port use (
                      PA => 2#0000#,
                      PB => 2#0001#,
                      PC => 2#0010#,
                      PD => 2#0011#,
                      PE => 2#0100#,
                      PF => 2#0101#,
                      PG => 2#0110#,
                      PH => 2#0111#,
                      PI => 2#1000#);
         
   type SYSCFG_EXTICR_Register is
      record
         EXTIO : EXTI_Port;
         EXTI1 : EXTI_Port;
         EXTI2 : EXTI_Port;
         EXTI3 : EXTI_Port;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 15);
      end record with
     Volatile_Full_Access,
     Bit_Order => System.Low_Order_First,
     Object_Size => 32;     
   
   for SYSCFG_EXTICR_Register use
      record
         EXTIO at 0 range 0 .. 3;
         EXTI1 at 0 range 4 .. 7;
         EXTI2 at 0 range 8 .. 11;
         EXTI3 at 0 range 12 .. 15;
         Unmapped at 0 range 16 .. 31;
      end record;
   
   type SYSCFG_EXTICR_Bank is array (1 .. 4) of SYSCFG_EXTICR_Register with Volatile, Component_Size => 32;
      
   SYSCFG_EXTICR_Regs : aliased SYSCFG_EXTICR_Bank with Import, Address => System'To_Address (Base_Address + EXTICR_Offset);
end SYSCFG;
