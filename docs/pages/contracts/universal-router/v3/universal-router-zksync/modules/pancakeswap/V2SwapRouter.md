# Solidity API

## V2SwapRouter

### V2TooLittleReceived

```solidity
error V2TooLittleReceived()
```

### V2TooMuchRequested

```solidity
error V2TooMuchRequested()
```

### V2InvalidPath

```solidity
error V2InvalidPath()
```

### v2SwapExactInput

```solidity
function v2SwapExactInput(address recipient, uint256 amountIn, uint256 amountOutMinimum, address[] path, address payer) internal
```

Performs a PancakeSwap v2 exact input swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountIn | uint256 | The amount of input tokens for the trade |
| amountOutMinimum | uint256 | The minimum desired amount of output tokens |
| path | address[] | The path of the trade as an array of token addresses |
| payer | address | The address that will be paying the input |

### v2SwapExactOutput

```solidity
function v2SwapExactOutput(address recipient, uint256 amountOut, uint256 amountInMaximum, address[] path, address payer) internal
```

Performs a PancakeSwap v2 exact output swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountOut | uint256 | The amount of output tokens to receive for the trade |
| amountInMaximum | uint256 | The maximum desired amount of input tokens |
| path | address[] | The path of the trade as an array of token addresses |
| payer | address | The address that will be paying the input |

