// Wired 下一代缓存模块
// 这个模块只负责一组 Bank 的命中

module wiredng_cache_bank #(
    parameter int WAY_COUNT = 4,
    parameter int PA_LENGTH = 48
)(
    input wire clk,
    input wire rst_n,

    // stage-1 input
    input wire [13:4] index_i,

    // stage-2 input and address translation
    input wire [PA_LENGTH-1:14] tag_i,

    // stage-3 compare

    // stage-4 output
    output wire hit_o,
    output wire [63:0] data_o,

    // SRAM Interface
    // stage-1 output
    output wire [13:4] sram_addr_o,

    // stage-2 input
    input  wire [WAY_COUNT-1:0][63:0]  data_i,
    input  cache_tag_t [WAY_COUNT-1:0] stag_i,

    // stage-3 compare
);

endmodule
