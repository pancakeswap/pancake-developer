---
description: SDK for PancakeSwap Infinity — concentrated liquidity (CL) and liquidity book (Bin) pool interactions.
---

# Infinity SDK

TypeScript SDK for PancakeSwap Infinity. Supports both concentrated liquidity (CL) pools and Liquidity Book (Bin) pools. Provides pool math, position management, and calldata builders for the Infinity contracts.

## Installation

```bash
npm install @pancakeswap/infinity-sdk
```

## Quick start

```typescript
import {
  CLPool,
  CLPositionManager,
  PoolKey,
} from '@pancakeswap/infinity-sdk'
import { Token, CurrencyAmount } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'

const USDC = new Token(ChainId.BSC, '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d', 18, 'USDC')
const CAKE = new Token(ChainId.BSC, '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82', 18, 'CAKE')

// Define a pool key
const poolKey: PoolKey = {
  currency0: USDC,
  currency1: CAKE,
  fee: 2500,
  tickSpacing: 50,
  hooks: '0x0000000000000000000000000000000000000000',
}

// Build add-liquidity calldata for CL
const { calldata, value } = CLPositionManager.addLiquidity({
  poolKey,
  tickLower: -100,
  tickUpper:  100,
  amount0Desired: CurrencyAmount.fromRawAmount(USDC, 1_000_000n),
  amount1Desired: CurrencyAmount.fromRawAmount(CAKE, 10n ** 18n),
  recipient: '0xYOUR_ADDRESS',
  deadline: Math.floor(Date.now() / 1000) + 60 * 20,
})
```

## PoolKey

Uniquely identifies an Infinity pool.

```typescript
interface PoolKey {
  currency0: Currency   // lower-sorted token
  currency1: Currency   // higher-sorted token
  fee: number           // fee in hundredths of a bip (e.g. 2500 = 0.25%)
  tickSpacing: number   // tick spacing for CL pools
  hooks: string         // hooks contract address (use zero address for no hooks)
}
```

## CLPool

CL (concentrated liquidity) pool state and swap simulation.

```typescript
new CLPool(currency0, currency1, fee, tickSpacing, hooks, sqrtPriceX96, liquidity, tick, ticks?)
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `currency0` | `Currency` | The lower-sorted token |
| `currency1` | `Currency` | The higher-sorted token |
| `fee` | `number` | Fee tier |
| `tickSpacing` | `number` | Tick spacing |
| `hooks` | `string` | Hooks contract address |
| `sqrtPriceX96` | `bigint` | Current sqrt price in Q64.96 format |
| `liquidity` | `bigint` | Active liquidity at the current tick |
| `tick` | `number` | Current tick index |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `getOutputAmount` | `(inputAmount) → [CurrencyAmount, CLPool]` | Simulate a swap and return output + resulting pool state |
| `getInputAmount` | `(outputAmount) → [CurrencyAmount, CLPool]` | Compute required input for a desired output |
| `priceOf` | `(currency) → Price` | Price of a currency in terms of the other |

## CLPositionManager

Static helpers for building calldata targeting the Infinity CL position manager.

| Method | Signature | Description |
| --- | --- | --- |
| `addLiquidity` | `(options) → { calldata: string, value: string }` | Mint a new CL position or increase an existing one |
| `removeLiquidity` | `(options) → { calldata: string, value: string }` | Decrease liquidity and receive tokens |
| `collect` | `(options) → { calldata: string, value: string }` | Collect accumulated fees |
| `burn` | `(options) → { calldata: string, value: string }` | Burn an empty position NFT |

### addLiquidity options

| Option | Type | Description |
| --- | --- | --- |
| `poolKey` | `PoolKey` | Pool identifier |
| `tickLower` | `number` | Lower tick of the range |
| `tickUpper` | `number` | Upper tick of the range |
| `amount0Desired` | `CurrencyAmount` | Desired token0 deposit |
| `amount1Desired` | `CurrencyAmount` | Desired token1 deposit |
| `amount0Min` | `CurrencyAmount` | Minimum token0 (slippage guard) |
| `amount1Min` | `CurrencyAmount` | Minimum token1 (slippage guard) |
| `recipient` | `string` | Address to receive the position NFT |
| `deadline` | `number` | Unix timestamp deadline |
| `tokenId` | `bigint` | If set, increases an existing position |

## BinPool

Liquidity Book (Bin) pool state.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `currency0` | `Currency` | The lower-sorted token |
| `currency1` | `Currency` | The higher-sorted token |
| `fee` | `number` | Fee tier |
| `binStep` | `number` | Bin step (price granularity) |
| `hooks` | `string` | Hooks contract address |
| `activeId` | `number` | Currently active bin ID |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `getOutputAmount` | `(inputAmount) → [CurrencyAmount, BinPool]` | Simulate a swap |
| `priceOf` | `(currency) → Price` | Price of a currency in terms of the other |
| `BinPool.getPriceFromId` | `(binId, binStep) → bigint` | Compute the price at a given bin ID |
| `BinPool.getIdFromPrice` | `(price, binStep) → number` | Compute the bin ID for a given price |

## BinPositionManager

Static helpers for building Bin position calldata.

| Method | Signature | Description |
| --- | --- | --- |
| `addLiquidity` | `(options) → { calldata: string, value: string }` | Add liquidity to one or more bins |
| `removeLiquidity` | `(options) → { calldata: string, value: string }` | Remove liquidity from bins |

## Vault

Interact with the Infinity Vault — the central settlement contract.

| Method | Signature | Description |
| --- | --- | --- |
| `Vault.take` | `(currency, to, amount) → string` | Encode a take (withdraw) action |
| `Vault.settle` | `(currency) → string` | Encode a settle (deposit) action |
| `Vault.sync` | `(currency) → string` | Sync vault accounting for a currency |

## Infinity contracts

See [Infinity contract addresses](/contracts/infinity/resources/addresses) for deployed addresses.
