// 面向 FPGA 软核的高速 regfile 实现，支持 64 组 chpt
// 双写口，多读口

module wired_ckpt_dprf #(
    parameter bit ENABLE_OPTMIZED = 0,
    parameter int DEPTH = 64,
    parameter int PAYLOAD_LEN = 6
)(
    input clk,
    input rst_n,

    // 写入端口
    input [5:0] wid_i,
    input we_i,
    input [1:0][$clog2(DEPTH) - 1 : 0]             waddr_i,
    input [1:0][PAYLOAD_LEN - 1 : 0] wdata_i,
    
    // 恢复端口
    input [5:0] rid_i, // ID
    input rec_i,

    // 读出端口
    output [DEPTH - 1 : 0][PAYLOAD_LEN - 1 : 0] q_o
);
    wire rst = ~rst_n;
    assign q_o[0] = '0;
    for(genvar i = 1 ; i < DEPTH ; i += 1) begin : gen_all
        wire [PAYLOAD_LEN - 1 : 0] d, q;
        wire single_we = we_i && 
        (waddr_i[0] == i[$clog2(DEPTH) - 1 : 0] ||
         waddr_i[1] == i[$clog2(DEPTH) - 1 : 0]);
        d = (waddr_i[1] == i[$clog2(DEPTH) - 1 : 0]) ? wdata_i[1] : wdata_i[0];
        assign q_o[i] = q;
        for(genvar b = 0 ; b < PAYLOAD_LEN ; b += 1) begin : gen_single
            wired_ckpt # (
                .ENABLE_OPTMIZED(ENABLE_OPTMIZED)
            )
            wired_ckpt_inst (
                .clk(clk),
                .rst(rst),
                .backup_i(we_i),
                .ce_i(single_we),
                .rec_i(rec_i),
                .id_i(rec_i ? rid_i : wid_i),
                .d_i(d[b]),
                .d_o(q[b])
            );
        end
    end

endmodule