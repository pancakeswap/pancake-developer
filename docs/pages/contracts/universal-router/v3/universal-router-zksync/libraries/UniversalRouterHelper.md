# Solidity API

## UniversalRouterHelper

### InvalidPoolAddress

```solidity
error InvalidPoolAddress()
```

### InvalidPoolLength

```solidity
error InvalidPoolLength()
```

### InvalidReserves

```solidity
error InvalidReserves()
```

### InvalidPath

```solidity
error InvalidPath()
```

### CREATE2_PREFIX

```solidity
bytes32 CREATE2_PREFIX
```

### EMPTY_CONSTRUCTOR_INPUT

```solidity
bytes32 EMPTY_CONSTRUCTOR_INPUT
```

### getStableInfo

```solidity
function getStableInfo(address stableSwapFactory, address input, address output, uint256 flag) internal view returns (uint256 i, uint256 j, address swapContract)
```

### getStableAmountsIn

```solidity
function getStableAmountsIn(address stableSwapFactory, address stableSwapInfo, address[] path, uint256[] flag, uint256 amountOut) internal view returns (uint256[] amounts)
```

### sortTokens

```solidity
function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1)
```

Sorts two tokens to return token0 and token1

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenA | address | The first token to sort |
| tokenB | address | The other token to sort |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| token0 | address | The smaller token by address value |
| token1 | address | The larger token by address value |

### pairFor

```solidity
function pairFor(address factory, bytes32 initCodeHash, address tokenA, address tokenB) internal pure returns (address pair)
```

Calculates the v2 address for a pair without making any external calls

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| factory | address | The address of the v2 factory |
| initCodeHash | bytes32 | The hash of the pair initcode |
| tokenA | address | One of the tokens in the pair |
| tokenB | address | The other token in the pair |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| pair | address | The resultant v2 pair address |

### pairAndToken0For

```solidity
function pairAndToken0For(address factory, bytes32 initCodeHash, address tokenA, address tokenB) internal pure returns (address pair, address token0)
```

Calculates the v2 address for a pair and the pair's token0

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| factory | address | The address of the v2 factory |
| initCodeHash | bytes32 | The hash of the pair initcode |
| tokenA | address | One of the tokens in the pair |
| tokenB | address | The other token in the pair |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| pair | address | The resultant v2 pair address |
| token0 | address | The token considered token0 in this pair |

### getAmountOut

```solidity
function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256 amountOut)
```

Given an input asset amount returns the maximum output amount of the other asset

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amountIn | uint256 | The token input amount |
| reserveIn | uint256 | The reserves available of the input token |
| reserveOut | uint256 | The reserves available of the output token |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| amountOut | uint256 | The output amount of the output token |

### getAmountIn

```solidity
function getAmountIn(uint256 amountOut, uint256 reserveIn, uint256 reserveOut) internal pure returns (uint256 amountIn)
```

Returns the input amount needed for a desired output amount in a single-hop trade

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amountOut | uint256 | The desired output amount |
| reserveIn | uint256 | The reserves available of the input token |
| reserveOut | uint256 | The reserves available of the output token |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| amountIn | uint256 | The input amount of the input token |

### getAmountInMultihop

```solidity
function getAmountInMultihop(address factory, bytes32 initCodeHash, uint256 amountOut, address[] path) internal view returns (uint256 amount, address pair)
```

Returns the input amount needed for a desired output amount in a multi-hop trade

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| factory | address | The address of the v2 factory |
| initCodeHash | bytes32 | The hash of the pair initcode |
| amountOut | uint256 | The desired output amount |
| path | address[] | The path of the multi-hop trade |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The input amount of the input token |
| pair | address | The first pair in the trade |

### hasMultiplePools

```solidity
function hasMultiplePools(bytes path) internal pure returns (bool)
```

Returns true iff the path contains two or more pools

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | bytes | The encoded swap path |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | True if path contains two or more pools, otherwise false |

### decodeFirstPool

```solidity
function decodeFirstPool(bytes path) internal pure returns (address, uint24, address)
```

Decodes the first pool in path

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | bytes | The bytes encoded swap path |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | tokenA The first token of the given pool |
| [1] | uint24 | fee The fee level of the pool |
| [2] | address | tokenB The second token of the given pool |

### getFirstPool

```solidity
function getFirstPool(bytes path) internal pure returns (bytes)
```

Gets the segment corresponding to the first pool in the path

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | bytes | The bytes encoded swap path |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bytes | The segment containing all data necessary to target the first pool in the path |

### decodeFirstToken

```solidity
function decodeFirstToken(bytes path) internal pure returns (address tokenA)
```

### skipToken

```solidity
function skipToken(bytes path) internal pure returns (bytes)
```

Skips a token + fee element

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| path | bytes | The swap path |

### computePoolAddress

```solidity
function computePoolAddress(address deployer, bytes32 initCodeHash, address tokenA, address tokenB, uint24 fee) internal pure returns (address pool)
```

