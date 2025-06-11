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

## BridgeAdaptor Addresses

**BridgeAdaptor** manages the transmission of tokens to the bridge provider on the source chain and the reception of tokens on the destination chain. Additionally, it oversees the post-bridge swap logic on the destination chain if applicable.

### Across Adaptor

**Mainnet**

| Chain    | Address                                    |
| -------- | ------------------------------------------ |
| BSC      | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| Arbitrum      | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |
| Base      | 0x60Ac95eC1153aA8199751917edE25D0Ca49a36e2 |

## Audits

- [Pashov](https://developer.pancakeswap.finance/crosschain/pashov-audit.pdf)
- [BurraSec](https://developer.pancakeswap.finance/crosschain/burrasec-audit.pdf)
