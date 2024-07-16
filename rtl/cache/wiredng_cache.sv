// Wired cache 分多组 bank，同时支持前端取指及后端访存
// Wired cache 采用非阻塞设计，整个缓存 **不允许** 在任何情况下暂停
// 所有请求被流水化响应并传出，给出命中结果。
// Cache 本身不负责任何关于缺失及写入指令的执行，由外部逻辑负责。
// Cache 对外提供：1 组流水化只读端口； 1 组 SRAM 端口，用于外部逻辑完成缓存重填
// Cache 按字分bank，如采用 64b 2bank 配置下，同时支持访问可位于两个缓存行的两个字
// 因此对 Tag 采用复制策略，有几个 Bank，就有几个 Tag。

module wiredng_cache(
    input clk,
    input rst_n
);

endmodule