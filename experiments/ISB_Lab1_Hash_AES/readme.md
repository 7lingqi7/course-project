# 🔐 Experiment: File Hashing and AES Encryption GUI

This project implements a cross-platform GUI application that performs **SHA-256 hashing** and **AES encryption/decryption** on user-selected files. It combines cryptographic primitives with a user-friendly interface for interactive file security operations.

> 📝 The complete code is embedded in the experiment report: `Experiment 1.doc`

---

## 🧰 Features

- **SHA-256 hash calculation** of any selected file
- **AES-256 encryption and decryption** using CBC mode and PKCS7 padding
- Interactive GUI using `tkinter` with buttons to:
  - Select file
  - Hash file
  - Encrypt file
  - Decrypt file
- Status updates and message boxes for user feedback

---

## 🧠 Workflow

1. Launch GUI
2. Select any file (e.g., `1.txt`)
3. Click "Compute SHA-256 Hash" to see its digest
4. Click "Encrypt File" to generate `.enc` file
5. Click "Decrypt File" to restore `.dec` version from `.enc`

---

## 📦 Libraries Used

- `hashlib` – SHA-256 hashing
- `cryptography.hazmat` – AES encryption in CBC mode
- `tkinter` – GUI construction
- `os`, `ttk`, `filedialog`, `messagebox` – File I/O and user interaction

---

## 🗂️ File Structure

- `Experiment 1.doc` – Report and embedded Python code
- `1.txt` – Test file for encryption and decryption
- `1.txt.enc` – Encrypted output
- `1.txt.dec` – Decrypted output

