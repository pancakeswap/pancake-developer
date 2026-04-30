---
description: Find optimal swap routes across PancakeSwap V2, V3, and Infinity pools.
---

# Smart Router

Finds the best trade route across all PancakeSwap liquidity sources — V2 pairs, V3 concentrated liquidity pools, and Infinity pools. Handles split routing, multi-hop paths, and on-chain price quoting.

## Installation

```bash
npm install @pancakeswap/smart-router
```

## Quick start

```typescript
import { SmartRouter, SwapRouter, SMART_ROUTER_ADDRESSES } from '@pancakeswap/smart-router/evm'
import { CurrencyAmount, TradeType, Percent } from '@pancakeswap/swap-sdk-core'
import { bscTokens } from '@pancakeswap/tokens'
import { ChainId } from '@pancakeswap/chains'
import { createPublicClient, http } from 'viem'
import { bsc } from 'viem/chains'

const client = createPublicClient({ chain: bsc, transport: http() })

const quoteProvider = SmartRouter.createQuoteProvider({
  onChainProvider: () => client,
})

const [v2Pools, v3Pools] = await Promise.all([
  SmartRouter.getV2CandidatePools({
    onChainProvider: () => client,
    currencyA: bscTokens.cake,
    currencyB: bscTokens.usdt,
  }),
  SmartRouter.getV3CandidatePools({
    onChainProvider: () => client,
    subgraphProvider: () => null,
    currencyA: bscTokens.cake,
    currencyB: bscTokens.usdt,
  }),
])

const trade = await SmartRouter.getBestTrade(
  CurrencyAmount.fromRawAmount(bscTokens.cake, 10n ** 18n),
  bscTokens.usdt,
  TradeType.EXACT_INPUT,
  {
    gasPriceWei: () => client.getGasPrice(),
    poolProvider: SmartRouter.createStaticPoolProvider([...v2Pools, ...v3Pools]),
    quoteProvider,
    maxHops: 3,
    maxSplits: 4,
  },
)

// Build transaction calldata
const { value, calldata } = SwapRouter.swapCallParameters(trade, {
  recipient: '0xYOUR_ADDRESS',
  slippageTolerance: new Percent(50, 10000), // 0.5%
})
```

## Import path

EVM router exports are under the `/evm` subpath:

```typescript
import { SmartRouter, SwapRouter } from '@pancakeswap/smart-router/evm'
```

## SmartRouter

| Method | Signature | Description |
| --- | --- | --- |
| `getBestTrade` | `(amount, currency, tradeType, config) → Promise<SmartRouterTrade>` | Find the optimal route across all pool types |
| `createQuoteProvider` | `(options: { onChainProvider }) → QuoteProvider` | Create an on-chain quote provider backed by a viem client |
| `createStaticPoolProvider` | `(pools: Pool[]) → PoolProvider` | Wrap a pre-fetched pool list as a provider |
| `getV2CandidatePools` | `(options) → Promise<V2Pool[]>` | Fetch V2 pair candidates for a token pair |
| `getV3CandidatePools` | `(options) → Promise<V3Pool[]>` | Fetch V3 pool candidates for a token pair |
| `getStableCandidatePools` | `(options) → Promise<StablePool[]>` | Fetch Stable pool candidates |
| `getMixedCandidatePools` | `(options) → Promise<Pool[]>` | Fetch candidates across all pool types |

### getBestTrade config

| Option | Type | Description |
| --- | --- | --- |
| `gasPriceWei` | `() => Promise<bigint>` | Current gas price for route cost estimation |
| `poolProvider` | `PoolProvider` | Pool data source |
| `quoteProvider` | `QuoteProvider` | On-chain or off-chain quoter |
| `maxHops` | `number` | Maximum route hops (default: 3) |
| `maxSplits` | `number` | Maximum split paths (default: 4) |
| `allowedPoolTypes` | `PoolType[]` | Restrict which pool types to consider |
| `distributionPercent` | `number` | Split granularity (default: 5) |

## SwapRouter

| Method | Signature | Description |
| --- | --- | --- |
| `swapCallParameters` | `(trade, options) → { calldata: Hex, value: string }` | Build calldata for the SmartRouter contract |

### swapCallParameters options

| Option | Type | Description |
| --- | --- | --- |
| `recipient` | `string` | Address to receive output tokens |
| `slippageTolerance` | `Percent` | Maximum acceptable slippage |
| `deadline` | `number` | Unix timestamp after which the tx reverts |
| `inputTokenPermit` | `object` | Optional Permit2 signature for the input token |

## Constants

| Export | Type | Description |
| --- | --- | --- |
| `SMART_ROUTER_ADDRESSES` | `Record<ChainId, Address>` | Deployed SmartRouter addresses per chain |
| `V2_ROUTER_ADDRESS` | `Record<ChainId, Address>` | V2 router addresses per chain |
