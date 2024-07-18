// Wired 核心中，STLB 采用 SRAM 实现，对于 16KB 固定页的缺失，优先放入 STLB 中。
// 512 Entrys STLB, 3-way, 24M memory mapped region.

// PA == 36b
// VA == 48b

// va:48-14-9-1==24 + 2xpa:22+3(rwx)+10(asid) == 94/way

// key:
// {VPPN:48-14-9-1 == 24} | {G == 1} | {ASID == 10} == 35 || [E == 1]

// value:
// {PPN:36-14 == 22} | {PLV == 2} | {MAT == 2} | {RXWV == 4} == 31
// {PPN:36-14 == 22} | {PLV == 2} | {MAT == 2} | {RXWV == 4} == 31

module wiredng_tlb_stlb (
    input clk,
    input rst_n,

    input
);

endmodule
