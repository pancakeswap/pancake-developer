# Solidity API

## SignatureTransfer

### nonceBitmap

```solidity
mapping(address => mapping(uint256 => uint256)) nonceBitmap
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

### _useUnorderedNonce

```solidity
function _useUnorderedNonce(address from, uint256 nonce) internal
```

Checks whether a nonce is taken and sets the bit at the bit position in the bitmap at the word position

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address to use the nonce at |
| nonce | uint256 | The nonce to spend |

