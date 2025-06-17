## 🚦 Transport Layer Assignment

This experiment implements the **Stop-and-Wait protocol** using Python's socket programming to explore core concepts of transport layer communication over TCP and UDP.

### 🔧 Objectives
- Understand the fundamentals of TCP/UDP socket programming
- Implement reliable data transfer via Stop-and-Wait protocol
- Simulate packet loss and test retransmission logic
- Compare behavior between localhost and peer-to-peer communication

### 🧪 Experiment Setup
#### 1. Localhost Communication
- Sent 10 and 100 packets with simulated packet loss rates (0.2 and 0.5)
- Observed server-client behavior under different loss conditions

#### 2. Peer-to-Peer Communication
- Conducted tests between two machines on the same network
- Measured latency, retransmissions, and protocol behavior in real network conditions

### 📌 Key Takeaways
- **TCP vs UDP**: TCP provides built-in reliability, while UDP requires manual handling of errors and retransmission.
- **Packet Loss Impact**: Higher loss leads to more retransmissions and longer total transfer times.
- **Timeout Sensitivity**: Timeout settings greatly influence performance and reliability.
- **Practical Issues**: Proper IP addressing and firewall configuration are crucial, especially for UDP where client ports vary per transmission.

