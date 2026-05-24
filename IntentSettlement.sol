// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./ERC7683Structs.sol";

interface ISettlementContract {
    function initiate(ERC7683Structs.CrossChainOrder calldata order) external payable;
    function resolve(ERC7683Structs.CrossChainOrder calldata order) external view returns (ERC7683Structs.ResolvedCrossChainOrder memory);
}

/**
 * @title IntentSettlement
 * @dev Implementation of an ERC-7683 compliant Cross-Chain intent handler.
 */
contract IntentSettlement is ISettlementContract {
    
    event OrderInitiated(bytes32 indexed orderHash, address indexed swapper);
    event OrderFilled(bytes32 indexed orderHash, address indexed filler);

    /**
     * @notice Initiates a cross-chain order on the origin chain.
     */
    function initiate(ERC7683Structs.CrossChainOrder calldata order) external payable override {
        require(block.timestamp <= order.initiateDeadline, "Initiation deadline passed");
        
        bytes32 orderHash = keccak256(abi.encode(order));
        
        // In production, user funds are locked here using a standard Permit2 validation execution flow.
        
        emit OrderInitiated(orderHash, order.swapper);
    }

    /**
     * @notice Decodes an arbitrary order payload into structural inputs readable by open Fillers.
     */
    function resolve(ERC7683Structs.CrossChainOrder calldata order) 
        external 
        pure 
        override 
        returns (ERC7683Structs.ResolvedCrossChainOrder memory) 
    {
        // Decode custom information hidden inside orderData payload parameters
        (ERC7683Structs.Output[] memory maxSpent, ERC7683Structs.Output[] memory minReceived) = 
            abi.decode(order.orderData, (ERC7683Structs.Output[], ERC7683Structs.Output[]));

        return ERC7683Structs.ResolvedCrossChainOrder({
            settlementContract: order.settlementContract,
            swapper: order.swapper,
            nonce: order.nonce,
            originChainId: order.originChainId,
            initiateDeadline: order.initiateDeadline,
            fillDeadline: order.fillDeadline,
            maxSpent: maxSpent,
            minReceived: minReceived
        });
    }
}
