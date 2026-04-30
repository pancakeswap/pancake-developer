---
description: Core primitives for PancakeSwap swap SDKs — Token, CurrencyAmount, Fraction, Price, and Percent.
---

# Swap SDK Core

Core primitives used across all PancakeSwap swap SDKs. Provides currency types, fractional arithmetic, and amount/price representations for both EVM and Solana chains.

## Installation

```bash
npm install @pancakeswap/swap-sdk-core
```

## Quick start

```typescript
import { Token, CurrencyAmount, Price, Percent, Fraction } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'

const USDC = new Token(ChainId.ETHEREUM, '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48', 6, 'USDC', 'USD Coin')
const DAI  = new Token(ChainId.ETHEREUM, '0x6B175474E89094C44Da98b954EedeAC495271d0F', 18, 'DAI', 'Dai')

const oneUSDC = CurrencyAmount.fromRawAmount(USDC, 1_000_000n)       // 1 USDC (6 decimals)
const slippage = new Percent(50, 10_000) // 0.5%
const minOut   = oneUSDC.multiply(new Fraction(1).subtract(slippage))

const price = new Price(USDC, DAI, 1_000_000n, 10n ** 18n)
console.log(price.toSignificant(6)) // "1.00000"
```

## Token

Represents an ERC-20 token.

```typescript
new Token(chainId, address, decimals, symbol?, name?, projectLink?, logoURI?)
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `chainId` | `number` | Chain ID where the token is deployed |
| `address` | `string` | Checksummed contract address |
| `decimals` | `number` | Token decimal places |
| `symbol` | `string \| undefined` | Ticker symbol |
| `name` | `string \| undefined` | Full token name |
| `isNative` | `false` | Always false for Token |
| `isToken` | `true` | Always true for Token |
| `wrapped` | `Token` | Returns itself (tokens are already wrapped) |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `equals` | `(other: Currency) → boolean` | True if same chain and address |
| `sortsBefore` | `(other: Token) → boolean` | True if this token address sorts before the other |

## NativeCurrency

Abstract base class for native currencies (ETH, BNB, etc.).

| Property | Type | Description |
| --- | --- | --- |
| `chainId` | `number` | Chain ID |
| `decimals` | `number` | Decimal places (usually 18) |
| `symbol` | `string` | Ticker (e.g. "ETH", "BNB") |
| `name` | `string` | Full name |
| `isNative` | `true` | Always true |
| `isToken` | `false` | Always false |
| `wrapped` | `Token` | The wrapped ERC-20 equivalent (e.g. WETH) |

## CurrencyAmount

A fractional amount of a currency with decimal-aware formatting.

### Static constructors

| Method | Signature | Description |
| --- | --- | --- |
| `CurrencyAmount.fromRawAmount` | `(currency, rawAmount) → CurrencyAmount` | From an on-chain integer (e.g. `1000000n` for 1 USDC) |
| `CurrencyAmount.fromFractionalAmount` | `(currency, numerator, denominator) → CurrencyAmount` | From a numerator/denominator pair |

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `currency` | `Currency` | The currency this amount represents |
| `decimalScale` | `bigint` | 10^decimals |
| `numerator` | `bigint` | Raw numerator |
| `denominator` | `bigint` | Raw denominator |
| `quotient` | `bigint` | Integer part of the amount |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `add` | `(other: CurrencyAmount) → CurrencyAmount` | Add two amounts of the same currency |
| `subtract` | `(other: CurrencyAmount) → CurrencyAmount` | Subtract |
| `multiply` | `(other: Fraction \| bigint) → CurrencyAmount` | Scale by a fraction |
| `divide` | `(other: Fraction \| bigint) → CurrencyAmount` | Divide by a fraction |
| `toSignificant` | `(significantDigits, format?, rounding?) → string` | Format to N significant digits |
| `toFixed` | `(decimalPlaces?, format?, rounding?) → string` | Format to fixed decimal places |
| `toExact` | `(format?) → string` | Exact decimal string representation |
| `wrapped` | getter → `CurrencyAmount<Token>` | Wrapped version (for native currencies) |

## Fraction

Arbitrary-precision rational number.

```typescript
new Fraction(numerator, denominator?)  // denominator defaults to 1
```

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `numerator` | `bigint` | Numerator |
| `denominator` | `bigint` | Denominator |
| `quotient` | `bigint` | Integer division result |
| `remainder` | `Fraction` | Fractional remainder |
| `asFraction` | `Fraction` | Returns itself |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `invert` | `() → Fraction` | Swap numerator and denominator |
| `add` | `(other: Fraction \| bigint) → Fraction` | Add |
| `subtract` | `(other: Fraction \| bigint) → Fraction` | Subtract |
| `multiply` | `(other: Fraction \| bigint) → Fraction` | Multiply |
| `divide` | `(other: Fraction \| bigint) → Fraction` | Divide |
| `lessThan` | `(other: Fraction \| bigint) → boolean` | Comparison |
| `equalTo` | `(other: Fraction \| bigint) → boolean` | Equality |
| `greaterThan` | `(other: Fraction \| bigint) → boolean` | Comparison |
| `toSignificant` | `(significantDigits, format?, rounding?) → string` | Format |
| `toFixed` | `(decimalPlaces, format?, rounding?) → string` | Format |

## Percent

A `Fraction` subclass for percentages. All arithmetic returns `Percent`.

```typescript
new Percent(numerator, denominator?)  // e.g. new Percent(1, 100) = 1%
```

Inherits all `Fraction` methods. `toSignificant` and `toFixed` output the human-readable percentage (e.g. `new Percent(1, 100).toSignificant(2)` → `"1"`).

## Price

Exchange rate between two currencies.

```typescript
new Price(baseCurrency, quoteCurrency, denominator, numerator)
```

| Parameter | Description |
| --- | --- |
| `baseCurrency` | The input currency |
| `quoteCurrency` | The output currency |
| `denominator` | Base currency amount (integer) |
| `numerator` | Quote currency amount (integer) |

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `baseCurrency` | `Currency` | Input currency |
| `quoteCurrency` | `Currency` | Output currency |
| `scalar` | `Fraction` | Decimal adjustment ratio |
| `adjustedForDecimals` | `Fraction` | Price fraction adjusted for both token decimals |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `invert` | `() → Price` | Return the inverse price |
| `multiply` | `(other: Price) → Price` | Compose two prices (base → quote → other) |
| `quote` | `(currencyAmount: CurrencyAmount) → CurrencyAmount` | Apply the price to an amount |
| `toSignificant` | `(significantDigits, format?, rounding?) → string` | Human-readable price |
| `toFixed` | `(decimalPlaces, format?, rounding?) → string` | Fixed-decimal price |
