package Tilelink

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
} TLA #(numeric type addr_width, numeric type data_width, numeric type size_width, numeric type source_width) deriving(Bits, Eq, FShow);

endpackage : Tilelink