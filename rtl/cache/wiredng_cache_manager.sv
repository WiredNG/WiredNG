// Wired 下一代缓存模块，响应重填请求，及总线探查请求
// 注意，此模块内部有多组状态机组成，同时支持同时处理多个重填请求
// 对外，一侧连接到 SRAM 总线，一侧连接到 Tilelink 总线，一侧连接到 CPU 重填、无效请求处
// 还需要负责完成

module wiredng_cache_manager #(
    parameter int WAY_COUNT = 4,
    parameter int PA_LENGTH = 48,
    parameter int MSHR_COUNT = 8,
    parameter int unsigned SOURCE_WIDTH  = 1,
    parameter int unsigned SINK_WIDTH    = 1,
    parameter bit [SOURCE_WIDTH-1:0] SOURCE_BASE  = 0
)(
    input clk,
    input rst_n,

    // 重填请求部分：包括锁请求及释放部分
    input  refill_req_t refill_req_i,
    output logic  refill_req_ready_o,
    input  logic  refill_req_valid_i,

    // 写回部分：写入 Commit Store-buffer，等待写入 SRAM
    input  wb_req_t wb_req_i,
    output logic    wb_req_ready_o,
    input  logic    wb_req_valid_i,

    // Barrier 接口
    output logic csb_clean_o, // Commit store-buffer empty
    input  logic req_clean_i, // 清理内部所有状态

    // SRAM 接口部分
    output logic [13:4]  sdata_addr_o,
    output logic [WAY_COUNT-1:0][15:0]  sdata_we_o,
    input  logic [WAY_COUNT-1:0][127:0] sdata_i,
    output logic [127:0] sdata_o,
    
    output logic [1:0][13:7]  stag_addr_o,
    output logic [WAY_COUNT-1:0]   stag_we_o,
    input  cache_tag_t [1:0][WAY_COUNT-1:0] stag_i,
    output cache_tag_t   stag_o,

    // Tilelink-C 接口
    `TL_DECLARE_HOST_PORT(128, 32, SOURCE_WIDTH, SINK_WIDTH, tl) // tl_a_o
);
    // MSHR: 8Entry, each Entry need 8-beats to transfer
    // So we got 64 Beats to cover memory-latency.
    mshr_t [MSHR_COUNT-1:0] mshr_q;

    // Notice that when do memcpy, we need to fully make use of the MSHRs
    // To maxium Memory-bandwidth, which means that we must implement cache
    // prefetch whether by 'prefetch' instruction or by hardware prefecther.

endmodule