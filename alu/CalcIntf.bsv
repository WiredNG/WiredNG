package CalcIntf

interface WiredCalcIntIntf;
    method Action req(CalcIntOp op, Data d1, Data d2, ExcBundle, SpecTag spec);
    method ActionValue#(MayBe#(Data)) resp;
endinterface

endpackage : CalcIntf