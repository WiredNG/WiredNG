package Tilelink

// A Channel definations

typedef enum {
    PutFullData    = 3'h0,
    PutPartialData = 3'h1,
    ArithmeticData = 3'h2,
    LogicalData    = 3'h3,
    Get            = 3'h4,
    Intent         = 3'h5,
    AcquireBlock   = 3'h6,
    AcquirePerm    = 3'h7
} TLA_OP deriving(Bits, Eq, FShow);

typedef struct {
    TLA_OP               opcode ;
    Bit#(3)              param  ;
    Bit#(size_width)     size   ;
    Bit#(source_width)   source ;
    Bit#(addr_width)     address;
    Bit#(data_width / 8) mask   ;
    Bool                 corrupt;
    Bit#(data_width)     data   ;
} TLA #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width, numeric type sink_width) deriving(Bits, Eq, FShow);

// B Channel definations

typedef enum {
    ProbeBlock     = 3'h6,
    ProbePerm      = 3'h7
} TLB_OP deriving(Bits, Eq, FShow);

typedef struct {
    TLB_OP               opcode ;
    Bit#(3)              param  ;
    Bit#(size_width)     size   ;
    Bit#(source_width)   source ;
    Bit#(addr_width)     address;
} TLB #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width, numeric type sink_width) deriving(Bits, Eq, FShow);

// C Channel definations

typedef enum {
  ProbeAck     = 3'h4,
  ProbeAckData = 3'h5,
  Release      = 3'h6,
  ReleaseData  = 3'h7
} TLC_OP deriving(Bits, Eq, FShow);

typedef struct {
    TLC_OP               opcode ;
    Bit#(3)              param  ;
    Bit#(size_width)     size   ;
    Bit#(source_width)   source ;
    Bit#(addr_width)     address;
    Bool                 corrupt;
    Bit#(data_width)     data   ;
} TLC #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width, numeric type sink_width) deriving(Bits, Eq, FShow);

// D Channel definations

typedef enum {
  AccessAck     = 3'h0,
  AccessAckData = 3'h1,
  HintAck       = 3'h2,
  Grant         = 3'h4,
  GrantData     = 3'h5,
  ReleaseAck    = 3'h6
} TLD_OP deriving(Bits, Eq, FShow);

typedef struct {
    TLD_OP               opcode ;
    Bit#(3)              param  ;
    Bit#(size_width)     size   ;
    Bit#(source_width)   source ;
    Bit#(sink_width)     sink   ;
    Bool                 denied ;
    Bool                 corrupt;
    Bit#(data_width)     data   ;
} TLD #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width, numeric type sink_width) deriving(Bits, Eq, FShow);

// E Channel definations

typedef struct {
    Bit#(sink_width)     sink   ;
} TLE #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width, numeric type sink_width) deriving(Bits, Eq, FShow);

endpackage : Tilelink