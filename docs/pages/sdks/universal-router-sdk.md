---
description: Build calldata for the PancakeSwap Universal Router — multi-protocol swaps in a single transaction.
---

# @pancakeswap/universal-router-sdk

Build transaction calldata for the PancakeSwap Universal Router. Encodes multi-step swap commands across V2, V3, and Infinity pools — including Permit2 transfers — into a single contract call.

## Installation

```bash
npm install @pancakeswap/universal-router-sdk
```

## Quick start

```typescript
import { PancakeSwapUniversalRouter, getUniversalRouterAddress } from '@pancakeswap/universal-router-sdk'
import { ChainId } from '@pancakeswap/chains'
import { TradeType } from '@pancakeswap/swap-sdk-core'

// After getting a trade from SmartRouter:
const { calldata, value } = PancakeSwapUniversalRouter.swapERC20CallParameters(trade, {
  slippageTolerance: new Percent(50, 10000), // 0.5%
  recipient: '0xYOUR_ADDRESS',
  deadlineOrPreviousBlockhash: Math.floor(Date.now() / 1000) + 60 * 20,
  inputTokenPermit: permit2Signature, // optional, from @pancakeswap/permit2-sdk
})

// Router address
const routerAddress = getUniversalRouterAddress(ChainId.BSC)
```

## Key exports

| Export | Description |
| --- | --- |
| `PancakeSwapUniversalRouter` | Main class — builds encoded command batches |
| `getUniversalRouterAddress(chainId)` | Get the deployed router address for a chain |

## Universal Router addresses

See [Universal Router addresses](/contracts/universal-router/addresses) for the full list.

## Source

[github.com/pancakeswap/pancake-frontend — packages/universal-router-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/universal-router-sdk)
