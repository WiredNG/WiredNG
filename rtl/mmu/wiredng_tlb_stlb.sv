// Wired 核心中，STLB 采用 SRAM 实现，对于 16KB 固定页的缺失，全部放入 STLB 中。
// 256 Entrys STLB, 3-way, 24M memory mapped region.

// PA == 36b
// VA == 48b

// key:
// {VPPN:48-14-10-1 == 23} | {G == 1} | {ASID == 10} == 34 || [E == 1]

// value:
// {PPN:36-14 == 22} | {PLV == 2} | {MAT == 1} | {RXWV == 4} == 30
// {PPN:36-14 == 22} | {PLV == 2} | {MAT == 1} | {RXWV == 4} == 30

// 95bits / way

// support up to 24M virtual address space translation

module wiredng_tlb_stlb (
    input clk,
    input rst_n,

    input
);

endmodule
