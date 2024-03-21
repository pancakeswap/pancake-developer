# Solidity API

## StableSwapRouter

### StableTooLittleReceived

```solidity
error StableTooLittleReceived()
```

### StableTooMuchRequested

```solidity
error StableTooMuchRequested()
```

### StableInvalidPath

```solidity
error StableInvalidPath()
```

### stableSwapFactory

```solidity
address stableSwapFactory
```

### stableSwapInfo

```solidity
address stableSwapInfo
```

### SetStableSwap

```solidity
event SetStableSwap(address factory, address info)
```

### constructor

```solidity
constructor(address _stableSwapFactory, address _stableSwapInfo) internal
```

### setStableSwap

```solidity
function setStableSwap(address _factory, address _info) external
```

Set Pancake Stable Swap Factory and Info

_Only callable by contract owner_

### stableSwapExactInput

```solidity
function stableSwapExactInput(address recipient, uint256 amountIn, uint256 amountOutMinimum, address[] path, uint256[] flag, address payer) internal
```

Performs a PancakeSwap stable exact input swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountIn | uint256 | The amount of input tokens for the trade |
| amountOutMinimum | uint256 | The minimum desired amount of output tokens |
| path | address[] | The path of the trade as an array of token addresses |
| flag | uint256[] | token amount in a stable swap pool. 2 for 2pool, 3 for 3pool |
| payer | address | The address that will be paying the input |

### stableSwapExactOutput

```solidity
function stableSwapExactOutput(address recipient, uint256 amountOut, uint256 amountInMaximum, address[] path, uint256[] flag, address payer) internal
```

Performs a PancakeSwap stable exact output swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountOut | uint256 | The amount of output tokens to receive for the trade |
| amountInMaximum | uint256 | The maximum desired amount of input tokens |
| path | address[] | The path of the trade as an array of token addresses |
| flag | uint256[] | token amount in a stable swap pool. 2 for 2pool, 3 for 3pool |
| payer | address | The address that will be paying the input |

