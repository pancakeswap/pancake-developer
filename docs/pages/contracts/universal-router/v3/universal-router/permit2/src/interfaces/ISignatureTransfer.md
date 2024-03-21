# Solidity API

## ISignatureTransfer

Handles ERC20 token transfers through signature based actions

_Requires user's token approval on the Permit2 contract_

### InvalidAmount

```solidity
error InvalidAmount(uint256 maxAmount)
```

Thrown when the requested amount for a transfer is larger than the permissioned amount

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| maxAmount | uint256 | The maximum amount a spender can request to transfer |

### LengthMismatch

```solidity
error LengthMismatch()
```

Thrown when the number of tokens permissioned to a spender does not match the number of tokens being transferred

_If the spender does not need to transfer the number of tokens permitted, the spender can request amount 0 to be transferred_

### UnorderedNonceInvalidation

```solidity
event UnorderedNonceInvalidation(address owner, uint256 word, uint256 mask)
```

Emits an event when the owner successfully invalidates an unordered nonce.

### TokenPermissions

```solidity
struct TokenPermissions {
  address token;
  uint256 amount;
}
```

### PermitTransferFrom

```solidity
struct PermitTransferFrom {
  struct ISignatureTransfer.TokenPermissions permitted;
  uint256 nonce;
  uint256 deadline;
}
```

### SignatureTransferDetails

```solidity
struct SignatureTransferDetails {
  address to;
  uint256 requestedAmount;
}
```

### PermitBatchTransferFrom

```solidity
struct PermitBatchTransferFrom {
  struct ISignatureTransfer.TokenPermissions[] permitted;
  uint256 nonce;
  uint256 deadline;
}
```

### nonceBitmap

```solidity
function nonceBitmap(address, uint256) external view returns (uint256)
```

A map from token owner address and a caller specified word index to a bitmap. Used to set bits in the bitmap to prevent against signature replay protection

_Uses unordered nonces so that permit messages do not need to be spent in a certain order
The mapping is indexed first by the token owner, then by an index specified in the nonce
It returns a uint256 bitmap
The index, or wordPosition is capped at type(uint248).max_

### permitTransferFrom

```solidity
function permitTransferFrom(struct ISignatureTransfer.PermitTransferFrom permit, struct ISignatureTransfer.SignatureTransferDetails transferDetails, address owner, bytes signature) external
```

Transfers a token using a signed permit message

_Reverts if the requested amount is greater than the permitted signed amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| permit | struct ISignatureTransfer.PermitTransferFrom | The permit data signed over by the owner |
| transferDetails | struct ISignatureTransfer.SignatureTransferDetails | The spender's requested transfer details for the permitted token |
| owner | address | The owner of the tokens to transfer |
| signature | bytes | The signature to verify |

### permitWitnessTransferFrom

```solidity
function permitWitnessTransferFrom(struct ISignatureTransfer.PermitTransferFrom permit, struct ISignatureTransfer.SignatureTransferDetails transferDetails, address owner, bytes32 witness, string witnessTypeString, bytes signature) external
```

Transfers a token using a signed permit message
Includes extra data provided by the caller to verify signature over

_The witness type string must follow EIP712 ordering of nested structs and must include the TokenPermissions type definition
Reverts if the requested amount is greater than the permitted signed amount_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| permit | struct ISignatureTransfer.PermitTransferFrom | The permit data signed over by the owner |
| transferDetails | struct ISignatureTransfer.SignatureTransferDetails | The spender's requested transfer details for the permitted token |
| owner | address | The owner of the tokens to transfer |
| witness | bytes32 | Extra data to include when checking the user signature |
| witnessTypeString | string | The EIP-712 type definition for remaining string stub of the typehash |
| signature | bytes | The signature to verify |

### permitTransferFrom

```solidity
function permitTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom permit, struct ISignatureTransfer.SignatureTransferDetails[] transferDetails, address owner, bytes signature) external
```

Transfers multiple tokens using a signed permit message

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| permit | struct ISignatureTransfer.PermitBatchTransferFrom | The permit data signed over by the owner |
| transferDetails | struct ISignatureTransfer.SignatureTransferDetails[] | Specifies the recipient and requested amount for the token transfer |
| owner | address | The owner of the tokens to transfer |
| signature | bytes | The signature to verify |

### permitWitnessTransferFrom

```solidity
function permitWitnessTransferFrom(struct ISignatureTransfer.PermitBatchTransferFrom permit, struct ISignatureTransfer.SignatureTransferDetails[] transferDetails, address owner, bytes32 witness, string witnessTypeString, bytes signature) external
```

Transfers multiple tokens using a signed permit message
Includes extra data provided by the caller to verify signature over

_The witness type string must follow EIP712 ordering of nested structs and must include the TokenPermissions type definition_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| permit | struct ISignatureTransfer.PermitBatchTransferFrom | The permit data signed over by the owner |
| transferDetails | struct ISignatureTransfer.SignatureTransferDetails[] | Specifies the recipient and requested amount for the token transfer |
| owner | address | The owner of the tokens to transfer |
| witness | bytes32 | Extra data to include when checking the user signature |
| witnessTypeString | string | The EIP-712 type definition for remaining string stub of the typehash |
| signature | bytes | The signature to verify |

### invalidateUnorderedNonces

```solidity
function invalidateUnorderedNonces(uint256 wordPos, uint256 mask) external
```

Invalidates the bits specified in mask for the bitmap at the word position

_The wordPos is maxed at type(uint248).max_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| wordPos | uint256 | A number to index the nonceBitmap at |
| mask | uint256 | A bitmap masked against msg.sender's current bitmap at the word position |

