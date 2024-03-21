# Solidity API

## IRewardsCollector

Implements a permissionless call to fetch LooksRare rewards earned by Universal Router users
and transfers them to an external rewards distributor contract

### collectRewards

```solidity
function collectRewards(bytes looksRareClaim) external
```

Fetches users' LooksRare rewards and sends them to the distributor contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| looksRareClaim | bytes | The data required by LooksRare to claim reward tokens |

