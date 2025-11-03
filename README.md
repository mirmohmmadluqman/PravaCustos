# Prava Custos

## Overview

Prava Custos is a decentralized application enabling private entity creation and ownership proof using cryptographic validation and off-chain encrypted storage. It prioritizes privacy, anonymity, and secure ownership transfer without relying on KYC or public identity.

## Key Features

* **Private Entity Creation**: Generate unique IDs and encrypted metadata.
* **Encrypted Storage**: Store entity data on IPFS using AES encryption.
* **On-Chain Hashing**: Password hash stored on Ethereum smart contract.
* **Ownership Proof**: Verify ownership through password hashing and decryption.
* **Secure Transfer**: Update encrypted data and password to transfer ownership.
* **No KYC / Anonymous**: Full privacy via cryptographic identity.
* **Post-Quantum Future Ready Goal**: Incorporate PQ cryptography in future upgrades.

## Architecture

| Layer             | Function                                                      |
| ----------------- | ------------------------------------------------------------- |
| Smart Contract    | Stores entity hash + control logic                            |
| Off-Chain Storage | IPFS for encrypted entity data                                |
| Encryption        | AES encryption + keccak256 hashing                            |
| Frontend          | Minimal UI (HTML/CSS/JS) for entity creation and verification |


## Workflow

1. User enters entity information
2. Data encrypted with AES
3. Password hashed (keccak256)
4. Hash stored on-chain
5. Encrypted data pushed to IPFS
6. User verifies ownership via password match and decryption

## Future Goals

* Anonymous and know both legal companies, land and assests ownership infrastructure
* Post-quantum cryptography integration
* Decentralized identity network (DID)

## License

Apache 2.0 License (open-source compliance)

## Author

Mir Mohmmad Luqman
[mirmohmmadluqman@gmail.com](mailto:mirmohmmadluqman@gmail.com)
