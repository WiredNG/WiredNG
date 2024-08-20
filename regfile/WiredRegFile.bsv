package WiredRegFile;

import Vector :: *;

    interface RegFileWPort #(type index_t, type data_t);
        method Action write(index_t addr, data_t data);
    endinterface

    interface RegFileRPort #(type index_t, type data_t);
        method data_t  read(index_t addr);
    endinterface

    interface RegFile1W #(type index_t, type data_t);
        interface RegFileWPort#(index_t, data_t) wp;
        interface RegFileRPort#(index_t, data_t) rp;
    endinterface

    // 1W nR, no-reset
    module mkRegFile_1W_nRST (RegFile1W#(index_t, data_t))
    provisos(
        Bits#(index_t, index_width_t),Bits#(data_t, data_width_t),
        Arith#(index_t),Bounded#(index_t),Literal#(index_t),Eq#(index_t),
        Ord#(index_t),Literal#(data_t),PrimIndex#(index_t, index_index_t)
    );
        Reg#(data_t) rf [32];
        for(index_t i = 0 ; i != 31; i = i + 1)
            rf[i] <- mkRegU;

        interface wp = interface RegFileWPort#(index_t, data_t);
            method Action write(index_t addr, data_t data);
                rf[addr] <= data;
            endmethod
        endinterface;

        interface rp = interface RegFileRPort#(index_t, data_t);
            method data_t read(index_t addr);
                return rf[addr];
            endmethod
        endinterface;
    endmodule

    // 1W nR, resetable
    module mkRegFile_1W_RST (RegFile1W#(index_t, data_t))
    provisos(
        Bits#(index_t, index_width_t),Bits#(data_t, data_width_t),
        Arith#(index_t),Bounded#(index_t),Literal#(index_t),Eq#(index_t),
        Ord#(index_t),Literal#(data_t),PrimIndex#(index_t, index_index_t)
    );
        Reg#(data_t) rf [32];
        for(index_t i = 0 ; i != 31; i = i + 1)
            rf[i] <- mkReg(0);

        interface wp = interface RegFileWPort#(index_t, data_t);
            method Action write(index_t addr, data_t data);
                rf[addr] <= data;
            endmethod
        endinterface;

        interface rp = interface RegFileRPort#(index_t, data_t);
            method data_t read(index_t addr);
                return rf[addr];
            endmethod
        endinterface;
    endmodule

endpackage : WiredRegFile