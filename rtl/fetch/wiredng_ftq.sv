// 前端取指围绕 ftq 构建
// ftq 设计方面思路类似 LSU 中的 load queue

module wired_ftq(
    input clk,
    input rst_n,

    // Backend Interface for update
    input                   upd_valid_i,
    output                  upd_ready_o,
    input  prediction_upd_t upd_req_i,

    // Interface for instructions fetch

    // Backend Interface for issue
);

// Fetch target entry

// Fetching logic

endmodule
