---
description: Build calldata for the PancakeSwap Universal Router — multi-protocol swaps in a single transaction.
---

# Universal Router SDK

Build transaction calldata for the PancakeSwap Universal Router. Encodes multi-step swap commands across V2, V3, and Infinity pools — including Permit2 transfers — into a single contract call.

## Installation

```bash
npm install @pancakeswap/universal-router-sdk
```

## Quick start

```typescript
import { PancakeSwapUniversalRouter, getUniversalRouterAddress, UniversalRouterVersion } from '@pancakeswap/universal-router-sdk'
import { ChainId } from '@pancakeswap/chains'
import { Percent } from '@pancakeswap/swap-sdk-core'

// After getting a trade from SmartRouter:
const { calldata, value } = PancakeSwapUniversalRouter.swapERC20CallParameters(trade, {
  slippageTolerance: new Percent(50, 10000), // 0.5%
  recipient: '0xYOUR_ADDRESS',
  deadlineOrPreviousBlockhash: Math.floor(Date.now() / 1000) + 60 * 20,
  inputTokenPermit: permit2Signature, // optional — from @pancakeswap/permit2-sdk
})

const routerAddress = getUniversalRouterAddress(ChainId.BSC)
```

## PancakeSwapUniversalRouter

Main class for encoding Universal Router command batches.

| Method | Signature | Description |
| --- | --- | --- |
| `swapERC20CallParameters` | `(trades, options) → { calldata: Hex, value: string }` | Build calldata for one or more ERC-20 swaps via the Universal Router |
| `swapNativeCurrencyCallParameters` | `(trades, options) → { calldata: Hex, value: string }` | Build calldata for swaps where the input is native currency (ETH/BNB) |

### swapERC20CallParameters options

| Option | Type | Description |
| --- | --- | --- |
| `slippageTolerance` | `Percent` | Maximum acceptable slippage |
| `recipient` | `string` | Address to receive output tokens |
| `deadlineOrPreviousBlockhash` | `number \| string` | Deadline (timestamp) or previous blockhash for flash-bot protection |
| `inputTokenPermit` | `object \| undefined` | Permit2 signature for the input token; skips a separate approval tx |
| `fee` | `{ feeOptions }` | Optional protocol fee configuration |

### inputTokenPermit shape

```typescript
// For AllowanceTransfer (EIP-712 signature)
{
  v: number
  r: string
  s: string
  amount: bigint
  expiration: number
  nonce: number
  spender: string
  sigDeadline: bigint
}
```

## Functions

| Function | Signature | Description |
| --- | --- | --- |
| `getUniversalRouterAddress` | `(chainId: ChainId, version?: UniversalRouterVersion) → string` | Get the deployed Universal Router address for a chain |

## Constants

| Export | Description |
| --- | --- |
| `UNIVERSAL_ROUTER_ADDRESS` | `Record<ChainId, string>` — addresses for the default router version |
| `UniversalRouterVersion` | Enum of deployed router versions (`V1`, `V2`) |

## Universal Router addresses

See [Universal Router addresses](/contracts/universal-router/addresses) for the full list.
