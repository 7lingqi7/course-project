## 🧾 Network Layer – Ethernet & ARP Analysis Lab

This project investigates how data is transmitted and resolved at the **link layer**, focusing on **Ethernet frame structure** and the **Address Resolution Protocol (ARP)**. The analysis is conducted using Wireshark packet captures and hands-on interpretation of frame content.

---

### 🔍 Part 1: Ethernet Frame Analysis

- Extracted and analyzed the **48-bit MAC (Ethernet) address** of the local machine and destination devices.
- Identified the **destination address** (typically a router or gateway) and explained why it differs from the ultimate server's MAC address (e.g., gaia.cs.umass.edu).
- Located specific **ASCII characters** (e.g., "G" in "GET" and "O" in "OK") in the Ethernet frame by calculating their byte offsets.
- Verified the **EtherType field** as `0x0800`, confirming the encapsulated protocol is IPv4.
- Differentiated between **source and destination MAC addresses** to understand the direction and origin of packets.

---

### 🌐 Part 2: ARP (Address Resolution Protocol)

- Analyzed ARP request and reply messages within captured Ethernet frames.
- Identified **broadcast destination addresses** (`ff:ff:ff:ff:ff:ff`) used in ARP requests.
- Interpreted the **ARP reply**, locating:
  - Opcode value indicating reply (`0x0002`)
  - IP-to-MAC mapping information in the payload
- Measured byte offsets (e.g., 21 bytes from frame start to ARP opcode field).

---

### 📌 Key Takeaways

- Ethernet does not deliver frames directly to distant hosts; it forwards to the **next-hop router**, requiring MAC address resolution through ARP.
- ARP is a critical protocol for translating **IP addresses to MAC addresses** within a subnet.
- Tools like **Wireshark** are essential for packet-level analysis and understanding network communication flow.

