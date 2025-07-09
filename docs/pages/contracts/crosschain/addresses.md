---
description: Crosschain swap
---

# Crosschain

**Crosschain** connects with universal router and various bridges to enable users to swap assets across different chains. Currently, it supports the following bridge providers and will continue to expand this list.

- [Across](https://across.to/)

## XChainSender Addresses

**XChainSender** works with the universal router to handle pre-bridge swaps and transmit the intended bridge tokens to the bridge adapters. The sender also integrates with Permit2.

**Mainnet**

| Chain    | Address                                    |
| -------- | ------------------------------------------ |
| BSC      | 0xE82e2D3B9DB59f7c7b438239D92E2190a64E26ce |
| Arbitrum | 0xE82e2D3B9DB59f7c7b438239D92E2190a64E26ce |
| Base     | 0xE82e2D3B9DB59f7c7b438239D92E2190a64E26ce |
| ETH      | 0xE82e2D3B9DB59f7c7b438239D92E2190a64E26ce |
| zkSync   | 0xdE167bB9F640a3D6de7b8C16C28920755f5921F2 |
| Linea    | 0xdE167bB9F640a3D6de7b8C16C28920755f5921F2 |

## BridgeAdaptor Addresses

**BridgeAdaptor** manages the transmission of tokens to the bridge provider on the source chain and the reception of tokens on the destination chain. Additionally, it oversees the post-bridge swap logic on the destination chain if applicable.

### Across Adaptor

**Mainnet**

| Chain    | Address                                    |
| -------- | ------------------------------------------ |
| BSC      | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| Arbitrum | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| Base     | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| ETH      | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| zkSync   | 0xb456E051867625D320A7a793897058eb7eB6093B |
| Linea    | 0xb456E051867625D320A7a793897058eb7eB6093B |

## Audits

- [Pashov](https://developer.pancakeswap.finance/crosschain/pashov-audit.pdf)
- [BurraSec](https://developer.pancakeswap.finance/crosschain/burrasec-audit.pdf)
