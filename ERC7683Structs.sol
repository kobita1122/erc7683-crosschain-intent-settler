// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @notice Core structural definitions matching the ERC-7683 specification.
 */
library ERC7683Structs {
    struct Output {
        address token;
        uint256 amount;
        address recipient;
        uint32 chainId;
    }

    struct CrossChainOrder {
        address settlementContract;
        address swapper;
        uint64 nonce;
        uint32 originChainId;
        uint32 initiateDeadline;
        uint32 fillDeadline;
        bytes orderData; // Arbitrary field parsing custom pricing patterns (e.g. Dutch Auctions)
    }

    struct ResolvedCrossChainOrder {
        address settlementContract;
        address swapper;
        uint64 nonce;
        uint32 originChainId;
        uint32 initiateDeadline;
        uint32 fillDeadline;
        Output[] maxSpent;
        Output[] minReceived;
    }
}
