# Wired-NG

Wired Next Gen 处理器核 wired464。

计划使用 LA64 基础指令集，并支持单双精度浮点，以启动主线 Linux 为目标。

计划支持 AMBA ACE 硬件缓存一致性协议，支持多核心配置。

核心方面采用四发射设计，前端使用 TAGE-SC-L 分支预测器，取值宽度为 8 （半缓存行）。

后端采用基于 PRF 的重命名策略，数据捕捉的发射队列。

支持（3）条整数指令及（2）条访存指令同时执行。

访存部分使用弱内存一致性模型，支持乱序访存，采用非阻塞设计。
