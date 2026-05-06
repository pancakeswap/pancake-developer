---
description: SDK for PancakeSwap V2 AMM — pair interactions, trade routing, and liquidity management.
---

# V2 SDK

TypeScript SDK for PancakeSwap V2 AMM. Provides pair math, trade computation, and helpers for building swap and liquidity transactions against V2 pools.

## Installation

```bash
npm install @pancakeswap/v2-sdk
```

## Quick start

```typescript
import { Pair, Trade, Route, Router } from '@pancakeswap/v2-sdk'
import { Token, CurrencyAmount, TradeType, Percent } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'

const CAKE = new Token(ChainId.BSC, '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82', 18, 'CAKE')
const BUSD = new Token(ChainId.BSC, '0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56', 18, 'BUSD')

// Construct pair from on-chain reserves
const pair = new Pair(
  CurrencyAmount.fromRawAmount(CAKE, reserveCAKE),
  CurrencyAmount.fromRawAmount(BUSD, reserveBUSD),
)

// Find best trade
const [trade] = Trade.bestTradeExactIn(
  [pair],
  CurrencyAmount.fromRawAmount(CAKE, 10n ** 18n),
  BUSD,
)

// Build calldata
const { methodName, args, value } = Router.swapCallParameters(trade, {
  ttl: 50,
  recipient: '0xYOUR_ADDRESS',
  allowedSlippage: new Percent(1, 100), // 1%
})
```

## Pair

Represents a V2 AMM pair and its reserves.

```typescript
new Pair(currencyAmountA, currencyAmountB)
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `token0` | `Token` | The lower-sorted token |
| `token1` | `Token` | The higher-sorted token |
| `reserve0` | `CurrencyAmount` | Reserve of token0 |
| `reserve1` | `CurrencyAmount` | Reserve of token1 |
| `token0Price` | `Price` | Price of token0 in terms of token1 |
| `token1Price` | `Price` | Price of token1 in terms of token0 |
| `liquidityToken` | `Token` | The LP token for this pair |
| `chainId` | `number` | Chain ID (from tokens) |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `reserveOf` | `(token) → CurrencyAmount` | Reserve of a given token |
| `getOutputAmount` | `(inputAmount) → [CurrencyAmount, Pair]` | Simulate a swap; returns output and resulting pair |
| `getInputAmount` | `(outputAmount) → [CurrencyAmount, Pair]` | Compute required input for a desired output |
| `getLiquidityMinted` | `(totalSupply, tokenAmountA, tokenAmountB) → CurrencyAmount` | LP tokens minted for a deposit |
| `getLiquidityValue` | `(token, totalSupply, liquidity, feeOn?, kLast?) → CurrencyAmount` | Token amount redeemable for LP tokens |
| `involvesToken` | `(token) → boolean` | Whether the pair contains a given token |
| `Pair.getAddress` | `(tokenA, tokenB) → string` | Compute the deterministic pair address |

## Route

A single-path route through one or more pairs.

```typescript
new Route(pairs, input, output?)
```

| Property | Type | Description |
| --- | --- | --- |
| `pairs` | `Pair[]` | Ordered list of pairs in the route |
| `path` | `Token[]` | Ordered token path |
| `input` | `Currency` | Input currency |
| `output` | `Currency` | Output currency |
| `midPrice` | `Price` | Geometric mid-price across the route |
| `chainId` | `number` | Chain ID |

## Trade

A computed swap along a route.

### Static constructors

| Method | Signature | Description |
| --- | --- | --- |
| `Trade.exactIn` | `(route, amountIn) → Trade` | Exact-input trade |
| `Trade.exactOut` | `(route, amountOut) → Trade` | Exact-output trade |
| `Trade.bestTradeExactIn` | `(pairs, currencyAmountIn, currencyOut, options?) → Trade[]` | Find the best exact-input trades; sorted best-first |
| `Trade.bestTradeExactOut` | `(pairs, currencyIn, currencyAmountOut, options?) → Trade[]` | Find the best exact-output trades; sorted best-first |

### bestTradeExactIn / bestTradeExactOut options

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `maxNumResults` | `number` | 3 | Maximum number of results to return |
| `maxHops` | `number` | 3 | Maximum route hops |

### Properties and methods

| Member | Type / Signature | Description |
| --- | --- | --- |
| `route` | `Route` | The route this trade follows |
| `tradeType` | `TradeType` | EXACT_INPUT or EXACT_OUTPUT |
| `inputAmount` | `CurrencyAmount` | Input amount |
| `outputAmount` | `CurrencyAmount` | Output amount |
| `executionPrice` | `Price` | Effective execution price |
| `priceImpact` | `Percent` | Price impact vs mid-price |
| `minimumAmountOut` | `(slippageTolerance) → CurrencyAmount` | Minimum output after slippage |
| `maximumAmountIn` | `(slippageTolerance) → CurrencyAmount` | Maximum input after slippage |

## Router

Static helpers for building V2 Router calldata.

| Method | Signature | Description |
| --- | --- | --- |
| `Router.swapCallParameters` | `(trade, tradeOptions) → { methodName, args, value }` | Build swap calldata for the V2 Router |

### tradeOptions

| Option | Type | Description |
| --- | --- | --- |
| `allowedSlippage` | `Percent` | Maximum slippage tolerance |
| `recipient` | `string` | Address to receive output tokens |
| `ttl` | `number` | Deadline in seconds from now |
| `deadline` | `number` | Absolute Unix timestamp deadline (alternative to `ttl`) |
| `feeOnTransfer` | `boolean` | Use `supportingFeeOnTransfer` router methods |

## Fetcher

Fetch pair data from on-chain state.

| Method | Signature | Description |
| --- | --- | --- |
| `Fetcher.fetchPairData` | `(tokenA, tokenB, provider?) → Promise<Pair>` | Fetch reserves and construct a Pair |
