// 本模块不可用，未完成
// Goldschmidt divider

module wired_div_goldcore #(
    parameter integer Z_LENGTH = 64,
    parameter integer D_LENGTH = 64,
    parameter integer F_LENGTH = 64,
    parameter integer ITER_LENGTH = 6,
    parameter integer TAG_LENGTH = 5,
    parameter integer OPTIONAL_STAGE = 0
)(
    input wire clk,
    input wire rst_n,

    input  wire valid_i,
    output wire ready_o,
    input  wire [TAG_LENGTH-1:0] tag_i,
    input  wire [Z_LENGTH-1:0] z_i,
    input  wire [D_LENGTH-1:0] d_i,
    input  wire [ITER_LENGTH-1:0] iter_i,

    output wire valid_o,
    // input  wire ready_i, 不允许外部阻塞内部？
    output wire [TAG_LENGTH-1:0] tag_o,
    output wire [F_LENGTH-1:0] f_o
);

    // F_LENGTH <= Z_LENGTH + D_LENGTH + 1

    typedef struct packed {
        logic valid;
        logic [ITER_LENGTH-1:0] iter;
        logic [TAG_LENGTH-1:0] tag;
    } stage_t;

    // Stage-1
    stage_t s1_q;
    logic [F_LENGTH:0] zi_q; // DSP Input
    logic [D_LENGTH:0] di_q; // DSP Input
    logic [D_LENGTH:0] two_sub_di_q0; // DSP Input
    logic [D_LENGTH:0] two_sub_di_q1; // DSP Input

    // Stage-2
    stage_t s2_q;
    (* use_dsp = "yes" *) logic [127:0] znext_q;
    (* use_dsp = "yes" *) logic [127:0] dnext_q;

    // Stage-3
    stage_t s3_q;
    logic [127:0] znext_q_q, dnext_q_q;

    // Stage-Optional
    stage_t sopt;
    logic [127:0] znext, dnext;
    if(OPTIONAL_STAGE != 0) begin
        stage_t [OPTIONAL_STAGE-1:0] sopt_q;
        logic  [OPTIONAL_STAGE-1:0][127:0] znext_opt_q, dnext_opt_q;
        for(genvar i = 1 ; i < OPTIONAL_STAGE ; i += 1) begin
            always_ff @(posedge clk) begin
                znext_opt_q[i] <= znext_opt_q[i-1];
                dnext_opt_q[i] <= dnext_opt_q[i-1];
                sopt_q[i] <= sopt_q[i-1];
            end
        end
        always_ff @(posedge clk) begin
            znext_opt_q[0] <= znext_q_q;
            dnext_opt_q[0] <= dnext_q_q;
            sopt_q[0] <= s3_q;
        end
        assign znext = znext_opt_q[OPTIONAL_STAGE-1];
        assign dnext = dnext_opt_q[OPTIONAL_STAGE-1];
        assign sopt = sopt_q[OPTIONAL_STAGE-1];
    end else begin
        assign znext = znext_q_q;
        assign dnext = dnext_q_q;
        assign sopt = s3_q;
    end

    // Output logic
    assign valid_o = sopt.valid && sopt.iter == ITER_LENGTH'd1;
    assign tag_o = sopt.valid && sopt.iter == ITER_LENGTH'd1;
    assign f_o = sopt.valid && sopt.iter == ITER_LENGTH'd1;

    // Stage-next signal
    stage_t snext;
    assign snext.valid = sopt.valid && sopt.iter != ITER_LENGTH'd1;
    assign snext.iter = sopt.iter == '0 ? '0 : (sopt.iter - ITER_LENGTH'd1);
    assign snext.tag = sopt.tag;

    // Stage-1
    stage_t new_s1;
    assign new_s1.valid = 1'b1;
    assign new_s1.iter  = iter_i;
    assign new_s1.tag   = tag_i;
    assign ready_o = !snext.valid;
    wire accept_new_req = valid_i & ready_o;
    wire last_req_end;
    always_ff @(posedge clk) begin
        if(!rst_n) begin
            s1_q.valid <= '0;
            s1_q.iter <= '0;
            s1_q.tag <= '0;
        end else begin
            s1_q <= accept_new_req ? new_s1 : snext;
        end
    end
    always_ff @(posedge clk) begin
        zi_q <= accept_new_req ? z_i : (snext.valid ? znext : '0);
        di_q <= accept_new_req ? d_i : (snext.valid ? dnext : '0);
        two_sub_di_q0 <= {2'b10, {Z_LENGTH'0}} - (accept_new_req ? d_i : dnext);
        two_sub_di_q1 <= {2'b10, {Z_LENGTH'0}} - (accept_new_req ? d_i : dnext);
    end

    // Stage-2
    always_ff @(posedge clk) begin
        znext_q <= zi_q * two_sub_di_q0;
        dnext_q <= di_q * two_sub_di_q1;
        s2_q <= s1_q;
    end

    // Stage-3
    always_ff @(posedge clk) begin
        znext_q_q <= znext_q;
        dnext_q_q <= dnext_q;
        s3_q <= s2_q;
    end

endmodule