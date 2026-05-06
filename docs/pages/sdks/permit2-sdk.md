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

## AllowanceTransfer

Helpers for the approve-once-spend-many allowance model.

| Method | Signature | Description |
| --- | --- | --- |
| `getPermitData` | `(permit, permit2Address, chainId) → { domain, types, values }` | Build EIP-712 typed data for a `PermitSingle` or `PermitBatch` |
| `hash` | `(permit, permit2Address, chainId) → string` | Compute the EIP-712 hash of a permit |
| `encodePermit` | `(permit, signature) → string` | ABI-encode a permit + signature for on-chain submission |
| `encodeApprove` | `(token, newAmount, newExpiration?) → string` | Encode a direct on-chain approval call |
| `encodeLockdown` | `(approvals: TokenSpenderPair[]) → string` | Encode a lockdown (revoke) call for one or more (token, spender) pairs |
| `encodeInvalidateNonces` | `(token, spender, newNonce) → string` | Encode a nonce invalidation call |

### PermitSingle structure

```typescript
interface PermitSingle {
  details: {
    token: string      // ERC-20 token address
    amount: bigint     // max uint160 for unlimited
    expiration: number // unix timestamp; max uint48 for non-expiring
    nonce: number      // current nonce from the contract
  }
  spender: string      // address allowed to spend
  sigDeadline: number  // signature validity deadline (unix timestamp)
}
```

### PermitBatch structure

```typescript
interface PermitBatch {
  details: PermitDetails[]  // array of token/amount/expiration/nonce
  spender: string
  sigDeadline: number
}
```

## SignatureTransfer

Helpers for single-use, off-chain signed transfers.

| Method | Signature | Description |
| --- | --- | --- |
| `getPermitData` | `(permit, permit2Address, chainId) → { domain, types, values }` | Build EIP-712 typed data for a `PermitTransferFrom` or `PermitBatchTransferFrom` |
| `hash` | `(permit, permit2Address, chainId) → string` | Compute the EIP-712 hash |
| `encodePermitTransferFrom` | `(permit, transferDetails, owner, signature) → string` | Encode a single-token transfer call |
| `encodePermitBatchTransferFrom` | `(permit, transferDetails, owner, signature) → string` | Encode a multi-token transfer call |

### PermitTransferFrom structure

```typescript
interface PermitTransferFrom {
  permitted: {
    token: string    // token address
    amount: bigint   // max amount the spender may transfer
  }
  spender: string    // who may execute the transfer
  nonce: bigint      // unique value (not incremental; any unused bigint)
  deadline: bigint   // unix timestamp; signature expires after this
}
```

## Constants

| Export | Type | Description |
| --- | --- | --- |
| `PERMIT2_ADDRESS` | `string` | Canonical Permit2 contract address (same across all chains) |
| `MaxAllowanceExpiration` | `number` | Max uint48 — use for non-expiring allowances |
| `MaxAllowanceTransferAmount` | `bigint` | Max uint160 — use for unlimited allowances |
| `MaxSignatureTransferAmount` | `bigint` | Max uint256 — use for unlimited signature transfers |
| `InstantExpiration` | `number` | 0 — use to revoke an allowance immediately |

## Permit2 contract

See [Permit2 addresses](/contracts/permit2/addresses) for deployed addresses across chains.
