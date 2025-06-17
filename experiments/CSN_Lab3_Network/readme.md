## 🌐 Network Layer Assignment

This project focuses on implementing two foundational **routing algorithms** in the network layer using Python: **Dijkstra's Algorithm** and the **Distance-Vector Algorithm**.

### 🎯 Objectives
- Understand core routing algorithms used in IP networks
- Implement graph-based shortest path algorithms in Python
- Simulate dynamic route calculation and table generation

### 🧠 Algorithms Implemented

#### 1. Dijkstra Algorithm
- Computes the shortest path from a source node to all other nodes in a weighted graph.
- Uses a priority-based selection of the minimum-cost path at each iteration.
- Outputs the path and minimum distance to all nodes.

#### 2. Distance-Vector Algorithm
- Implements a distributed routing model where each node exchanges routing tables with its neighbors.
- Updates routes iteratively until convergence.
- Simulates dynamic routing environments and cost propagation.

### ⚙️ Features
- Simple Python implementation using loops, functions, lists, and dictionaries.
- Easily configurable network topology: just modify the cost matrix and source node.
- Routing tables and paths can be printed for any node.

### 📌 Key Takeaways
- Both algorithms are essential in real-world routing protocols (e.g., RIP uses Distance-Vector, OSPF uses Dijkstra).
- Dijkstra is more centralized and precise, while Distance-Vector simulates decentralized decision-making.
- Efficient topology design and cost management are critical in network performance.

