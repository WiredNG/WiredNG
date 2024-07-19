`ifndef _WIREDNG_PARAMS_HEADER_
`define _WIREDNG_PARAMS_HEADER_

// Address translation related

`define VA_LEN (48)
`define PA_LEN (36)

typedef logic[`VA_LEN-1:0] va_t;
typedef logic[`PA_LEN-1:0] pa_t;

// ROB params

`define ROB_BANK (3)
`define ROB_SIZE_PERBANK (64)

`endif