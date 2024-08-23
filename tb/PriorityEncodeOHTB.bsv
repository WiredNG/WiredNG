package PriorityEncodeOHTB;

import PriorityEncodeOH::*;

(* synthesize *)
module mkTB();

    Reg#(Int#(32)) i <- mkReg(0);
    rule tick;
        i <= i + 10;
        if(i > 1000) $finish();
    endrule

    rule test;
        $display("%x: %x %x", i, priorityEncodeOHL(pack(i)), priorityEncodeOHR(pack(i)));
    endrule

endmodule

endpackage : PriorityEncodeOHTB