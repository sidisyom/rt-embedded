with Registers.Stm32f4.Rcc;
with Registers.Adc.Stm32f4xx;

package body Hal.Stm32.Adc.f4xx is

   procedure Configure (CR : ADC_Configuration_Request) is
   begin
      case CR.Device is
         when ADC1 =>
            Registers.Stm32f4.Rcc.RCC_APB2ENR_Reg.ADC1_EN := Registers.On;
            delay 1.0E-6; --   Stabilization time. RM isn't particularly specific about the required duration (see 13.3.6 in RM)
         when others => raise Constraint_Error; --   Currently only ADC1 supported
      end case;
      --   Handle conversions
      if CR.Conversions'Length <= 6 then
         for I in CR.Conversions'Range loop
            case I is
               when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 := To_Internal_Adc_Channel (CR.Conversions (I));
               when others => raise Constraint_Error; --   Can be removed if explicit range is used (and not the 8-bit base type range)
            end case;
         end loop;
      elsif CR.Conversions'Length > 6 and then CR.Conversions'Length <= 12 then
         for I in CR.Conversions'Range loop
            case I is
               when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 7 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ7 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 8 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ8 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 9 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ9 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 10 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ10 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 11 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ11 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 12 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ12 := To_Internal_Adc_Channel (CR.Conversions (I));
               when others => raise Constraint_Error; --   Can be removed if explicit range is used (and not the 8-bit base type range)
            end case;
         end loop;
      else
         for I in CR.Conversions'Range loop
            case I is
               when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 7 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ7 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 8 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ8 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 9 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ9 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 10 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ10 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 11 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ11 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 12 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ12 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 13 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ13 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 14 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ14 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 15 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ15 := To_Internal_Adc_Channel (CR.Conversions (I));
               when 16 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ16 := To_Internal_Adc_Channel (CR.Conversions (I));
               when others => raise Constraint_Error; --   Can be removed if explicit range is used (and not the 8-bit base type range)
            end case;
         end loop;
      end if;
      --   Set sequence length
      Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.L := Registers.Adc.Stm32f4xx.Conversion_Count (CR.Conversions'Length - 1); --   zero-based, i.e. 0 => One conversion
      --   Configure channel sampling times
      for I in CR.Sampling_Times'Range loop
         declare
            ST : Registers.Adc.Stm32f4xx.Channel_Sampling_Time renames To_Internal_Adc_Channel_Sampling_Time (CR.Sampling_Times (I));
         begin
            case I is
               when 0 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP0 := ST;
               when 1 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP1 := ST;
               when 2 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP2 := ST;
               when 3 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP3 := ST;
               when 4 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP4 := ST;
               when 5 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP5 := ST;
               when 6 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP6 := ST;
               when 7 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP7 := ST;
               when 8 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP8 := ST;
               when 9 => Registers.Adc.Stm32f4xx.ADC1_SMPR2_Reg.SMP9 := ST;
               when 10 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP10 := ST;
               when 11 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP11 := ST;
               when 12 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP12 := ST;
               when 13 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP13 := ST;
               when 14 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP14 := ST;
               when 15 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP15 := ST;
               when 16 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP16 := ST;
               when 17 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP17 := ST;
               when 18 => Registers.Adc.Stm32f4xx.ADC1_SMPR1_Reg.SMP18 := ST;
               when others => raise Constraint_Error;
            end case;
         end;
      end loop;

      declare
         Shadow : Registers.Adc.Stm32f4xx.ADC_CR2_Register := Registers.Adc.Stm32f4xx.ADC1_CR2_Reg;
      begin
         --   Configure conversion data alignment
         Shadow.ALIGN := To_Internal_Conversion_Data_Alignment (CR.Data_Alignment);
         --   Turn ADC module on
         Shadow.ADON := Registers.On;
         --   Set convert continuosly/one-shot
         Shadow.CONT := (if CR.CT = Continuous then Registers.On else Registers.Off);
         --   Start conversions
         Shadow.SWSTART := Registers.On;
         --   Store batch-update
         Registers.Adc.Stm32f4xx.ADC1_CR2_Reg := Shadow;
      end;
      --   Set interrupts enabled
      Registers.Adc.Stm32f4xx.ADC1_CR1_Reg.EOCIE := (if CR.CIS = Enabled then Registers.On else Registers.Off);

      --  ****************************************************************************************************
      --   TEMP
      for I in My_Type'Range loop
         case I is
            when 1 => raise Constraint_Error;
            when 2 => raise Constraint_Error;
            when 3 => raise Constraint_Error;
         end case;
      end loop;

      for I in MA'Range loop
         case I is
            when 1 => raise Constraint_Error;
            when 2 => raise Constraint_Error;
            when 3 => raise Constraint_Error;
         end case;
      end loop;

      for I in YAB'Range loop
         case I is
            when 1 => raise Constraint_Error;
            when 2 => raise Constraint_Error;
         end case;
      end loop;
   end Configure;
end Hal.Stm32.Adc.f4xx;
