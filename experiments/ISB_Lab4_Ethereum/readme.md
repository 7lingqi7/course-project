# 🧾 Ethereum and Smart Contract: Ownership Transfer & ERC20 Token Deployment

This project focuses on simulating ownership transfer and ERC20 token issuance using Solidity smart contracts deployed via Remix IDE. The report includes complete source code, interface screenshots, and transaction logs.

## 🧪 Tasks Overview

### Task 1: Ownership Transfer Smart Contract

- Built with Solidity on Remix VM (Shanghai)
- Transfer logic includes:
  - Buyer pays 1 ETH to the contract
  - Only the current owner can approve the transfer
  - Buyer can request a refund before approval
- Key functions:
  - `transferOwnership()`
  - `acceptOwnership()`
  - `Refund()`

### Task 2: ERC20 Token Deployment (Optional)

- Token Name: `Humble`, Symbol: `HB`
- Built on Sepolia testnet using MetaMask
- Used OpenZeppelin’s ERC20 implementation
- Functions demonstrated:
  - `transfer`
  - `approve`
  - `transferFrom`
  - `allowance`

## 🖼️ Demo Highlights

- Transfer and refund logs captured in Remix
- MetaMask integration with token import
- Multi-account interaction for ERC20 transactions

## 📦 Libraries Used

- `solidity ^0.8.0`
- `@openzeppelin/contracts`
- Remix IDE built-in environment

## 📁 Report

All smart contract code and interaction screenshots are included in the report document.

