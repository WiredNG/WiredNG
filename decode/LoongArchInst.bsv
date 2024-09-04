package LoongArchInst;

typedef struct {
    Bit#(22) opcode;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_2R deriving (Bits, Eq, FShow, Bounded);

UInt#(32) op2R_START  = 'b0000000000000000000100_0000000000;
Bit#(32) opCLO_W     = 'b0000000000000000000100_0000000000;
Bit#(32) opCLZ_W     = 'b0000000000000000000101_0000000000;
Bit#(32) opCTO_W     = 'b0000000000000000000110_0000000000;
Bit#(32) opCTZ_W     = 'b0000000000000000000111_0000000000;
Bit#(32) opCLO_D     = 'b0000000000000000001000_0000000000;
Bit#(32) opCLZ_D     = 'b0000000000000000001001_0000000000;
Bit#(32) opCTO_D     = 'b0000000000000000001010_0000000000;
Bit#(32) opCTZ_D     = 'b0000000000000000001011_0000000000;
Bit#(32) opREVB_2H   = 'b0000000000000000001100_0000000000;
Bit#(32) opREVB_4H   = 'b0000000000000000001101_0000000000;
Bit#(32) opREVB_2W   = 'b0000000000000000001110_0000000000;
Bit#(32) opREVB_D    = 'b0000000000000000001111_0000000000;
Bit#(32) opREVH_2W   = 'b0000000000000000010000_0000000000;
Bit#(32) opREVH_D    = 'b0000000000000000010001_0000000000;
Bit#(32) opBITREV_4B = 'b0000000000000000010010_0000000000;
Bit#(32) opBITREV_8B = 'b0000000000000000010011_0000000000;
Bit#(32) opBITREV_W  = 'b0000000000000000010100_0000000000;
Bit#(32) opBITREV_D  = 'b0000000000000000010101_0000000000;
Bit#(32) opEXT_W_H   = 'b0000000000000000010110_0000000000;
Bit#(32) opWXT_W_B   = 'b0000000000000000010111_0000000000;
Bit#(32) opRDTIMELW  = 'b0000000000000000011000_0000000000;
Bit#(32) opRDTIMEHW  = 'b0000000000000000011001_0000000000;
Bit#(32) opRDTIMED   = 'b0000000000000000011010_0000000000;
Bit#(32) opCPUCFG    = 'b0000000000000000011011_0000000000;
UInt#(32) op2R_END    = 'b0000000000000000011100_0000000000;

typedef struct {
    Bit#(17) opcode;
    Bit#(5)  rk;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_3R deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(12) opcode;
    Bit#(5)  ra;
    Bit#(5)  rk;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_4R deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(18) opcode;
    Bit#(8)  i8;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_2RI8 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(10) opcode;
    Bit#(12) i12;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_2RI12 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(8)  opcode;
    Bit#(14) i14;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_2RI14 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(6)  opcode;
    Bit#(16) i16;
    Bit#(5)  rj;
    Bit#(5)  rd;
} LA_2RI16 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(6)  opcode;
    Bit#(16) i21l;
    Bit#(5)  rj;
    Bit#(5)  i21h;
} LA_1RI21 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(6)  opcode;
    Bit#(16) i26l;
    Bit#(10) i26h;
} LA_I26 deriving (Bits, Eq, FShow, Bounded);

typedef struct {
    Bit#(32) inst;
} LA_INVALID deriving (Bits, Eq, FShow, Bounded);

typedef union tagged {
    LA_2R Inst_2r;
    LA_3R Inst_3r;
    LA_4R Inst_4r;
    LA_2RI8  Inst_2ri8;
    LA_2RI12 Inst_2ri12;
    LA_2RI14 Inst_2ri14;
    LA_2RI16 Inst_2ri16;
    LA_1RI21 Inst_1ri21;
    LA_I26 Inst_i26;
    LA_INVALID Inst_invalid;
} LA_Inst deriving (Bits, Eq, FShow);

endpackage : LoongArchInst