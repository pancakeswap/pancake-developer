---
description: Prediction 
---

# How to bet and claim

This guide explains how to **place bets**, **claim rewards**, and **check user round status** on Prediction contracts.

:::info
BNB Prediction and ETH/BTC Prediction have slight differences. These are highlighted in the Differences section.
:::


## Bet 

**Function Signature**
```solidity
/// @param epoch The round number you want to bet on
/// @dev msg.value The amount of BNB to bet (minimum 0.001 BNB worth)
function betBull(uint256 epoch) external payable whenNotPaused nonReentrant;
function betBear(uint256 epoch) external payable whenNotPaused nonReentrant;
```

**Requirements**
- Round must be in betting phase (`_bettable(epoch) == true`)
- `msg.value >= minBetAmount` (0.001 BNB)
- User can only bet once per round


## Claim

**Function Signature**
```solidity
/// @param epochs Array of round numbers to claim rewards for
function claim(uint256[] calldata epochs) external nonReentrant;
```

**Requirements**
- Round must have ended (`block.timestamp > round.closeTimestamp`)
- User must have a winning bet or be eligible for refund
- User must not have already claimed for that round

## Check Claimable Status

**Function Signature**
```solidity
/// @return true if user can claim for the epoch
function claimable(uint256 epoch, address user) public view returns (bool)
```

## User round

**Get User's Betting History**
```solidity
/// @param user user address to query
/// @param cursor starting index for pagination
/// @param size number of rounds to return
/// @return epochNum Array of epoch numbers
/// @return betInfo Array of bet information
/// @return nextCursorPosition Next cursor position
function getUserRounds(address user, uint256 cursor, uint256 size)
    external
    view
    returns (uint256[] memory epochNum, BetInfo[] memory betInfo, uint256 nextCursorPosition);
```

## Get Round Information
```solidity
/// @param epoch The round number to check
/// @return round Round information
function rounds(uint256 epoch) public view returns (Round memory);
```

## Differences between BNB and ETH/BTC prediction

BNB Prediction (deployed in 2021) and ETH/BTC Prediction (deployed in 2025) have slightly different struct definitions for gas optimization purpose.

1. Round Struct

BNB Prediction
```solidity
struct Round {
    uint256 epoch;
    uint256 startTimestamp;
    uint256 lockTimestamp;
    uint256 closeTimestamp;
    int256 lockPrice;
    int256 closePrice;
    uint256 lockOracleId;
    uint256 closeOracleId;
    uint256 totalAmount;
    uint256 bullAmount;
    uint256 bearAmount;
    uint256 rewardBaseCalAmount;
    uint256 rewardAmount;
    bool oracleCalled;
}
```

ETH/BTC Prediction
```solidity
struct Round {
    uint256 epoch;
    uint64 startTimestamp;
    uint64 lockTimestamp;
    uint64 closeTimestamp;
    int256 lockPrice;
    int256 closePrice;
    uint80 lockOracleId;
    uint80 closeOracleId;
    bool oracleCalled;
    uint256 totalAmount;
    uint256 bullAmount;
    uint256 bearAmount;
    uint256 rewardBaseCalAmount;
    uint256 rewardAmount;
}
```

2. BetInfo Struct

BNB Prediction
```solidity
struct BetInfo {
    Position position;
    uint256 amount;
    bool claimed; 
}
```

ETH/BTC Prediction
```solidity
struct BetInfo {
        Position position;
        bool claimed;
        uint256 amount;
    }
```
