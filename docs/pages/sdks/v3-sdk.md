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

## Key exports

### Classes

| Class | Description |
| --- | --- |
| `Pool` | Represents a V3 liquidity pool |
| `Position` | A liquidity position within a pool |
| `Route` | A path through one or more pools |
| `Trade` | A computed swap against a route |
| `Tick` | A single tick in a pool |
| `TickListDataProvider` | Tick data from a sorted list |

### Contract helpers

| Export | Description |
| --- | --- |
| `NonfungiblePositionManager` | Build mint/increase/decrease/collect calldata |
| `SwapRouter` | Build swap calldata for the V3 router |
| `Quoter` | Estimate output amounts on-chain |
| `MasterChefV3` | Build staking/harvest calldata |

### Constants

| Export | Description |
| --- | --- |
| `FeeAmount` | Fee tier enum: `LOWEST` (100), `LOW` (500), `MEDIUM` (2500), `HIGH` (10000) |
| `TICK_SPACINGS` | Tick spacing per fee tier |

## Source

[github.com/pancakeswap/pancake-frontend — packages/v3-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/v3-sdk)
