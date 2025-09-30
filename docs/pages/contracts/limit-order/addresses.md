---
description: Limit order
---

# Limit Order 

The `CLLimitOrderHook` is a smart contract hook that extends PancakeSwap Infinity's concentrated liquidity functionality to support limit orders. This hook enables developers to implement automated trading strategies by placing orders at specific price levels that execute when market conditions are met.

## How It Works

The limit order system leverages PancakeSwap Infinity's concentrated liquidity architecture:

- **Single-sided Liquidity**: Users deposit tokens on one side of a price range
- **Tick-based Execution**: Orders are placed at specific price ticks and execute when the pool price crosses those ticks
- **Automatic Filling**: Orders are filled automatically during normal swap operations
- **Fee Distribution**: Trading fees are collected and distributed to order participants

## Key Features for Developers

### 1. **Limit Order Placement**

Place a limit order
```solidity
/// @notice Place a new limit order at a specific tick.
/// @dev The order will be filled when the pool price crosses the specified `tick`.
/// @param key to place limit order
/// @param tick the tick at which to place the limit order
/// @param zeroForOne direction of the order
/// @param liquidity amount of liquidity to place
/// @return amount0 amount of currency0 the user pays for this order
/// @return amount1 amount of currency1 the user pays for this order
function placeOrder(PoolKey calldata key, int24 tick, bool zeroForOne, uint128 liquidity) external returns (uint256, uint256);
```

### 2. **Cancel Orders**

Remove unfilled orders before execution and reclaim your liquidity plus any accrued fees.

```solidity
/// @notice Cancels a limit order by removing liquidity from the pool.
/// Note that partial cancellation is not supported - the entire liquidity added by the msg.sender will be removed.
/// Note also that cancelling an order will cancel the order placed by the msg.sender, not orders placed by other users in the same tick range.
/// @param orderId The unique identifier of the order to cancel
/// @param to The address to receive the returned tokens (principal + fees)
/// @return amount0 The amount of currency0 returned to the user (principal + fees)
/// @return amount1 The amount of currency1 returned to the user (principal + fees)
function cancelOrder(OrderIdLibrary.OrderId orderId, address to) external returns (uint256, uint256);
```

**Key Points:**
- Only cancels orders with `OrderStatus.Open` (not yet executed)
- Returns both principal and any accrued trading fees
- Partial cancellation is not supported - entire user position is removed
- Only affects the caller's position, not other users' orders at the same tick

### 3. **Withdraw Filled Orders**

Claim tokens from completed orders after they have been executed. Currently PCS have a bot to help withdraw when the order is filled.

```solidity
/// @notice Withdraws liquidity from a filled order, sending it to address `to`.
/// @dev This function can only be called after the order is filled - use `cancelOrder` to remove liquidity from unfilled orders.
/// @param orderId The unique identifier of the filled order
/// @param to The address to receive the tokens
/// @return amount0 Total amount user received in currency0
/// @return amount1 Total amount user received in currency1
function withdraw(OrderIdLibrary.OrderId orderId, address to) external returns (uint256 amount0, uint256 amount1);
```

### 4. **Order Status Lifecycle**

Orders progress through three states:

- **`Open`**: Order is active and waiting for price to cross the target tick
- **`Pending`**: Order has been executed but liquidity removal is pending
- **`Filled`**: Order is executed, liquidity removed


### 5. **Fee Collection**

- **Trading Fees**: Orders automatically earn fees when they provide liquidity during swaps
- **Automatic Distribution**: Fees are distributed proportionally to order participants
- **Fee Withdrawal**: Fees are included when canceling or withdrawing orders

## Contract Addresses

### CLLimitOrderHook

**Mainnet**

| Chain | Address                                    |
| ----- | ------------------------------------------ |
| BSC   | 0x6AdC560aF85377f9a73d17c658D798c9B39186e8 |

