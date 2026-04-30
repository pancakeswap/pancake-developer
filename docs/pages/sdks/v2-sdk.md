---
description: SDK for PancakeSwap V2 AMM — pair interactions, trade routing, and liquidity management.
---

# @pancakeswap/v2-sdk

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
const route = new Route([pair], CAKE, BUSD)
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

## Key exports

| Export | Description |
| --- | --- |
| `Pair` | A V2 liquidity pair |
| `Route` | A single-path route through pairs |
| `Trade` | A computed swap against a route |
| `Router` | Build calldata for the V2 Router contract |
| `Fetcher` | Fetch pair data from on-chain state |

## Source

[github.com/pancakeswap/pancake-frontend — packages/v2-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/v2-sdk)
