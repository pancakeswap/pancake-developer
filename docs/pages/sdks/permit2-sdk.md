---
description: Helpers for the Permit2 standard — allowance-based and signature-based token transfers.
---

# Permit2 SDK

Helpers for interacting with Permit2 — the canonical token approval contract used across PancakeSwap. Supports both allowance transfers (approve once, spend many times) and signature transfers (single-use, off-chain signed permits).

## Installation

```bash
npm install @pancakeswap/permit2-sdk
```

## Quick start

```typescript
import { AllowanceTransfer, SignatureTransfer, PERMIT2_ADDRESS } from '@pancakeswap/permit2-sdk'
import { ChainId } from '@pancakeswap/chains'

// --- Allowance transfer flow ---
// 1. Build permit data for signing
const permitSingle = {
  details: {
    token: '0xTOKEN_ADDRESS',
    amount: BigInt(1e18),
    expiration: Math.floor(Date.now() / 1000) + 60 * 60 * 24, // 24h
    nonce: 0,
  },
  spender: '0xROUTER_ADDRESS',
  sigDeadline: Math.floor(Date.now() / 1000) + 60 * 30,
}

const { domain, types, values } = AllowanceTransfer.getPermitData(
  permitSingle,
  PERMIT2_ADDRESS,
  ChainId.BSC,
)

// 2. Sign with wallet (EIP-712)
const signature = await walletClient.signTypedData({ domain, types, primaryType: 'PermitSingle', message: values })

// --- Signature transfer flow ---
const { domain: sDomain, types: sTypes, values: sValues } = SignatureTransfer.getPermitData(
  {
    permitted: { token: '0xTOKEN', amount: BigInt(1e18) },
    spender: '0xROUTER',
    nonce: 1n,
    deadline: BigInt(Math.floor(Date.now() / 1000) + 1800),
  },
  PERMIT2_ADDRESS,
  ChainId.BSC,
)
```

## Key exports

| Export | Description |
| --- | --- |
| `AllowanceTransfer` | Build and encode allowance-based permit data |
| `SignatureTransfer` | Build and encode signature-based permit data |
| `PERMIT2_ADDRESS` | The canonical Permit2 contract address |
| `MaxAllowanceExpiration` | Max uint48 — use for non-expiring approvals |
| `MaxAllowanceTransferAmount` | Max uint160 — use for unlimited allowance |

## Permit2 contract

See [Permit2 addresses](/contracts/permit2/addresses) for deployed addresses across chains.

## Source

[github.com/pancakeswap/pancake-frontend — packages/permit2-sdk](https://github.com/pancakeswap/pancake-frontend/tree/develop/packages/permit2-sdk)
