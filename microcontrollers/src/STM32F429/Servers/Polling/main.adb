with Task_Control;
with RCC;
with Task_Types; --   Start all tasks
with Interrupt_Handlers;

procedure Main is
begin
   --  Set HSI as the system clock source (i.e. 16MHz)
   RCC.RCC_CFGR_Reg.SW := RCC.HSI;
   Task_Control.IC.System_Ready;
   loop
      null;
   end loop;
end Main;
