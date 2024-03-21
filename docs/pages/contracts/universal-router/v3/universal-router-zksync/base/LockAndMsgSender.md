# Solidity API

## LockAndMsgSender

### ContractLocked

```solidity
error ContractLocked()
```

### NOT_LOCKED_FLAG

```solidity
address NOT_LOCKED_FLAG
```

### lockedBy

```solidity
address lockedBy
```

### isNotLocked

```solidity
modifier isNotLocked()
```

### map

```solidity
function map(address recipient) internal view returns (address)
```

Calculates the recipient address for a command

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| recipient | address | The recipient or recipient-flag for the command |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address | output The resultant recipient for the command |

