package WiredTypes

import WiredParam::*;

// 流水线中的类型信息
typedef Bit#(5) GpArchRid;
typedef Bit#(5) FpArchRid;
typedef union tagged {
    GpArchRid gp;
    FpArchRid fp;
} ArchRid deriving (Bits, Eq, FShow, Bounded);

typedef Bit#(TLog#(INT_PHYREG_NUM)) GpPhyRid;
typedef Bit#(TLog#(FP_PHYREG_NUM))  FpPhyRid;

typedef union tagged {
    GpPhyRid gp;
    FpPhyRid fp;
} PhyRid deriving (Bits, Eq, FShow, Bounded);

endpackage : WiredTypes