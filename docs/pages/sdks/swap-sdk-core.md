---
description: Core primitives for PancakeSwap swap SDKs — Token, CurrencyAmount, Fraction, Price, and Percent.
---

# @pancakeswap/swap-sdk-core

Core primitives used across all PancakeSwap swap SDKs. Provides currency types, fractional arithmetic, and amount/price representations for both EVM and Solana chains.

## Installation

```bash
npm install @pancakeswap/swap-sdk-core
```

## Quick start

```typescript
import { Token, CurrencyAmount, Price, Percent, Fraction } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'

// Define tokens
const USDC = new Token(ChainId.ETHEREUM, '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48', 6, 'USDC', 'USD Coin')
const DAI  = new Token(ChainId.ETHEREUM, '0x6B175474E89094C44Da98b954EedeAC495271d0F', 18, 'DAI', 'Dai')

// Create amounts
const oneUSDC = CurrencyAmount.fromRawAmount(USDC, 1_000_000n)       // 1 USDC (6 decimals)
const oneDAI  = CurrencyAmount.fromRawAmount(DAI, 10n ** 18n)        // 1 DAI  (18 decimals)

// Slippage tolerance
const slippage = new Percent(50, 10_000) // 0.5%
const minOut = oneDAI.multiply(new Fraction(1).subtract(slippage))

// Price
const price = new Price(USDC, DAI, 1_000_000n, 10n ** 18n) // 1 USDC = 1 DAI
console.log(price.toSignificant(6)) // "1.00000"
```

## Key classes

### Token

Represents an ERC-20 token.

```typescript
new Token(chainId: number, address: string, decimals: number, symbol?: string, name?: string)
```

| Property | Type | Description |
| --- | --- | --- |
| `chainId` | `number` | Chain ID where the token is deployed |
| `address` | `string` | Checksummed contract address |
| `decimals` | `number` | Token decimal places |
| `symbol` | `string` | Ticker symbol |
| `name` | `string` | Full token name |

### CurrencyAmount

A fractional amount of a currency.

```typescript
CurrencyAmount.fromRawAmount(currency, rawAmount)     // from on-chain integer
CurrencyAmount.fromFractionalAmount(currency, num, denom)
```

Supports `add`, `subtract`, `multiply`, `divide`, `toSignificant`, `toFixed`.

### Percent / Fraction

Arbitrary-precision rational number arithmetic.

```typescript
new Percent(numerator, denominator?)  // e.g. new Percent(1, 100) = 1%
new Fraction(numerator, denominator?)
```

### Price

Represents the exchange rate between two currencies.

```typescript
new Price(baseCurrency, quoteCurrency, denominator, numerator)
price.toSignificant(5)
price.invert()
```

## Source

[github.com/pancakeswap/pancake-frontend — packages/swap-sdk-core](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/swap-sdk-core)
