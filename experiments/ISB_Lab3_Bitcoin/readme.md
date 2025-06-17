# 🧪 Experiment 3: Bitcoin Account and Transaction Simulation

### 📝 Description

This experiment demonstrates two core concepts in Bitcoin:

1. **Bitcoin Account Generation**  
   A program generates a Bitcoin account from a 256-bit random number. It outputs:
   - Private Key  
   - Public Key (via SECP256k1 elliptic curve)  
   - Bitcoin Address (via SHA-256, RIPEMD-160, and Base58 encoding)

2. **Bitcoin Transaction Simulation (Optional Task)**  
   Simulates a Bitcoin transaction between Account A and Account B:
   - Transaction includes sender, receiver, amount, and timestamp  
   - Uses SHA-256 for hashing and elliptic curve cryptography for signing  
   - Implements signature verification using the sender’s public key  

---

### 🔍 Features

- Full implementation of Bitcoin account generation using ECC and Base58
- Step-by-step simulation of a digital signature-based transaction
- Manual implementation of core cryptographic functions: SHA-256, modular inversion, ECC scalar multiplication

---

### 🖼️ Screenshots

- Includes code outputs of generated keys and addresses
- Includes transaction message, hash, digital signature, and signature verification result

---

### 📦 Libraries Used

- `os` – for random byte generation  
- `hashlib` – for SHA-256 hashing  
- Manual implementation of RIPEMD-160 and Base58  
- No third-party crypto libraries used (for educational purpose)

---

### 📁 Code Location

All source code is included in the **Appendix** of the attached report:  
📄 `Experiment3_Zuyi Liao.pdf`

---

