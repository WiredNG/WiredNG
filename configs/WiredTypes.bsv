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

typedef struct {
    Maybe#(ArchRid) src0;
    Maybe#(ArchRid) src1;
    Maybe#(ArchRid) src2;
    Maybe#(ArchRid) dst;
} ArchRegs; 
// stx may need 3 src registers / and fmadd may need 3 src registers with an additional dst registers

typedef struct {
    Maybe#(PhyRid) src0;
    Maybe#(PhyRid) src1;
    Maybe#(PhyRid) src2;
    Maybe#(PhyRid) dst;
} PhyRegs;

endpackage : WiredTypes