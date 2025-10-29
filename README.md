# 🍪 Oreo – Verifiable Result Record System  
*A Solidity smart contract for transparent, tamper-proof academic result verification.*

---

## 📖 Project Description

**Oreo** is a blockchain-based record system designed for schools and universities to securely store and verify student results.  
Instead of keeping grades or certificates in centralized databases, Oreo stores **cryptographic proofs (hashes)** of those results on-chain — ensuring that they cannot be tampered with or forged.

It’s a simple, transparent, and beginner-friendly implementation built using **Solidity** and deployable on **EVM-compatible chains** such as Ethereum, Polygon, or Celo.

---

## 🎯 What It Does

✅ **Stores** verifiable result records for each student and course.  
✅ **Prevents tampering** – once added, results are publicly verifiable.  
✅ **Verifies** authenticity of a student’s record using hashes (IPFS or SHA).  
✅ **Revokes** results if the university needs to invalidate or update them.  
✅ **Ensures privacy** by storing only hashed identifiers (no personal info on-chain).  

---

## ✨ Features

- 🧾 **Add, Update, and Revoke Results**  
  Only the contract owner (school admin) can manage result records.

- 🔍 **Verify Results**  
  Anyone (employers, students, or institutions) can verify the authenticity of a record using the stored hash.

- ⏰ **Timestamped Records**  
  Each entry is automatically timestamped, providing a verifiable proof of when it was added or modified.

- 🔐 **Ownership Control**  
  Ownership can be transferred to another admin or institution account.

- 🌍 **Interoperable**  
  Works seamlessly with any EVM-compatible blockchain (Celo, Polygon, Ethereum, etc.).

---

## 🧠 Smart Contract Overview

**Contract Name:** `Oreo`  
**Language:** Solidity ^0.8.17  
**License:** MIT  

### Key Functions:
| Function | Description |
|-----------|-------------|
| `addResult(studentId, course, resultHash)` | Adds a new result record. |
| `updateResult(studentId, course, newResultHash)` | Updates an existing result. |
| `revokeResult(studentId, course)` | Marks a result as invalid. |
| `verifyResult(studentId, course, expectedHash)` | Verifies if the stored hash matches the provided one. |
| `getResult(studentId, course)` | Returns result details and timestamp. |
| `transferOwnership(newOwner)` | Transfers contract ownership. |

---

## 🔗 Deployed Contract

**Network:** Celo (Testnet - Celo Sepolia)  
**Smart Contract Address:**  
[`0x22EF2004c9c1BF2E8C74Be5C1e4A6d1fE862F96c`](https://celo-sepolia.blockscout.com/address/0x22EF2004c9c1BF2E8C74Be5C1e4A6d1fE862F96c)

You can view the verified contract and transactions on **Blockscout** using the link above.

---

## 🧩 Tech Stack

- **Solidity** – Smart contract language  
- **Remix IDE / Hardhat** – Development and deployment  
- **Celo Sepolia Testnet** – Blockchain network  
- **Blockscout** – For transaction and contract verification  
- *(Optional)* IPFS – For decentralized result file storage

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/oreo-result-system.git
cd oreo-result-system


<img width="1914" height="1073" alt="Screenshot 2025-10-29 135423" src="https://github.com/user-attachments/assets/4ef959b8-d3df-463a-818d-9141f2a5b0d4" />
