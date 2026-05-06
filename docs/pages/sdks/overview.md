---
description: TypeScript/JavaScript SDKs for building on PancakeSwap — routing, pool interactions, price data, and more.
---

# SDKs

PancakeSwap publishes a set of TypeScript packages under `@pancakeswap/*` for integrators who want to interact with the protocol programmatically.

## Packages

| Package | Version | Description |
| --- | --- | --- |
| [`@pancakeswap/smart-router`](/sdks/smart-router) | 7.6.0 | Best-route finder across V2, V3, and Infinity pools |
| [`@pancakeswap/v3-sdk`](/sdks/v3-sdk) | 3.10.0 | Concentrated liquidity pool math and position management |
| [`@pancakeswap/v2-sdk`](/sdks/v2-sdk) | 1.2.0 | V2 AMM pairs, trades, and routing |
| [`@pancakeswap/infinity-sdk`](/sdks/infinity-sdk) | 1.0.8 | Infinity pool interactions (CL + Bin) |
| [`@pancakeswap/swap-sdk-core`](/sdks/swap-sdk-core) | 1.6.0 | Core primitives — Token, CurrencyAmount, Fraction, Price |
| [`@pancakeswap/chains`](/sdks/chains) | 0.8.0 | Chain IDs, names, and network configuration |
| [`@pancakeswap/tokens`](/sdks/tokens) | 0.8.0 | Pre-configured token objects for all supported chains |
| [`@pancakeswap/universal-router-sdk`](/sdks/universal-router-sdk) | 1.5.0 | Build calldata for the Universal Router |
| [`@pancakeswap/permit2-sdk`](/sdks/permit2-sdk) | 1.2.0 | Permit2 allowance and signature-transfer helpers |
| [`@pancakeswap/price-api-sdk`](/sdks/price-api-sdk) | 12.0.0 | Fetch token prices from the PancakeSwap price API |
| [`@pancakeswap/pcsx-sdk`](/sdks/pcsx-sdk) | 1.1.0 | Exclusive Dutch order (PancakeSwap X) trades |

## Typical integration stack

Most integrations that execute swaps use these packages together:

```
@pancakeswap/chains          — pick chain ID
@pancakeswap/tokens          — get token objects
@pancakeswap/swap-sdk-core   — build CurrencyAmount inputs
@pancakeswap/smart-router    — find best route + build calldata
```

For low-level pool math or position management, add `@pancakeswap/v3-sdk` or `@pancakeswap/infinity-sdk`.

