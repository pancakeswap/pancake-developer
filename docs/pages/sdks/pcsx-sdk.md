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
  ExclusiveDutchOrderTrade,
} from '@pancakeswap/pcsx-sdk'
import { CurrencyAmount, TradeType } from '@pancakeswap/swap-sdk-core'
import { ChainId } from '@pancakeswap/chains'
import { bscTokens } from '@pancakeswap/tokens'

const trade = createExclusiveDutchOrderTrade({
  chainId: ChainId.BSC,
  currencyIn: bscTokens.cake,
  currencyOut: bscTokens.usdt,
  inputAmount: CurrencyAmount.fromRawAmount(bscTokens.cake, 10n ** 18n),
  outputStartAmount: CurrencyAmount.fromRawAmount(bscTokens.usdt, 3_900_000n), // best price
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
const { permitData } = trade.permitData()
const signature = await walletClient.signTypedData(permitData)
```

## createExclusiveDutchOrderTrade

```typescript
createExclusiveDutchOrderTrade(options: {
  chainId: ChainId
  currencyIn: Currency
  currencyOut: Currency
  inputAmount: CurrencyAmount
  outputStartAmount: CurrencyAmount   // output at time 0 (best price)
  outputEndAmount: CurrencyAmount     // output at deadline (floor price)
  tradeType: TradeType
  orderInfo: ExclusiveDutchOrderInfo
}) → ExclusiveDutchOrderTrade
```

Constructs an `ExclusiveDutchOrderTrade` ready for signing and submission.

### ExclusiveDutchOrderInfo

| Field | Type | Description |
| --- | --- | --- |
| `deadline` | `number` | Unix timestamp when the order expires |
| `exclusiveFiller` | `string` | Address of the exclusive filler; use `address(0)` for open fill |
| `exclusivityOverrideBps` | `bigint` | Bps premium allowed for non-exclusive fillers during the exclusivity window |
| `nonce` | `bigint` | Unique nonce for Permit2 |

## ExclusiveDutchOrderTrade

Encapsulates an EDO trade with encoding and signing helpers.

### Properties

| Property | Type | Description |
| --- | --- | --- |
| `chainId` | `ChainId` | Target chain |
| `currencyIn` | `Currency` | Input currency |
| `currencyOut` | `Currency` | Output currency |
| `inputAmount` | `CurrencyAmount` | Input amount |
| `outputStartAmount` | `CurrencyAmount` | Best-case output (at fill time 0) |
| `outputEndAmount` | `CurrencyAmount` | Worst-case output (at deadline) |
| `tradeType` | `TradeType` | EXACT_INPUT or EXACT_OUTPUT |
| `orderInfo` | `ExclusiveDutchOrderInfo` | Order parameters |

### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `permitData` | `() → { permitData: TypedData, permit2Address: string }` | Return EIP-712 typed data for Permit2 signing |
| `encode` | `() → { calldata: string, value: string }` | ABI-encode the signed order for on-chain submission |

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
