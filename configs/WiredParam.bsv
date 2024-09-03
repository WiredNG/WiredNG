package WiredParam

// 后端允许的 Checkpoint/Branch Issue Queue 尺寸
typedef 4 BRANCH_SLOT

// 物理寄存器堆尺寸
typedef 64 FP_PHYREG_NUM
typedef 64 INT_PHYREG_NUM

// ROB 尺寸
typedef 40 ROB_ENTRY_NUM

// 流水线宽度
typedef 4 FETCH_WIDTH
typedef 3 ISSUE_WIDTH

endpackage : WiredParam