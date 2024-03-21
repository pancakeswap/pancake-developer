# Solidity API

## V3SwapRouter

### V3InvalidSwap

```solidity
error V3InvalidSwap()
```

### V3TooLittleReceived

```solidity
error V3TooLittleReceived()
```

### V3TooMuchRequested

```solidity
error V3TooMuchRequested()
```

### V3InvalidAmountOut

```solidity
error V3InvalidAmountOut()
```

### V3InvalidCaller

```solidity
error V3InvalidCaller()
```

### MIN_SQRT_RATIO

```solidity
uint160 MIN_SQRT_RATIO
```

_The minimum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MIN_TICK)_

### MAX_SQRT_RATIO

```solidity
uint160 MAX_SQRT_RATIO
```

_The maximum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MAX_TICK)_

### pancakeV3SwapCallback

```solidity
function pancakeV3SwapCallback(int256 amount0Delta, int256 amount1Delta, bytes data) external
```

Called to `msg.sender` after executing a swap via IPancakeV3Pool#swap.

_In the implementation you must pay the pool tokens owed for the swap.
The caller of this method must be checked to be a PancakeV3Pool deployed by the canonical PancakeV3Factory.
amount0Delta and amount1Delta can both be 0 if no tokens were swapped._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount0Delta | int256 | The amount of token0 that was sent (negative) or must be received (positive) by the pool by the end of the swap. If positive, the callback must send that amount of token0 to the pool. |
| amount1Delta | int256 | The amount of token1 that was sent (negative) or must be received (positive) by the pool by the end of the swap. If positive, the callback must send that amount of token1 to the pool. |
| data | bytes | Any data passed through by the caller via the IPancakeV3PoolActions#swap call |

### v3SwapExactInput

```solidity
function v3SwapExactInput(address recipient, uint256 amountIn, uint256 amountOutMinimum, bytes path, address payer) internal
```

Performs a PancakeSwap v3 exact input swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountIn | uint256 | The amount of input tokens for the trade |
| amountOutMinimum | uint256 | The minimum desired amount of output tokens |
| path | bytes | The path of the trade as a bytes string |
| payer | address | The address that will be paying the input |

### v3SwapExactOutput

```solidity
function v3SwapExactOutput(address recipient, uint256 amountOut, uint256 amountInMaximum, bytes path, address payer) internal
```

Performs a PancakeSwap v3 exact output swap

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the output tokens |
| amountOut | uint256 | The amount of output tokens to receive for the trade |
| amountInMaximum | uint256 | The maximum desired amount of input tokens |
| path | bytes | The path of the trade as a bytes string |
| payer | address | The address that will be paying the input |

