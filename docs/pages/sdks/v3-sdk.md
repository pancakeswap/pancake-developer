---
description: SDK for PancakeSwap V3 concentrated liquidity — pool math, position management, and swap routing.
---

# V3 SDK

TypeScript SDK for PancakeSwap V3 concentrated liquidity. Provides pool math, position management, quote computation, and helpers for building swap and liquidity transactions.

## Installation

```bash
npm install @pancakeswap/v3-sdk
```

## Quick start

```typescript
import { Pool, Position, NonfungiblePositionManager, FeeAmount } from '@pancakeswap/v3-sdk'
import { Token, CurrencyAmount, Percent } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'

const USDC = new Token(ChainId.BSC, '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d', 18, 'USDC')
const CAKE = new Token(ChainId.BSC, '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82', 18, 'CAKE')

// Construct pool from on-chain state
const pool = new Pool(
  USDC,
  CAKE,
  FeeAmount.MEDIUM,    // 2500 = 0.25%
  sqrtPriceX96,        // current sqrt price from contract
  liquidity,           // current liquidity from contract
  tickCurrent,         // current tick from contract
)

// Build a position
const position = new Position({
  pool,
  liquidity: 10n ** 18n,
  tickLower: -60,
  tickUpper:  60,
})

// Get add-liquidity calldata
const { calldata, value } = NonfungiblePositionManager.addCallParameters(position, {
  slippageTolerance: new Percent(5, 1000),
  recipient: '0xYOUR_ADDRESS',
  deadline: Math.floor(Date.now() / 1000) + 60 * 20,
})
```

## Pool

Represents a V3 liquidity pool and exposes swap simulation.

```typescript
new Pool(tokenA, tokenB, fee, sqrtRatioX96, liquidity, tickCurrent, ticks?)
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `token0` | `Token` | The lower-sorted token |
| `token1` | `Token` | The higher-sorted token |
| `fee` | `FeeAmount` | Fee tier |
| `sqrtRatioX96` | `bigint` | Current sqrt price in Q64.96 format |
| `liquidity` | `bigint` | Active liquidity at the current tick |
| `tickCurrent` | `number` | Current tick index |
| `tickSpacing` | `number` | Minimum tick movement for this fee tier |
| `token0Price` | `Price` | Price of token0 denominated in token1 |
| `token1Price` | `Price` | Price of token1 denominated in token0 |
| `chainId` | `number` | Chain ID (from tokens) |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `getOutputAmount` | `(inputAmount, sqrtPriceLimitX96?) → [CurrencyAmount, Pool]` | Simulate a swap and return output amount + resulting pool state |
| `getInputAmount` | `(outputAmount, sqrtPriceLimitX96?) → [CurrencyAmount, Pool]` | Compute the required input for a desired output |
| `priceOf` | `(token) → Price` | Return the price of a token in terms of the other |
| `involvesToken` | `(token) → boolean` | Whether the pool contains a given token |

## Position

A liquidity position within a V3 pool.

```typescript
new Position({ pool, liquidity, tickLower, tickUpper })
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `pool` | `Pool` | The pool this position belongs to |
| `liquidity` | `bigint` | Position liquidity |
| `tickLower` | `number` | Lower tick bound |
| `tickUpper` | `number` | Upper tick bound |
| `token0PriceLower` | `Price` | token0 price at the lower tick |
| `token0PriceUpper` | `Price` | token0 price at the upper tick |
| `amount0` | `CurrencyAmount` | token0 amount at the current price |
| `amount1` | `CurrencyAmount` | token1 amount at the current price |
| `mintAmounts` | `{ amount0: bigint, amount1: bigint }` | Required token amounts to mint this position |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `mintAmountsWithSlippage` | `(slippageTolerance) → { amount0: bigint, amount1: bigint }` | Mint amounts adjusted for slippage |
| `burnAmountsWithSlippage` | `(slippageTolerance) → { amount0: bigint, amount1: bigint }` | Minimum burn amounts after slippage |
| `Position.fromAmount0` | `({ pool, tickLower, tickUpper, amount0, useFullPrecision }) → Position` | Construct a position from a fixed token0 amount |
| `Position.fromAmount1` | `({ pool, tickLower, tickUpper, amount1 }) → Position` | Construct a position from a fixed token1 amount |
| `Position.fromAmounts` | `({ pool, tickLower, tickUpper, amount0, amount1, useFullPrecision }) → Position` | Construct a position from both amounts (uses the tighter constraint) |

## NonfungiblePositionManager

Static helpers for building calldata targeting the V3 NFT position manager contract.

| Method | Signature | Description |
| --- | --- | --- |
| `addCallParameters` | `(position, options) → { calldata: string, value: string }` | Mint a new position or increase liquidity |
| `removeCallParameters` | `(position, options) → { calldata: string, value: string }` | Decrease liquidity and collect tokens |
| `collectCallParameters` | `(options) → { calldata: string, value: string }` | Collect fees for an existing position |
| `safeTransferFromParameters` | `(options) → { calldata: string, value: string }` | Transfer an NFT position to another address |

### addCallParameters options

| Option | Type | Description |
| --- | --- | --- |
| `recipient` | `string` | Address to receive the NFT (new mint only) |
| `deadline` | `number` | Unix timestamp deadline |
| `slippageTolerance` | `Percent` | Maximum slippage on amounts |
| `tokenId` | `number` | If provided, increases an existing position instead of minting |
| `useNative` | `NativeCurrency` | If provided, wraps native currency automatically |

## Trade

A computed trade against one or more routes.

### Static constructors

| Method | Signature | Description |
| --- | --- | --- |
| `Trade.fromRoute` | `(route, amount, tradeType) → Promise<Trade>` | Build a trade from a single route |
| `Trade.fromRoutes` | `(routes, tradeType) → Promise<Trade>` | Build a split trade from multiple routes |
| `Trade.bestTradeExactIn` | `(pools, amountIn, currencyOut, options?) → Promise<Trade[]>` | Find best exact-input trades |
| `Trade.bestTradeExactOut` | `(pools, currencyIn, amountOut, options?) → Promise<Trade[]>` | Find best exact-output trades |

### Properties and methods

| Member | Type / Signature | Description |
| --- | --- | --- |
| `swaps` | `{ route, inputAmount, outputAmount }[]` | Individual route swaps |
| `tradeType` | `TradeType` | EXACT_INPUT or EXACT_OUTPUT |
| `inputAmount` | `CurrencyAmount` | Total input across all routes |
| `outputAmount` | `CurrencyAmount` | Total output across all routes |
| `executionPrice` | `Price` | Effective execution price |
| `priceImpact` | `Percent` | Price impact vs mid-price |
| `minimumAmountOut` | `(slippageTolerance, amountOut?) → CurrencyAmount` | Worst-case output after slippage |
| `maximumAmountIn` | `(slippageTolerance, amountIn?) → CurrencyAmount` | Worst-case input after slippage |
| `worstExecutionPrice` | `(slippageTolerance) → Price` | Worst acceptable execution price |

## SwapRouter

| Method | Signature | Description |
| --- | --- | --- |
| `SwapRouter.swapCallParameters` | `(trades, options) → { calldata: string, value: string }` | Build calldata for the V3 SwapRouter contract |

## Route

| Property | Type | Description |
| --- | --- | --- |
| `pools` | `Pool[]` | Ordered list of pools in the path |
| `tokenPath` | `Token[]` | Ordered list of tokens along the path |
| `input` | `Currency` | Input currency |
| `output` | `Currency` | Output currency |
| `midPrice` | `Price` | Geometric mid-price across the route |
| `chainId` | `number` | Chain ID |

## Constants

| Export | Description |
| --- | --- |
| `FeeAmount.LOWEST` | 100 (0.01%) |
| `FeeAmount.LOW` | 500 (0.05%) |
| `FeeAmount.MEDIUM` | 2500 (0.25%) |
| `FeeAmount.HIGH` | 10000 (1%) |
| `TICK_SPACINGS` | `Record<FeeAmount, number>` — tick spacing per fee tier |
