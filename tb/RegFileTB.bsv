package RegFileTB;

import WiredRegFile::*;

module mkTB ();

    RegFile1W#(UInt#(5), Int#(32)) rf <- mkRegFile_1W_nRST;

    Reg#(Int#(32)) i <- mkReg(0);

    rule rf_1wnr;
        rf.wp.write(unpack(truncate(pack(i))), i);
        $display("%d: %d %d %d %d", i, rf.rp.read(0), rf.rp.read(8), rf.rp.read(16), rf.rp.read(24));
        i <= i + 1;
        if(i > 100) $finish();
    endrule

endmodule

endpackage : RegFileTB