package WiredRename

// 本模块采用位图，对所有空闲的 prf 进行记录。
// 重命名时，采用 Priority 解码形式，搜索排名前 issueWidth 的空闲寄存器，用于重命名
interface GetRename
    method PhyRegs getRename(ArchRegs);
endinterface

module mkRename();

endmodule

endpackage : WiredRename