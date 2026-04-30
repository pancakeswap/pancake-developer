---
description: Fetch token prices from the PancakeSwap price API.
---

# @pancakeswap/price-api-sdk

Fetch USD and native-currency prices for any token on PancakeSwap supported chains, using the PancakeSwap price API.

## Installation

```bash
npm install @pancakeswap/price-api-sdk
```

## Quick start

```typescript
import { getCurrencyPrice } from '@pancakeswap/price-api-sdk'
import { ChainId } from '@pancakeswap/chains'
import { bscTokens } from '@pancakeswap/tokens'

// Fetch USD price of CAKE on BSC
const price = await getCurrencyPrice({
  currency: bscTokens.cake,
  chainId: ChainId.BSC,
})

console.log(`CAKE price: $${price}`)
```

## Key exports

| Export | Description |
| --- | --- |
| `getCurrencyPrice(options)` | Fetch the USD price for a given currency |
| `getPoolType(pool)` | Determine pool type (V2, V3, Infinity CL, Infinity Bin) |
| `orderPriceApiParsers` | Parse price API responses for order workflows |

## Source

[github.com/pancakeswap/pancake-frontend — packages/price-api-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/price-api-sdk)
