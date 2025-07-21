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
            declare
               CH : Registers.Adc.Stm32f4xx.ADC_Channel renames To_Internal_Adc_Channel (CR.Conversions (I));
            begin
               case I is
                  when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := CH;
                  when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 := CH;
                  when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 := CH;
                  when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 := CH;
                  when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 := CH;
                  when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 := CH;
                  when others => raise Constraint_Error; --   "I" is taken to be the 8-bit base type range
               end case;
            end;
         end loop;
      elsif CR.Conversions'Length > 6 and then CR.Conversions'Length <= 12 then
         for I in CR.Conversions'Range loop
            declare
               CH : Registers.Adc.Stm32f4xx.ADC_Channel renames To_Internal_Adc_Channel (CR.Conversions (I));
            begin
               case I is
                  when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := CH;
                  when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 :=  CH;
                  when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 :=  CH;
                  when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 :=  CH;
                  when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 :=  CH;
                  when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 :=  CH;
                  when 7 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ7 :=  CH;
                  when 8 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ8 :=  CH;
                  when 9 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ9 :=  CH;
                  when 10 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ10 :=  CH;
                  when 11 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ11 :=  CH;
                  when 12 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ12 :=  CH;
                  when others => raise Constraint_Error; --   "I" is taken to be the 8-bit base type range
               end case;
            end;
         end loop;
      else
         for I in CR.Conversions'Range loop
            declare
               CH : Registers.Adc.Stm32f4xx.ADC_Channel renames To_Internal_Adc_Channel (CR.Conversions (I));
            begin
               case I is
                  when 1 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ1 := CH;
                  when 2 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ2 := CH;
                  when 3 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ3 := CH;
                  when 4 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ4 := CH;
                  when 5 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ5 := CH;
                  when 6 => Registers.Adc.Stm32f4xx.ADC1_SQR3_Reg.SQ6 := CH;
                  when 7 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ7 := CH;
                  when 8 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ8 := CH;
                  when 9 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ9 := CH;
                  when 10 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ10 := CH;
                  when 11 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ11 := CH;
                  when 12 => Registers.Adc.Stm32f4xx.ADC1_SQR2_Reg.SQ12 := CH;
                  when 13 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ13 := CH;
                  when 14 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ14 := CH;
                  when 15 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ15 := CH;
                  when 16 => Registers.Adc.Stm32f4xx.ADC1_SQR1_Reg.SQ16 := CH;
                  when others => raise Constraint_Error; --   "I" is taken to be the 8-bit base type range
               end case;
            end;
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
      --   Can't use a shadow register for batch-stores as some components need to be set only **after** some specific ones have been set (see "SWSTART" in "ADC_CR2")
      Registers.Adc.Stm32f4xx.ADC1_CR2_Reg.ALIGN := To_Internal_Conversion_Data_Alignment (CR.Data_Alignment);
      Registers.Adc.Stm32f4xx.ADC1_CR2_Reg.ADON := Registers.On;
      Registers.Adc.Stm32f4xx.ADC1_CR2_Reg.CONT := Registers.On;
      Registers.Adc.Stm32f4xx.ADC1_CR2_Reg.SWSTART := Registers.On;
      --   Set interrupts-enabled
      Registers.Adc.Stm32f4xx.ADC1_CR1_Reg.EOCIE := (if CR.Conversion_Interrupt = Enabled then Registers.On else Registers.Off);
      --   Set scan-mode
      Registers.Adc.Stm32f4xx.ADC1_CR1_Reg.SCAN := (if CR.Scan_Md = Scan_Mode_On then Registers.On else Registers.Off);
   end Configure;
end Hal.Stm32.Adc.f4xx;
