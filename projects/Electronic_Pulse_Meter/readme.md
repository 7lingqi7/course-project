## 📟 电子脉搏仪设计与实现

### 📌 项目概述

本设计实现了一个基于红外传感的电子脉搏测试仪，通过检测人体脉搏跳动信号，在30秒内测量并计算1分钟的脉搏次数。  
项目综合应用了模拟电路、数字电路和EDA技术，包含完整的硬件设计、Multisim仿真和电路板实现。

---
### Physical Circuit (Front and Back)

**Back View:**  
![Back](./physical%20circuit_back.jpg)

**Front View:**  
![Front](./physical%20circuit_front.jpg)

---
### 🔧 信号处理流程图

```mermaid
graph LR
A[传感器] --> B[放大电路]
B --> C[滤波电路]
C --> D[整形电路]
D --> E[门控电路]
E --> F[计数电路]
F --> G[译码显示]
---
