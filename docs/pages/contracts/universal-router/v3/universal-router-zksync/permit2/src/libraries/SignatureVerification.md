# Solidity API

## SignatureVerification

### InvalidSignatureLength

```solidity
error InvalidSignatureLength()
```

Thrown when the passed in signature is not a valid length

### InvalidSignature

```solidity
error InvalidSignature()
```

Thrown when the recovered signer is equal to the zero address

### InvalidSigner

```solidity
error InvalidSigner()
```

Thrown when the recovered signer does not equal the claimedSigner

### InvalidContractSignature

```solidity
error InvalidContractSignature()
```

Thrown when the recovered contract signature is incorrect

### UPPER_BIT_MASK

```solidity
bytes32 UPPER_BIT_MASK
```

### verify

```solidity
function verify(bytes signature, bytes32 hash, address claimedSigner) internal view
```

