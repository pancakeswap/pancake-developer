---
description: Pre-configured token objects for all PancakeSwap supported chains.
---

# @pancakeswap/tokens

Pre-configured `Token` instances for major tokens on every chain PancakeSwap supports. Use these instead of constructing tokens manually to avoid address typos and ensure consistency.

## Installation

```bash
npm install @pancakeswap/tokens
```

## Quick start

```typescript
import { bscTokens, ethTokens, arbitrumTokens, baseTokens } from '@pancakeswap/tokens'
import { CurrencyAmount } from '@pancakeswap/swap-sdk-core'

// Access tokens directly
const cake  = bscTokens.cake   // CAKE on BSC
const usdt  = bscTokens.usdt   // USDT on BSC
const weth  = ethTokens.weth   // WETH on Ethereum
const usdc  = baseTokens.usdc  // USDC on Base

// Build an amount
const amount = CurrencyAmount.fromRawAmount(cake, 10n ** 18n) // 1 CAKE
```

## Available token lists

| Export | Chain |
| --- | --- |
| `bscTokens` | BNB Smart Chain |
| `ethTokens` | Ethereum |
| `arbitrumTokens` | Arbitrum One |
| `baseTokens` | Base |
| `zkSyncTokens` | zkSync Era |
| `lineaTokens` | Linea |
| `opBnbTokens` | opBNB |
| `solanaTokens` | Solana |

Testnet equivalents are also exported (e.g. `bscTestnetTokens`, `sepoliaTestnetTokens`).

## Source

[github.com/pancakeswap/pancake-frontend — packages/tokens](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/tokens)
