with Common_Types;
with System;
with Interfaces;

--   All representation clauses assume registers are laid-out in little-endian order.

package ADC is
   --  Address definitions
   ADCS_Base_Address : constant := 16#4001_2000#;
   ADC1_Base_Address : constant := ADCS_Base_Address + 16#0000_0000#;
   ADC1_SR_Address   : constant := ADC1_Base_Address + 16#00#;
   ADC1_CR1_Address  : constant := ADC1_Base_Address + 16#04#;
   ADC1_CR2_Address  : constant := ADC1_Base_Address + 16#08#;
   ADC1_SMPR1_Address : constant := ADC1_Base_Address + 16#0C#;
   ADC1_SMPR2_Address : constant := ADC1_Base_Address + 16#10#;
   ADC1_SQR1_Address : constant := ADC1_Base_Address + 16#2C#;
   ADC1_SQR2_Address : constant := ADC1_Base_Address + 16#30#;
   ADC1_SQR3_Address  : constant := ADC1_Base_Address + 16#34#;
   ADC1_DR_Address    : constant := ADC1_Base_Address + 16#4C#;
      
   type ADC_SR_Register is
      record
         AWD : Common_Types.Bit_State;
         EOC : Common_Types.Bit_State;
         JEOC : Common_Types.Bit_State;
         JSTRT : Common_Types.Bit_State;
         STRT  : Common_Types.Bit_State;
         OVR   : Common_Types.Bit_State;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 26);
      end record with Volatile, Object_Size => 32;
   for ADC_SR_Register use
      record
         AWD at 0 range 0 .. 0;
         EOC at 0 range 1 .. 1;
         JEOC at 0 range 2 .. 2;
         JSTRT at 0 range 3 .. 3;
         STRT at 0 range 4 .. 4;
         OVR at 0 range 5 .. 5;
         Unmapped at 0 range 6 .. 31;
      end record;
         
   type Watchdog_Channel_Select_Bits is mod 19;
   for Watchdog_Channel_Select_Bits'Size use 5;
   
   type Discontinuous_Mode_Channel_Count is mod 8; --   Value zero is one channel
   for Discontinuous_Mode_Channel_Count'Size use 3;
   
   type Conversion_Resolution is (Bit_12, Bit_10, Bit_8, Bit_6);
   for Conversion_Resolution'Size use 2;
   for Conversion_Resolution use (Bit_12 => 2#00#,
                                  Bit_10 => 2#01#,
                                  Bit_8 => 2#10#,
                                  Bit_6  => 2#11#);
      
   type ADC_CR1_Register is
      record
         AWDCH : Watchdog_Channel_Select_Bits;
         EOCIE : Common_Types.Bit_State;
         AWDIE : Common_Types.Bit_State;
         JEOCIE : Common_Types.Bit_State;
         SCAN   : Common_Types.Bit_State;
         AWDSGL : Common_Types.Bit_State;
         JAUTO  : Common_Types.Bit_State;
         DISCEN : Common_Types.Bit_State;
         JDISCEN : Common_Types.Bit_State;
         DISCNUM : Discontinuous_Mode_Channel_Count;
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 6);
         JAWDEN  : Common_Types.Bit_State;
         AWDEN   : Common_Types.Bit_State;
         RES     : Conversion_Resolution;
         OVRIE   : Common_Types.Bit_State;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 5);
      end record with Volatile, Object_Size => 32;
   for ADC_CR1_Register use
      record
         AWDCH at 0 range 0 .. 4;
         EOCIE at 0 range 5 .. 5;
         AWDIE at 0 range 6 .. 6;
         JEOCIE at 0 range 7 .. 7;
         SCAN at 0 range 8 .. 8;
         AWDSGL at 0 range 9 .. 9;
         JAUTO at 0 range 10 .. 10;
         DISCEN at 0 range 11 .. 11;
         JDISCEN at 0 range 12 .. 12;
         DISCNUM at 0 range 13 .. 15;
         Unmapped1 at 0 range 16 .. 21;
         JAWDEN at 0 range 22 .. 22;
         AWDEN at 0 range 23 .. 23;
         RES at 0 range 24 .. 25;
         OVRIE at 0 range 26 .. 26;
         Unmapped2 at 0 range 27 .. 31;
      end record;
   
   type Conversion_Data_Alignment is (Right, Left) with Size => 1;
   for Conversion_Data_Alignment use (Right => 0, Left => 1);
   type Injected_Conversion_Trigger_Event is (Tim_1_CC4, Timer_1_TRGO, Timer_2_CC1, Timer_2_TRGO, Timer_3_CC2,
                                              Timer_3_CC4, Timer_4_CC1, Timer_4_CC2, Timer_4_CC3, Timer_4_TRGO,
                                              Timer_5_CC4, Timer_5_TRGO, Timer_8_CC2, Timer_8_CC3, Timer_8_CC4,
                                              EXTI_Line15) with Size => 4; --   relying of default incremental values for enumerations
   type Injected_Channels_External_Trigger is (Disabled, Rising_Edge, Falling_Edge, Both_Edges) with Size => 2; --   relying of default incremental values for enumerations
   type Regular_Conversion_Trigger_Event is (Timer_1_CC1, Timer_1_CC2, Timer_1_CC3, Timer_2_CC2, Timer_2_CC3,
                                             Timer_2_CC4, Timer_2_TRGO, Timer_3_CC1, Timer_3_TRGO, Timer_4_CC4,
                                             Timer_5_CC1, Timer_5_CC2, Timer_5_CC3, Timer_8_CC1, Timer_8_TRGO,
                                             EXTI_Line11) with Size => 4;  --   relying of default incremental values for enumerations
   type Regular_Channels_External_Trigger is (Disabled, Rising_Edge, Falling_Edge, Both_Edges) with Size => 2;
   
   type ADC_CR2_Register is
      record
         ADON : Common_Types.Bit_State;
         CONT : Common_Types.Bit_State;
         Unmapped1 : Common_Types.Arbitrary_Unmapped_Space (1 .. 6);
         DMA       : Common_Types.Bit_State;
         DDS       : Common_Types.Bit_State;
         EOCS      : Common_Types.Bit_State;
         ALIGN     : Conversion_Data_Alignment;
         Unmapped2 : Common_Types.Arbitrary_Unmapped_Space (1 .. 4);
         JEXTSEL   : Injected_Conversion_Trigger_Event;
         JEXTEN    : Injected_Channels_External_Trigger;
         JSWSTART  : Common_Types.Bit_State;
         Unmapped3 : Common_Types.Arbitrary_Unmapped_Space (1 .. 1);
         EXTSEL    : Regular_Conversion_Trigger_Event;
         EXTEN     : Regular_Channels_External_Trigger;
         SWSTART   : Common_Types.Bit_State;
         Unmapped4 : Common_Types.Arbitrary_Unmapped_Space (1 .. 1);
      end record with Volatile, Object_Size => 32;
   for ADC_CR2_Register use
      record
         ADON at 0 range 0 .. 0;
         CONT at 0 range 1 .. 1;
         Unmapped1 at 0 range 2 .. 7;
         DMA at 0 range 8 .. 8;
         DDS at 0 range 9 .. 9;
         EOCS at 0 range 10 .. 10;
         ALIGN at 0 range 11 .. 11;
         Unmapped2 at 0 range 12 .. 15;
         JEXTSEL at 0 range 16 .. 19;
         JEXTEN at 0 range 20 .. 21;
         JSWSTART at 0 range 22 .. 22;
         Unmapped3 at 0 range 23 .. 23;
         EXTSEL at 0 range 24 .. 27;
         EXTEN at 0 range 28 .. 29;
         SWSTART at 0 range 30 .. 30;
         Unmapped4 at 0 range 31 .. 31;
      end record;
   --   relying of default incremental values for enumerations
   type Channel_Sampling_Time is (Cycles_3, Cycles_15, Cycles_28, Cycles_56, Cycles_84, Cycles_112, Cycles_144, Cycles_480) with Size => 3;
   
   type ADC_SMPR1_Register is
      record
         SMP10 : Channel_Sampling_Time;
         SMP11 : Channel_Sampling_Time;
         SMP12 : Channel_Sampling_Time;
         SMP13 : Channel_Sampling_Time;
         SMP14 : Channel_Sampling_Time;
         SMP15 : Channel_Sampling_Time;
         SMP16 : Channel_Sampling_Time;
         SMP17 : Channel_Sampling_Time;
         SMP18 : Channel_Sampling_Time;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 5);
      end record with Volatile, Object_Size => 32;
   for ADC_SMPR1_Register use
      record
         SMP10 at 0 range 0 .. 2;
         SMP11 at 0 range 3 .. 5;
         SMP12 at 0 range 6 .. 8;
         SMP13 at 0 range 9 .. 11;
         SMP14 at 0 range 12 .. 14;
         SMP15 at 0 range 15 .. 17;
         SMP16 at 0 range 18 .. 20;
         SMP17 at 0 range 21 .. 23;
         SMP18 at 0 range 24 .. 26;
         Unmapped at 0 range 27 .. 31;
      end record;
   
   type ADC_SMPR2_Register is
      record
         SMP0 : Channel_Sampling_Time;
         SMP1 : Channel_Sampling_Time;
         SMP2 : Channel_Sampling_Time;
         SMP3 : Channel_Sampling_Time;
         SMP4 : Channel_Sampling_Time;
         SMP5 : Channel_Sampling_Time;
         SMP6 : Channel_Sampling_Time;
         SMP7 : Channel_Sampling_Time;
         SMP8 : Channel_Sampling_Time;
         SMP9 : Channel_Sampling_Time;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 2);
      end record with Volatile, Object_Size => 32;
   for ADC_SMPR2_Register use
      record
         SMP0 at 0 range 0 .. 2;
         SMP1 at 0 range 3 .. 5;
         SMP2 at 0 range 6 .. 8;
         SMP3 at 0 range 9 .. 11;
         SMP4 at 0 range 12 .. 14;
         SMP5 at 0 range 15 .. 17;
         SMP6 at 0 range 18 .. 20;
         SMP7 at 0 range 21 .. 23;
         SMP8 at 0 range 24 .. 26;
         SMP9 at 0 range 27 .. 29;
         Unmapped at 0 range 30 .. 31;
      end record;
         
   type ADC_SQR1_Register is
      record
         SQ13 : Common_Types.ADC_Channel;
         SQ14 : Common_Types.ADC_Channel;
         SQ15 : Common_Types.ADC_Channel;
         SQ16 : Common_Types.ADC_Channel;
         L    : Common_Types.Conversion_Count;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 8);
      end record with Volatile, Object_Size => 32;
   for ADC_SQR1_Register use
      record
         SQ13 at 0 range 0 .. 4;
         SQ14 at 0 range 5 .. 9;
         SQ15 at 0 range 10 .. 14;
         SQ16 at 0 range 15 .. 19;
         L at 0 range 20 .. 23;
         Unmapped at 0 range 24 .. 31;
      end record;
   
   type ADC_SQR2_Register is
      record
         SQ7 : Common_Types.ADC_Channel;
         SQ8 : Common_Types.ADC_Channel;
         SQ9 : Common_Types.ADC_Channel;
         SQ10 : Common_Types.ADC_Channel;
         SQ11 : Common_Types.ADC_Channel;
         SQ12 : Common_Types.ADC_Channel;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 2);
      end record with Volatile, Object_Size => 32;
   for ADC_SQR2_Register use
      record
         SQ7 at 0 range 0 .. 4;
         SQ8 at 0 range 5 .. 9;
         SQ9 at 0 range 10 .. 14;
         SQ10 at 0 range 15 .. 19;
         SQ11 at 0 range 20 .. 24;
         SQ12 at 0 range 25 .. 29;
         Unmapped at 0 range 30 .. 31;
      end record;
   
   type ADC_SQR3_Register is
      record
         SQ1 : Common_Types.ADC_Channel;
         SQ2 : Common_Types.ADC_Channel;
         SQ3 : Common_Types.ADC_Channel;
         SQ4 : Common_Types.ADC_Channel;
         SQ5 : Common_Types.ADC_Channel;
         SQ6 : Common_Types.ADC_Channel;
         Unmapped : Common_Types.Arbitrary_Unmapped_Space (1 .. 2);
      end record with Volatile, Object_Size => 32;
   for ADC_SQR3_Register use
      record
         SQ1 at 0 range 0 .. 4;
         SQ2 at 0 range 5 .. 9;
         SQ3 at 0 range 10 .. 14;
         SQ4 at 0 range 15 .. 19;
         SQ5 at 0 range 20 .. 24;
         SQ6 at 0 range 25 .. 29;
         Unmapped at 0 range 30 .. 31;
      end record;
   
   --   Access points
   ADC1_CR1_Reg       : ADC_CR1_Register with Address => System'To_Address (ADC1_CR1_Address);
   ADC1_CR2_Reg       : ADC_CR2_Register with Address => System'To_Address (ADC1_CR2_Address);
   ADC1_SQR1_Reg      : ADC_SQR1_Register with Address => System'To_Address (ADC1_SQR1_Address);
   ADC1_SQR2_Reg      : ADC_SQR2_Register with Address => System'To_Address (ADC1_SQR2_Address);
   ADC1_SQR3_Reg      : ADC_SQR3_Register with Address => System'To_Address (ADC1_SQR3_Address);
   ADC1_SMPR1_Reg     : ADC_SMPR1_Register with Address => System'To_Address (ADC1_SMPR1_Address);
   ADC1_SMPR2_Reg     : ADC_SMPR2_Register with Address => System'To_Address (ADC1_SMPR2_Address);
   ADC1_DR_Reg        : Interfaces.Unsigned_16 with Address => System'To_Address (ADC1_DR_Address); --   Conversion data must be right-aligned (i.e. in "ADC_CR2")
end ADC;
