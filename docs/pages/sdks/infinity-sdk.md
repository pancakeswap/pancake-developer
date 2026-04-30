---
description: SDK for PancakeSwap Infinity — concentrated liquidity (CL) and liquidity book (Bin) pool interactions.
---

# @pancakeswap/infinity-sdk

TypeScript SDK for PancakeSwap Infinity. Supports both concentrated liquidity (CL) pools and Liquidity Book (Bin) pools. Provides pool math, position management, and calldata builders for the Infinity contracts.

## Installation

```bash
npm install @pancakeswap/infinity-sdk
```

## Quick start

```typescript
import {
  CLPool,
  BinPool,
  CLPositionManager,
  PoolKey,
  Currency,
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

## Key exports

### CL (Concentrated Liquidity)

| Export | Description |
| --- | --- |
| `CLPool` | CL pool state and math |
| `CLPositionManager` | Build mint/increase/decrease calldata |
| `CLQuoter` | Estimate output amounts |

### Bin (Liquidity Book)

| Export | Description |
| --- | --- |
| `BinPool` | Bin pool state and math |
| `BinPositionManager` | Build add/remove liquidity calldata |

### Shared

| Export | Description |
| --- | --- |
| `PoolKey` | Pool identifier struct |
| `Vault` | Interact with the Infinity Vault |
| ABIs | All Infinity contract ABIs |

## Infinity contracts

See [Infinity contract addresses](/contracts/infinity/resources/addresses) for deployed addresses.

## Source

[github.com/pancakeswap/pancake-frontend — packages/infinity-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/infinity-sdk)
