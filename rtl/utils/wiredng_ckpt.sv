// 面向 FPGA 软核的高性能 checkpoints 实现
// 每四个此模块应被综合到一个 slicem 中
module wired_ckpt #(
    parameter bit ENABLE_OPTMIZED = 0
)(
    input  wire clk,
    input  wire rst, // 注意：高电平复位

    input  wire    backup_i, // 备份当前值到 [id_i]

    input  wire        ce_i, // 寄存器值更新
    input  wire       rec_i, // 寄存器值更新来自 [id_i]

    input  wire [5:0]  id_i, // 操作 id

    input  wire         d_i, // 数据输入
    output wire         d_o  // 数据输出
);

if(!ENABLE_OPTMIZED) begin
    reg [63:0] ckpt_q;
    reg d_q;
    always_ff @(posedge clk) begin
        if(backup_i) ckpt_q[id_i] <= d_q;
    end
    always_ff @(posedge clk) begin
        if(rst) begin
            d_q <= '0;
        end else begin
            if(ce_i) d_q <= rec_i ? ckpt_q[id_i] : d_i;
        end
    end
    assign d_o = d_q;
end else begin
    wire ckpt_rv;
    FDRE #(
        .INIT(1'b0) // Initial value of register (1'b0 or 1'b1)
    ) FDRE_PAYLOAD (
        .Q(d_o),      // 1-bit Data output
        .C(clk),      // 1-bit Clock input
        .CE(ce_i),    // 1-bit Clock enable input
        .R(rst),      // 1-bit Synchronous reset input
        .D(rec_i ? ckpt_rv : d_i)       // 1-bit Data input
    );
    RAM64X1S #(
      .INIT(64'h0000000000000000) // Initial contents of RAM
    ) LUT6_CKPT (
      .O(ckpt_rv),       // 1-bit data output
      .A0(id_i[0]),      // Address[0] input bit
      .A1(id_i[1]),      // Address[1] input bit
      .A2(id_i[2]),      // Address[2] input bit
      .A3(id_i[3]),      // Address[3] input bit
      .A4(id_i[4]),      // Address[4] input bit
      .A5(id_i[5]),      // Address[5] input bit
      .D(d_o),        // 1-bit data input
      .WCLK(clk),  // Write clock input
      .WE(backup_i)       // Write enable input
    );
end

endmodule
