package RegFileTB;

import WiredRegFile::*;
import PriorityEncodeOH::*;

(* synthesize *)
module mkTB ();

    RegFile_nwmr#(UInt#(2), Int#(32), 2, 4) rf <- mkRegFile_nwmr(?);

    Reg#(Int#(32)) i <- mkReg(0);
    rule tick;
        i <= i + 1;
        if(i > 100) $finish();
    endrule
    rule rf_2w_0;
        rf.wp[0].w(unpack(truncate(pack(i))), unpack(1));
    endrule
    rule rf_2w_1; // Higher piority
        rf.wp[1].w(unpack(truncate(pack(i * 3))), unpack(2));
    endrule
    rule rf_nr;
        $display("%d %d - state: %d %d %d %d", i % 4, (i * 3) % 4, rf.rp[0].r(0), rf.rp[1].r(1), rf.rp[2].r(2), rf.rp[3].r(3));
    endrule

endmodule

endpackage : RegFileTB