`include "wired0_defines.svh"

// 64 位固定周期除法器

module wired_div64_simp (
    `_WIRED_GENERAL_DEFINE,
    input [63:0] A,
    input [63:0] B,
    output [63:0] rem,
    output [63:0] quo,
    input start,
    input sign,
    output logic busy
  );
  logic[63:0] a_abs, b_abs;
  assign a_abs = (sign && A[63]) ? -A : A;
  assign b_abs = (sign && B[63]) ? -B : B;
  logic[6:0] timer;
  logic[63:0] dividend_q, quo_q;
  logic[126:0] divisor_q;
  logic neg_rem_q, neg_quo_q;
  logic[127:0] sub_result;
  assign sub_result = {64'd0, dividend_q} - divisor_q[126:0];
  always_ff @(posedge clk) begin
    if(!rst_n) begin
      timer <= 7'd0;
      busy <= '0;
    end else if(start) begin
      timer <= 7'd64;
      busy <= '1;
    end else begin
      if(timer != 0) begin
        if(timer == 7'd1) begin
          busy <= '0;
        end
        timer <= timer - 7'd1;
      end
    end
  end
  always_ff @(posedge clk) begin
    if(start) begin
      dividend_q <= a_abs;
      divisor_q <= {b_abs, 62'd0};
      neg_rem_q <= A[63] && sign;
      neg_quo_q <= (A[63] != B[63]) && sign;
    end else begin
      if(timer != 0) begin
        if(!sub_result[127]) begin
          quo_q <= {quo_q[62:0], 1'b1};
          dividend_q <= sub_result[63:0];
        end else begin
          quo_q <= {quo_q[62:0], 1'b0};
        end
        divisor_q <= {'0, divisor_q[62:1]};
      end
    end
  end
  assign rem = neg_rem_q ? -dividend_q : dividend_q;
  assign quo = neg_quo_q ? -quo_q : quo_q;
endmodule
