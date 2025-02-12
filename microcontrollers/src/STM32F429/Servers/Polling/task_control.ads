package Task_Control is

   protected type Initialization_Control is
      entry Wait_For_Initialization;
      procedure System_Ready;
   private
      OK : Boolean := False;
   end Initialization_Control;
   
   IC : Initialization_Control;
end Task_Control;
