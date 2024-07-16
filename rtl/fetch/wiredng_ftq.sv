module wired_ftq(
    input clk,
    input rst_n,

    // Prediction request
    input                   preq_valid_i,
    output                  preq_ready_o,
    input  predict_req_t    preq_i,

    // Prediction response: single-cycle prediction
    output logic            pfast_valid_o,
    output predict_resp_t   pfast_o,

    // Prediction response: precise prediction
    output logic            pacc_valid_o,
    output predict_resp_t   pacc_o,

    // Interface for update
    input                   upd_valid_i,
    output                  upd_ready_o,
    input  prediction_upd_t upd_req_i
);

// Fetch target entry

// Fetching logic

endmodule