---
description: Build Exclusive Dutch Order trades for PancakeSwap X — the intent-based, MEV-protected swap product.
---

# PCSX SDK

Build and sign Exclusive Dutch Order (EDO) trades for PancakeSwap X (PCSX). Dutch orders fill at a decaying price over a short window, guaranteeing MEV protection and price improvement for traders.

## Installation

```bash
npm install @pancakeswap/pcsx-sdk
```

## Quick start

```typescript
import {
  createExclusiveDutchOrderTrade,
} from '@pancakeswap/pcsx-sdk'
import { parseQuoteResponse } from '@pancakeswap/price-api-sdk'
import { TradeType } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'
import { bscTokens } from '@pancakeswap/tokens'

// 1. Fetch a quote from the PCSX price API
const res = await fetch('/api/price-quote', { ... })
const quoteResponse = await res.json()

// 2. Parse the quote — encodedOrder and permitData come from the API
const result = parseQuoteResponse(quoteResponse, {
  chainId: ChainId.BSC,
  currencyIn: bscTokens.cake,
  currencyOut: bscTokens.usdt,
  tradeType: TradeType.EXACT_INPUT,
})

const trade = result.trade  // ExclusiveDutchOrderTrade

// 3. Sign with Permit2 using the permitData from the trade
const signature = await walletClient.signTypedData(trade.permitData)

// 4. Submit the encoded order + signature to the filler network
await submitOrder({ encodedOrder: trade.encodedOrder, signature })
```

## createExclusiveDutchOrderTrade

```typescript
createExclusiveDutchOrderTrade(options: {
  currencyIn: Currency
  currenciesOut: [Currency, ...Currency[]]
  orderInfo: ExclusiveDutchOrderInfo
  tradeType: TradeType
  encodedOrder: Hex
  permitData: PermitWitnessTransferFromData
}) → ExclusiveDutchOrderTrade
```

Constructs an `ExclusiveDutchOrderTrade` from a PCSX API quote response. `encodedOrder` and `permitData` are provided by the API (typically via `parseQuoteResponse` from `@pancakeswap/price-api-sdk`).

### ExclusiveDutchOrderInfo

| Field | Type | Description |
| --- | --- | --- |
| `deadline` | `number` | Unix timestamp when the order expires |
| `exclusiveFiller` | `string` | Address of the exclusive filler; use `address(0)` for open fill |
| `exclusivityOverrideBps` | `bigint` | Bps premium allowed for non-exclusive fillers during the exclusivity window |
| `nonce` | `bigint` | Unique nonce for Permit2 |

## ExclusiveDutchOrderTrade

Plain object encapsulating an EDO trade returned by `createExclusiveDutchOrderTrade` or `parseQuoteResponse`.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `tradeType` | `TradeType` | EXACT_INPUT or EXACT_OUTPUT |
| `inputAmount` | `CurrencyAmount` | Input amount |
| `outputAmount` | `CurrencyAmount` | Best-case output (start amount) |
| `minimumAmountOut` | `CurrencyAmount` | Worst-case output (end amount, at deadline) |
| `maximumAmountIn` | `CurrencyAmount` | Maximum input (end amount) |
| `executionPrice` | `Price` | Price at fill time 0 |
| `worstExecutionPrice` | `Price` | Price at deadline |
| `priceImpact` | `null` | Always null for EDO trades |
| `orderInfo` | `ExclusiveDutchOrderInfo` | Order parameters |
| `encodedOrder` | `Hex` | ABI-encoded order ready for on-chain submission |
| `permitData` | `PermitWitnessTransferFromData` | EIP-712 typed data for Permit2 signing |
| `quoteQueryHash` | `string \| undefined` | Quote identifier from the API |

## ExclusiveDutchOrder

Low-level class for constructing and encoding the raw UniswapX `ExclusiveDutchOrder` struct.

| Method | Signature | Description |
| --- | --- | --- |
| `ExclusiveDutchOrder.parse` | `(encoded: string, chainId: ChainId) → ExclusiveDutchOrder` | Decode an ABI-encoded order |
| `serialize` | `() → string` | ABI-encode the order |
| `hash` | `() → string` | Compute the order hash |
| `resolve` | `(at: { timestamp: number }) → ResolvedOrder` | Resolve the Dutch auction output at a given timestamp |

## Constants

| Export | Type | Description |
| --- | --- | --- |
| `REACTOR_ADDRESS_MAPPING` | `Record<ChainId, string>` | Dutch order reactor addresses per chain |

## PCSX contract addresses

See [PancakeSwap X addresses](/contracts/pcsx/addresses) for deployed reactor addresses.
