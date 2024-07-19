`include "wired0_defines.svh"

// 64 位快速除法器, by gmlayer0
// 每周期产生两位商
// 使用 lzc 跳过前导 0

module wiredleg_div_fast (
    `_WIRED_GENERAL_DEFINE,
    input [63:0] A,
    input [63:0] B,
    output [63:0] rem,
    output [63:0] quo,
    input start,
    input sign,
    output busy
  );

endmodule
