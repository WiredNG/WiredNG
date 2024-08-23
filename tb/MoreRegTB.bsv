package MoreRegTB;

import MoreRegs :: *;

module mkTB();

   Reg#(int) cnt <- mkReg(0);

   rule up_counter;
      cnt <= cnt + 1;
      if(cnt > 10) $finish;
   endrule

   Reg#(int) valid_reg <- mkValidReg;
   Reg#(int) wire_reg <- mkWireReg(0);

   rule write_reg (cnt%3 == 0);
      valid_reg <= cnt;
      wire_reg <= cnt;
   endrule

   rule read_valid_reg;
      $display("cnt=%2d   valid_reg=%2d", cnt, valid_reg);
   endrule

   rule read_wire_reg;
      $display("cnt=%2d    wire_reg=%2d", cnt, wire_reg);
   endrule

endmodule

endpackage : MoreRegTB