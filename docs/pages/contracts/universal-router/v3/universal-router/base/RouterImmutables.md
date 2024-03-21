# Solidity API

## RouterParameters

```solidity
struct RouterParameters {
  address permit2;
  address weth9;
  address seaportV1_5;
  address seaportV1_4;
  address openseaConduit;
  address x2y2;
  address looksRareV2;
  address routerRewardsDistributor;
  address looksRareRewardsDistributor;
  address looksRareToken;
  address v2Factory;
  address v3Factory;
  address v3Deployer;
  bytes32 v2InitCodeHash;
  bytes32 v3InitCodeHash;
  address stableFactory;
  address stableInfo;
  address pancakeNFTMarket;
}
```

## RouterImmutables

Used along with the `RouterParameters` struct for ease of cross-chain deployment

### WETH9

```solidity
contract IWETH9 WETH9
```

_WETH9 address_

### PERMIT2

```solidity
contract IAllowanceTransfer PERMIT2
```

_Permit2 address_

### SEAPORT_V1_5

```solidity
address SEAPORT_V1_5
```

_Seaport 1.5 address_

### SEAPORT_V1_4

```solidity
address SEAPORT_V1_4
```

_Seaport 1.4 address_

### OPENSEA_CONDUIT

```solidity
address OPENSEA_CONDUIT
```

_The address of OpenSea's conduit used in both Seaport 1.4 and Seaport 1.5_

### X2Y2

```solidity
address X2Y2
```

_The address of X2Y2_

### LOOKS_RARE_V2

```solidity
address LOOKS_RARE_V2
```

_The address of LooksRareV2_

### LOOKS_RARE_TOKEN

```solidity
contract ERC20 LOOKS_RARE_TOKEN
```

_The address of LooksRare token_

### LOOKS_RARE_REWARDS_DISTRIBUTOR

```solidity
address LOOKS_RARE_REWARDS_DISTRIBUTOR
```

_The address of LooksRare rewards distributor_

### ROUTER_REWARDS_DISTRIBUTOR

```solidity
address ROUTER_REWARDS_DISTRIBUTOR
```

_The address of router rewards distributor_

### PANCAKESWAP_V2_FACTORY

```solidity
address PANCAKESWAP_V2_FACTORY
```

_The address of PancakeSwapV2Factory_

### PANCAKESWAP_V2_PAIR_INIT_CODE_HASH

```solidity
bytes32 PANCAKESWAP_V2_PAIR_INIT_CODE_HASH
```

_The PancakeSwapV2Pair initcodehash_

### PANCAKESWAP_V3_FACTORY

```solidity
address PANCAKESWAP_V3_FACTORY
```

_The address of PancakeSwapV3Factory_

### PANCAKESWAP_V3_POOL_INIT_CODE_HASH

```solidity
bytes32 PANCAKESWAP_V3_POOL_INIT_CODE_HASH
```

_The PancakeSwapV3Pool initcodehash_

### PANCAKESWAP_V3_DEPLOYER

```solidity
address PANCAKESWAP_V3_DEPLOYER
```

_The address of PancakeSwap V3 Deployer_

### PANCAKESWAP_NFT_MARKET

```solidity
address PANCAKESWAP_NFT_MARKET
```

_The address of PancakeSwap NFT Market_

### Spenders

```solidity
enum Spenders {
  OSConduit
}
```

### constructor

```solidity
constructor(struct RouterParameters params) public
```

