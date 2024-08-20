package RegFileTB;

import WiredRegFile::*;
import PriorityEncodeOH::*;

(* synthesize *)
module mkTB ();

    RegFile1W#(UInt#(5), Int#(32)) rf <- mkRegFile_1W_RST;

    Reg#(Int#(32)) i <- mkReg(0);

    rule rf_1wnr;
        rf.wp.write(unpack(truncate(pack(i))), unpack(priorityEncodeOHL(pack(i))));
        $display("%d: %d %d %d %d", i, rf.rp.read(1), rf.rp.read(10), rf.rp.read(19), rf.rp.read(28));
        i <= i + 1;
        if(i > 100) $finish();
    endrule

endmodule

endpackage : RegFileTB