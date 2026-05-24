# ERC-7683 Cross-Chain Intent Settler

In the 2026 multi-rollup Ethereum ecosystem, cross-chain fragmentation is solved through intent-based architectures rather than legacy locking bridges. Co-developed by Across Protocol and Uniswap Labs, **ERC-7683** standardizes how cross-chain orders are created, resolved, and fulfilled by open solver (filler) networks. 

This repository provides a professional-grade, flat-structured reference implementation of an ERC-7683 compliant settler and solver framework.

## Architecture & Flow
1. **User Signature:** The Swapper signs an off-chain EIP-712 transaction (`CrossChainOrder`) specifying their exact target outcome.
2. **Order Dissemination:** The intent is sent to an open pool of competitive Fillers.
3. **Resolution:** Fillers call `resolve()` via `eth_call` to decode the requirements and verify execution safety.
4. **On-Chain Settlement:** The winning filler triggers execution via the `ISettlementContract` interface, fulfilling the user's intent across chains seamlessly.

## Setup Instructions
1. Install development dependencies: `npm install @openzeppelin/contracts`
2. Compile the contract using Hardhat, Foundry, or Remix.
3. Deploy to any compatible EVM Layer 2 (Arbitrum, Optimism, Base) to act as a settlement layer.

## Technical Specifications
- **Standard:** ERC-7683 (Cross-Chain Intents)
- **Language:** Solidity ^0.8.24
- **Licensing:** MIT
