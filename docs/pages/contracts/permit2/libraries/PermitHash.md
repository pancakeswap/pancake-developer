# Solidity API

## PermitHash

### _PERMIT_DETAILS_TYPEHASH

```solidity
bytes32 _PERMIT_DETAILS_TYPEHASH
```

### _PERMIT_SINGLE_TYPEHASH

```solidity
bytes32 _PERMIT_SINGLE_TYPEHASH
```

### _PERMIT_BATCH_TYPEHASH

```solidity
bytes32 _PERMIT_BATCH_TYPEHASH
```

### _TOKEN_PERMISSIONS_TYPEHASH

```solidity
bytes32 _TOKEN_PERMISSIONS_TYPEHASH
```

### _PERMIT_TRANSFER_FROM_TYPEHASH

```solidity
bytes32 _PERMIT_TRANSFER_FROM_TYPEHASH
```

### _PERMIT_BATCH_TRANSFER_FROM_TYPEHASH

```solidity
bytes32 _PERMIT_BATCH_TRANSFER_FROM_TYPEHASH
```

### _TOKEN_PERMISSIONS_TYPESTRING

```solidity
string _TOKEN_PERMISSIONS_TYPESTRING
```

### _PERMIT_TRANSFER_FROM_WITNESS_TYPEHASH_STUB

```solidity
string _PERMIT_TRANSFER_FROM_WITNESS_TYPEHASH_STUB
```

### _PERMIT_BATCH_WITNESS_TRANSFER_FROM_TYPEHASH_STUB

```solidity
string _PERMIT_BATCH_WITNESS_TRANSFER_FROM_TYPEHASH_STUB
```

### hash

```solidity
function hash(struct IAllowanceTransfer.PermitSingle permitSingle) internal pure returns (bytes32)
```

### hash

```solidity
function hash(struct IAllowanceTransfer.PermitBatch permitBatch) internal pure returns (bytes32)
```

### hash

```solidity
function hash(struct ISignatureTransfer.PermitTransferFrom permit) internal view returns (bytes32)
```

### hash

```solidity
function hash(struct ISignatureTransfer.PermitBatchTransferFrom permit) internal view returns (bytes32)
```

### hashWithWitness

```solidity
function hashWithWitness(struct ISignatureTransfer.PermitTransferFrom permit, bytes32 witness, string witnessTypeString) internal view returns (bytes32)
```

### hashWithWitness

```solidity
function hashWithWitness(struct ISignatureTransfer.PermitBatchTransferFrom permit, bytes32 witness, string witnessTypeString) internal view returns (bytes32)
```

