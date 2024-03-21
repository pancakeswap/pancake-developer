# Solidity API

## Permit2Payments

Performs interactions with Permit2 to transfer tokens

### FromAddressIsNotOwner

```solidity
error FromAddressIsNotOwner()
```

### permit2TransferFrom

```solidity
function permit2TransferFrom(address token, address from, address to, uint160 amount) internal
```

Performs a transferFrom on Permit2

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to transfer |
| from | address | The address to transfer from |
| to | address | The recipient of the transfer |
| amount | uint160 | The amount to transfer |

### permit2TransferFrom

```solidity
function permit2TransferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[] batchDetails, address owner) internal
```

Performs a batch transferFrom on Permit2

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| batchDetails | struct IAllowanceTransfer.AllowanceTransferDetails[] | An array detailing each of the transfers that should occur |
| owner | address |  |

### payOrPermit2Transfer

```solidity
function payOrPermit2Transfer(address token, address payer, address recipient, uint256 amount) internal
```

Either performs a regular payment or transferFrom on Permit2, depending on the payer address

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to transfer |
| payer | address | The address to pay for the transfer |
| recipient | address | The recipient of the transfer |
| amount | uint256 | The amount to transfer |

