---
description: Build Exclusive Dutch Order trades for PancakeSwap X — the intent-based, MEV-protected swap product.
---

# @pancakeswap/pcsx-sdk

Build and sign Exclusive Dutch Order (EDO) trades for PancakeSwap X (PCSX). Dutch orders fill at a decaying price over a short window, guaranteeing MEV protection and price improvement for traders.

## Installation

```bash
npm install @pancakeswap/pcsx-sdk
```

## Quick start

```typescript
import {
  createExclusiveDutchOrderTrade,
  ExclusiveDutchOrderTrade,
} from '@pancakeswap/pcsx-sdk'
import { Token, CurrencyAmount, TradeType } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'
import { bscTokens } from '@pancakeswap/tokens'

// Create an EDO trade
const trade = createExclusiveDutchOrderTrade({
  chainId: ChainId.BSC,
  currencyIn: bscTokens.cake,
  currencyOut: bscTokens.usdt,
  inputAmount: CurrencyAmount.fromRawAmount(bscTokens.cake, 10n ** 18n),
  outputStartAmount: CurrencyAmount.fromRawAmount(bscTokens.usdt, 3_900_000n), // start price
  outputEndAmount: CurrencyAmount.fromRawAmount(bscTokens.usdt, 3_800_000n),   // floor price
  tradeType: TradeType.EXACT_INPUT,
  orderInfo: {
    deadline: Math.floor(Date.now() / 1000) + 60,
    exclusiveFiller: '0xFILLER_ADDRESS',
    exclusivityOverrideBps: 0n,
    nonce: 1n,
  },
})

// Sign with Permit2 and submit to the PCSX order API
```

## Key exports

| Export | Description |
| --- | --- |
| `createExclusiveDutchOrderTrade(options)` | Build an EDO trade object |
| `ExclusiveDutchOrderTrade` | EDO trade class with encoding helpers |
| `REACTOR_ADDRESS_MAPPING` | Dutch order reactor addresses by chain |

## PCSX contract addresses

See [PancakeSwap X addresses](/contracts/pcsx/addresses) for deployed reactor addresses.

## Source

[github.com/pancakeswap/pancake-frontend — packages/pcsx-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/pcsx-sdk)
