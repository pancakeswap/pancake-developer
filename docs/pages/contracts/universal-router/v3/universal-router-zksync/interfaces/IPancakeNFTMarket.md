# Solidity API

## IPancakeNFTMarket

### buyTokenUsingBNB

```solidity
function buyTokenUsingBNB(address _collection, uint256 _tokenId) external payable
```

Buy token with BNB by matching the price of an existing ask order

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _collection | address |  |
| _tokenId | uint256 |  |

### buyTokenUsingWBNB

```solidity
function buyTokenUsingWBNB(address _collection, uint256 _tokenId, uint256 _price) external
```

Buy token with WBNB by matching the price of an existing ask order

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _collection | address |  |
| _tokenId | uint256 |  |
| _price | uint256 |  |

