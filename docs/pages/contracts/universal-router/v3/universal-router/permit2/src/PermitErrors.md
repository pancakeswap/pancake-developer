# Solidity API

## SignatureExpired

```solidity
error SignatureExpired(uint256 signatureDeadline)
```

Thrown when validating an inputted signature that is stale

### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| signatureDeadline | uint256 | The timestamp at which a signature is no longer valid |

## InvalidNonce

```solidity
error InvalidNonce()
```

Thrown when validating that the inputted nonce has not been used

