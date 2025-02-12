package body Task_Control is

   protected body Initialization_Control is
      entry Wait_For_Initialization when OK is
      begin
         null;
      end Wait_For_Initialization;
      procedure System_Ready is
      begin
         OK := True;
      end System_Ready;
   end Initialization_Control;
end Task_Control;
