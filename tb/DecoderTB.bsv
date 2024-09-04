package DecoderTB;

import WiredDecode::*;
import LoongArchInst::*;

(* synthesize *)
module mkTB();

   Reg#(int) cnt <- mkReg(0);
   Reg#(LA_Inst) inst <- mkRegU;

   rule up_counter;
      cnt <= cnt + 1;
      if(cnt > 10) $finish;
   endrule


   rule decode_test0 (cnt == 0);
      inst <= predecode(32'h00000000);
   endrule

   rule decode_test1 (cnt == 1);
      inst <= predecode(32'h00001000);
   endrule

   rule decode_test2 (cnt == 2);
      inst <= predecode(32'h00000800);
   endrule

   rule decode_test3 (cnt == 3);
      inst <= predecode(32'h00006fff);
   endrule

   rule decode_test4 (cnt == 4);
      inst <= predecode(32'h00007000);
   endrule

   rule decode_test5 (cnt == 5);
      inst <= predecode(32'h00007001);
   endrule


   rule decode_print;
      $display(fshow(inst));
   endrule

endmodule
endpackage : DecoderTB