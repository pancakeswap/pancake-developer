---
description: Chain IDs, names, and network constants for all PancakeSwap supported chains.
---

# Chains

Single source of truth for PancakeSwap chain identifiers and network metadata. All other PancakeSwap packages import chain IDs from here.

## Installation

```bash
npm install @pancakeswap/chains
```

## Quick start

```typescript
import { ChainId, chainNames, testnetChainIds } from '@pancakeswap/chains'

// Use chain IDs
const bscId = ChainId.BSC             // 56
const ethId = ChainId.ETHEREUM        // 1
const arbId = ChainId.ARBITRUM_ONE    // 42161

// Human-readable name
console.log(chainNames[ChainId.BASE]) // "base"

// Check for testnet
if (testnetChainIds.includes(chainId)) {
  console.warn('Connected to a testnet')
}
```

## Supported chains

### Active mainnets (`ChainId`)

| Name | Value |
| --- | --- |
| `ETHEREUM` | 1 |
| `BSC` | 56 |
| `ARBITRUM_ONE` | 42161 |
| `BASE` | 8453 |
| `ZKSYNC` | 324 |
| `LINEA` | 59144 |
| `OPBNB` | 204 |
| `MONAD_MAINNET` | 143 |

### Non-EVM chains (`NonEVMChainId`)

| Name | Value |
| --- | --- |
| `SOLANA` | 8000001001 |
| `APTOS` | 8000002000 |

### Sunset chains (`SunsetChainId`)

| Name | Value | Note |
| --- | --- | --- |
| `POLYGON_ZKEVM` | 1101 | Deprecated — do not use in new code |
| `POLYGON_ZKEVM_TESTNET` | 1442 | Deprecated — do not use in new code |

## Key exports

| Export | Type | Description |
| --- | --- | --- |
| `ChainId` | enum | EVM chain IDs |
| `NonEVMChainId` | enum | Non-EVM chain IDs |
| `SunsetChainId` | enum | Deprecated chain IDs |
| `chainNames` | `Record<ChainId, string>` | Lowercase chain names |
| `testnetChainIds` | `ChainId[]` | All testnet chain IDs |
| `averageChainBlockTimes` | `Record<ChainId, number>` | Block time in milliseconds |

