package TB;

(* synthesize *)
module mkTB();
   rule hello;                   // rule 名: hello
      $display("Hello World!");  // 就像 Verilog 的 $display 那样，
                                 // 该语句不参与综合, 只是在仿真时打印
      $finish;                   // 仿真程序退出
   endrule
endmodule

endpackage : TB