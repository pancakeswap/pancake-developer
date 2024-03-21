# Solidity API

## Payments

Performs various operations around the payment of ETH and tokens

### InsufficientToken

```solidity
error InsufficientToken()
```

### InsufficientETH

```solidity
error InsufficientETH()
```

### InvalidBips

```solidity
error InvalidBips()
```

### InvalidSpender

```solidity
error InvalidSpender()
```

### FEE_BIPS_BASE

```solidity
uint256 FEE_BIPS_BASE
```

### pay

```solidity
function pay(address token, address recipient, uint256 value) internal
```

Pays an amount of ETH or ERC20 to a recipient

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to pay (can be ETH using Constants.ETH) |
| recipient | address | The address that will receive the payment |
| value | uint256 | The amount to pay |

### approveERC20

```solidity
function approveERC20(contract ERC20 token, enum RouterImmutables.Spenders spender) internal
```

Approves a protocol to spend ERC20s in the router

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | contract ERC20 | The token to approve |
| spender | enum RouterImmutables.Spenders | Which protocol to approve |

### payPortion

```solidity
function payPortion(address token, address recipient, uint256 bips) internal
```

Pays a proportion of the contract's ETH or ERC20 to a recipient

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to pay (can be ETH using Constants.ETH) |
| recipient | address | The address that will receive payment |
| bips | uint256 | Portion in bips of whole balance of the contract |

### sweep

```solidity
function sweep(address token, address recipient, uint256 amountMinimum) internal
```

Sweeps all of the contract's ERC20 or ETH to an address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to sweep (can be ETH using Constants.ETH) |
| recipient | address | The address that will receive payment |
| amountMinimum | uint256 | The minimum desired amount |

### sweepERC721

```solidity
function sweepERC721(address token, address recipient, uint256 id) internal
```

Sweeps an ERC721 to a recipient from the contract

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The ERC721 token to sweep |
| recipient | address | The address that will receive payment |
| id | uint256 | The ID of the ERC721 to sweep |

### sweepERC1155

```solidity
function sweepERC1155(address token, address recipient, uint256 id, uint256 amountMinimum) internal
```

Sweeps all of the contract's ERC1155 to an address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The ERC1155 token to sweep |
| recipient | address | The address that will receive payment |
| id | uint256 | The ID of the ERC1155 to sweep |
| amountMinimum | uint256 | The minimum desired amount |

### wrapETH

```solidity
function wrapETH(address recipient, uint256 amount) internal
```

Wraps an amount of ETH into WETH

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the WETH |
| amount | uint256 | The amount to wrap (can be CONTRACT_BALANCE) |

### unwrapWETH9

```solidity
function unwrapWETH9(address recipient, uint256 amountMinimum) internal
```

Unwraps all of the contract's WETH into ETH

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient of the ETH |
| amountMinimum | uint256 | The minimum amount of ETH desired |

