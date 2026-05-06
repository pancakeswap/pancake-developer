---
description: Fetch token prices from the PancakeSwap price API.
---

# Price API SDK

Fetch USD and native-currency prices for any token on PancakeSwap supported chains, using the PancakeSwap price API.

## Installation

```bash
npm install @pancakeswap/price-api-sdk
```

## Quick start

```typescript
import {
  getCurrencyPrice,
  getCurrencyListUsdPrice,
  getTokenPrices,
  getNativeTokenPrices,
} from '@pancakeswap/price-api-sdk'
import { ChainId } from '@pancakeswap/chains'
import { bscTokens } from '@pancakeswap/tokens'

// Single token price
const cakePrice = await getCurrencyPrice({
  currency: bscTokens.cake,
  chainId: ChainId.BSC,
})
console.log(`CAKE: $${cakePrice}`)

// Multiple tokens at once
const prices = await getCurrencyListUsdPrice({
  currencies: [bscTokens.cake, bscTokens.usdt],
  chainId: ChainId.BSC,
})
// { '0x0E09...': 2.34, '0x55d3...': 1.00 }

// Raw addresses (more efficient for large lists)
const tokenPrices = await getTokenPrices({
  chainId: ChainId.BSC,
  addresses: ['0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82'],
})
```

## Functions

### getCurrencyPrice

```typescript
getCurrencyPrice(options: {
  currency: Currency
  chainId: ChainId
}) → Promise<number>
```

Fetch the USD price for a single currency. Returns `0` if the price is unavailable.

### getCurrencyListUsdPrice

```typescript
getCurrencyListUsdPrice(options: {
  currencies: Currency[]
  chainId: ChainId
}) → Promise<Record<string, number>>
```

Fetch USD prices for a list of currencies in a single request. Returns a map of checksummed address → price.

### getTokenPrices

```typescript
getTokenPrices(options: {
  chainId: ChainId
  addresses: string[]
}) → Promise<Record<string, number>>
```

Fetch prices by raw token addresses. More efficient than `getCurrencyListUsdPrice` when you already have addresses and don't need `Token` objects.

### getNativeTokenPrices

```typescript
getNativeTokenPrices(options: {
  chainIds: ChainId[]
}) → Promise<Record<number, number>>
```

Fetch the native currency (ETH, BNB, etc.) USD price for one or more chains. Returns a map of chainId → price.

### getPoolType

```typescript
getPoolType(pool: Pool) → PoolType
```

Determine the pool type from a pool object.

| Return value | Description |
| --- | --- |
| `PoolType.V2` | PancakeSwap V2 pair |
| `PoolType.V3` | PancakeSwap V3 CL pool |
| `PoolType.STABLE` | Stable pool |
| `PoolType.CL` | Infinity CL pool |
| `PoolType.BIN` | Infinity Bin pool |

## Constants

| Export | Description |
| --- | --- |
| `PoolType` | Enum of pool types |
| `orderPriceApiParsers` | Parse price API responses for order (PCSX) workflows |
