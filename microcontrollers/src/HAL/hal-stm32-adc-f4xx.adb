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
   end Configure;
end Hal.Stm32.Adc.f4xx;
