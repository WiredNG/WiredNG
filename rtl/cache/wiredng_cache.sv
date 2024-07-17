// Wired 下一代缓存模块
// 这个模块只负责进行缓存命中判断，永不阻塞

// 注意： Cache 行固定为 8*16 byte == 16*8 byte == 32*4 byte == 128 byte
// Cache 支持 Banking 策略，每一路 Banking 均复制一组 Tag RAM，按照第3位划分
/*
|<-11*3->|*|<-16K->|
4  TAGS  1*1    0  0
7  TAGS  4*3    3  0
*/
module wiredng_cache #(
    parameter int WAY_COUNT = 4,
    parameter int PA_LENGTH = 48
)(
    input wire clk,
    input wire rst_n,
);

endmodule
