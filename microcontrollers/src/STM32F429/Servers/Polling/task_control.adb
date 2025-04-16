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

   protected body Job_Queue is
      procedure Put (Job : Common_Types.Job) is
      begin
         Queue.Append (Job);
      end Put;

      procedure Take (Job   : out Common_Types.Job;
                      Valid : out Boolean) is
      begin
         if Queue.Is_Empty then
            Valid := False;
         else
            Job := Queue.First_Element;
            Queue.Delete_First;
            Valid := True;
         end if;
      end Take;

   end Job_Queue;
end Task_Control;
