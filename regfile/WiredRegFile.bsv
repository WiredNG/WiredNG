package WiredRegFile;

import Vector :: *;

    interface RegFileWPort #(type index_t, type data_t);
        method Action w(index_t addr, data_t data);
    endinterface

    interface RegFileRPort #(type index_t, type data_t);
        method data_t  r(index_t addr);
    endinterface

    interface RegFile_nwmr #(type index_t, type data_t, numeric type wr_num, numeric type rd_num);
        interface Vector#(wr_num, RegFileWPort#(index_t, data_t)) wp;
        interface Vector#(rd_num, RegFileRPort#(index_t, data_t)) rp;
    endinterface

    module
    mkRegFile_nwmr #(data_t init_val)
    (RegFile_nwmr  #(index_t, data_t, wr_num, rd_num))
    provisos(
        Bits#(index_t, index_width_t),Bits#(data_t, data_width_t),
        Arith#(index_t),Bounded#(index_t),Literal#(index_t),Eq#(index_t),
        Ord#(index_t),Literal#(data_t),PrimIndex#(index_t, index_index_t),
        NumAlias#(n, TExp#(index_width_t))
    );
        Reg#(data_t) rf[valueOf(n)][valueOf(wr_num)];
        for(Integer i = 0 ; i < valueOf(n); i = i + 1)
            rf[i] <- mkCReg(valueOf(wr_num), init_val);

        Vector#(wr_num, RegFileWPort#(index_t, data_t)) wpIf = ?;
        for(Integer i = 0 ; i < valueOf(wr_num); i = i + 1) begin
        wpIf[i] =(interface RegFileWPort#(index_t, data_t);
            method Action w(index_t addr, data_t data);
                rf[addr][i] <= data;
            endmethod
        endinterface);
        end

        Vector#(rd_num, RegFileRPort#(index_t, data_t)) rpIf = ?;
        for(Integer i = 0 ; i < valueOf(rd_num); i = i + 1) begin
        rpIf[i] =(interface RegFileRPort#(index_t, data_t);
            method data_t r(index_t addr);
                return rf[addr][0];
            endmethod
        endinterface);
        end

        interface wp = wpIf;
        interface rp = rpIf;
    endmodule

endpackage : WiredRegFile