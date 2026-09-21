---
description: Fetch token prices from the PancakeSwap price API.
---

# Price API SDK

Fetch USD prices for any token on PancakeSwap supported chains, using the PancakeSwap price API.

## Installation

```bash
npm install @pancakeswap/price-api-sdk
```

## Quick start

```typescript
import { ChainId } from '@pancakeswap/chains'
import {
  getCurrencyUsdPrice,
  getCurrencyListUsdPrice,
  getCurrencyKey,
  getTokenPrices,
  getNativeTokenPrices,
} from '@pancakeswap/price-api-sdk'

const CAKE = '0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82'
const USDT = '0x55d398326f99059fF775485246999027B3197955'

// One currency
const cakePrice = await getCurrencyUsdPrice({ chainId: ChainId.BSC, address: CAKE })

// Several at once — the result is keyed, not ordered
const prices = await getCurrencyListUsdPrice([
  { chainId: ChainId.BSC, address: CAKE },
  { chainId: ChainId.BSC, isNative: true },
])
prices[getCurrencyKey({ chainId: ChainId.BSC, address: CAKE })!]

// By raw address — returns an array in the order given
const [cake, usdt] = await getTokenPrices(ChainId.BSC, [CAKE, USDT])
cake.priceUSD

// Native currency of several chains — a Map
const natives = await getNativeTokenPrices([ChainId.BSC, ChainId.ETHEREUM])
natives.get(ChainId.BSC)
```

## Identifying a currency

Every price function takes `CurrencyParams` rather than a `Currency` object — a chain id plus either a token address or the native flag. `chainName` is required only on non-EVM chains.

```typescript
type CurrencyParams =
  | { chainId: ChainId; chainName?: string; address: string; isNative?: false }
  | { chainId: ChainId; chainName?: string; isNative: true }
  | { chainId: NonEVMChainId; chainName: string; address: string; isNative?: false }
  | { chainId: NonEVMChainId; chainName: string; isNative: true }
```

### getCurrencyKey

```typescript
getCurrencyKey(currencyParams?: CurrencyParams) → CurrencyKey | undefined
// CurrencyKey = `${number}:${string}`
```

The key a currency takes in the result of `getCurrencyListUsdPrice`. On EVM chains it is `` `${chainId}:${address}` `` with the address **lowercased**, and the native currency uses the zero address. On Solana it is the bare mint address. Use this helper rather than building the key by hand.

## Functions

### getCurrencyUsdPrice

```typescript
getCurrencyUsdPrice(
  currencyParams?: CurrencyParams,
  options?: RequestInit,
) → Promise<number>
```

USD price of a single currency. Returns `0` when the currency is missing, sits on a testnet, or has no price. Without `options`, calls are batched with other in-flight requests and briefly cached.

### getCurrencyListUsdPrice

```typescript
getCurrencyListUsdPrice(
  currencyListParams?: CurrencyParams[],
  options?: RequestInit,
) → Promise<Record<CurrencyKey, number>>
```

USD prices for a list of currencies in a single request, keyed by `getCurrencyKey`. Throws if `currencyListParams` is omitted and no `options` are given.

### getTokenPrices

```typescript
getTokenPrices(
  chainId: ChainId,
  addresses: Address[],
  options?: RequestInit,
) → Promise<{ address: Address; priceUSD: number }[]>
```

Prices for several token addresses on one chain. Returns one entry per requested address, in the same order, with `priceUSD: 0` where no price is available — convenient when you already hold addresses and do not want to build the keys yourself.

### getNativeTokenPrices

```typescript
getNativeTokenPrices(
  chainIds: ChainId[],
  options?: RequestInit,
) → Promise<Map<ChainId, number>>
```

USD price of the native currency (BNB, ETH, …) for one or more chains. Note the return is a `Map`, not a plain object.

### getPoolType / getPoolTypeKey

```typescript
getPoolType(type: string) → PoolType | undefined
getPoolTypeKey(poolType: PoolType) → PoolTypeKey
```

Convert between a pool type's name and its `PoolType` enum value. `getPoolType` takes the **key as a string** (the form the price API returns) and gives `undefined` for an unknown one; `getPoolTypeKey` goes the other way and throws on an invalid value.

`PoolType` itself is not re-exported here — import it from `@pancakeswap/smart-router`. This package exports the key types `PoolTypeKey` and `PoolTypeKeys`.

| Key | Description |
| --- | --- |
| `V2` | PancakeSwap v2 pair |
| `V3` | PancakeSwap v3 CL pool |
| `STABLE` | StableSwap pool |
| `InfinityCL` | Infinity CL pool |
| `InfinityBIN` | Infinity Bin pool |
| `InfinityStable` | Infinity stable pool |
| `SVM` | Solana pool |
| `MM` | Market maker quote |

## Also exported

| Export | Description |
| --- | --- |
| `getRequestBody` | Build a price API request body for an order (PCSX) quote |
| `parseQuoteResponse` / `parseAMMPriceResponse` | Parse the price API's quote responses |
| `PoolTypeKey`, `PoolTypeKeys`, `TradeTypeKey` | Key types for the enums the API reports |
| `zeroAddress` | The address the API uses for a chain's native currency |
