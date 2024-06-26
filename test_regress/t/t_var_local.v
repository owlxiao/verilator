// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2003 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

class cls;
  static task automatic tsk1;
     integer task_assign = 1;
     if (task_assign != 1) $stop;
     task_assign = 2;
     if (task_assign != 2) $stop;
  endtask
  static task tsk2;
     integer task_assign = 1;
     if (task_assign != 1) $stop;
     task_assign = 2;
     if (task_assign != 2) $stop;
  endtask
endclass

module t;

   integer top;
   integer top_assign=1;

   task automatic tsk;
      integer task_assign = 1;
      if (task_assign != 1) $stop;
      task_assign = 2;
      if (task_assign != 2) $stop;
   endtask

   initial begin
      begin : a
         integer lower;
         integer lower_assign=1;
         lower = 1;
         top = 1;
         if (lower != 1) $stop;
         if (lower_assign != 1) $stop;
         begin : aa
            integer lev2;
            lev2 = 1;
            lower = 2;
            lower_assign = 2;
            top = 2;
         end
         if (lower != 2) $stop;
         if (lower_assign != 2) $stop;
      end
      begin : b
         integer lower;
         lower = 1;
         top = 2;
         begin : empty
            begin : empty
            end
         end
      end
      // Repeat task calls to ensure we reinit the initial value
      tsk;
      tsk;
      cls::tsk1();
      cls::tsk1();
      cls::tsk2();
      cls::tsk2();
      $write("*-* All Finished *-*\n");
      $finish;
   end

endmodule
