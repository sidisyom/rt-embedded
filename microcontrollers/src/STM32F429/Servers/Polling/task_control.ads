with Common_Types;

package Task_Control is

   protected type Initialization_Control is
      entry Wait_For_Initialization;
      procedure System_Ready;
   private
      OK : Boolean := False;
   end Initialization_Control;

   protected type Job_Queue is
      procedure Put (Job : Common_Types.Job);
      procedure Take (Job   : out Common_Types.Job;
                      Valid : out Boolean);
   private
      Queue : Common_Types.Job_Lists.List;
   end Job_Queue;

   IC : Initialization_Control;
end Task_Control;
