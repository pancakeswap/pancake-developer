# Solidity API

## RewardsCollector

### RewardsSent

```solidity
event RewardsSent(uint256 amount)
```

### UnableToClaim

```solidity
error UnableToClaim()
```

### collectRewards

```solidity
function collectRewards(bytes looksRareClaim) external
```

Fetches users' LooksRare rewards and sends them to the distributor contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| looksRareClaim | bytes | The data required by LooksRare to claim reward tokens |

