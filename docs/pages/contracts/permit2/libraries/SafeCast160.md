# Solidity API

## SafeCast160

### UnsafeCast

```solidity
error UnsafeCast()
```

Thrown when a valude greater than type(uint160).max is cast to uint160

### toUint160

```solidity
function toUint160(uint256 value) internal pure returns (uint160)
```

Safely casts uint256 to uint160

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The uint256 to be cast |

