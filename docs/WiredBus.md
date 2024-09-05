# Wiredng 总线说明

Wiredng 处理器采用 Tilelink 作为内部互联的总线及暴漏给外部的总线。

由于 Wiredng 可能支持多处理器配置，因此 Wiredng 也实现了一套基于 Bluespec 语言的 CrossBar，WiredXbar。
