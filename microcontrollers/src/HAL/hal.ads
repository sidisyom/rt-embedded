with Ada.Synchronous_Task_Control;

package Hal is

   type Unmapped_Range is array (Positive range <>) of Boolean with
     Component_Size => 1, Unreferenced;

end Hal;
