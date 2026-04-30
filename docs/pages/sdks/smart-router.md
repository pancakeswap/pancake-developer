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

## Key APIs

### SmartRouter

| Function | Description |
| --- | --- |
| `SmartRouter.getBestTrade(amount, currency, tradeType, config)` | Find the optimal route for a trade |
| `SmartRouter.createQuoteProvider(options)` | Create an on-chain quote provider |
| `SmartRouter.createStaticPoolProvider(pools)` | Wrap a pre-fetched pool list |
| `SmartRouter.getV2CandidatePools(options)` | Fetch V2 pair candidates |
| `SmartRouter.getV3CandidatePools(options)` | Fetch V3 pool candidates |

### SwapRouter

| Function | Description |
| --- | --- |
| `SwapRouter.swapCallParameters(trade, options)` | Build `{ calldata, value }` for submission |

### Constants

| Export | Description |
| --- | --- |
| `SMART_ROUTER_ADDRESSES` | Router contract addresses keyed by `ChainId` |

## Import path

The EVM router exports are under the `/evm` subpath:

```typescript
import { SmartRouter } from '@pancakeswap/smart-router/evm'
```

## Source

[github.com/pancakeswap/pancake-frontend — packages/smart-router](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/smart-router)
