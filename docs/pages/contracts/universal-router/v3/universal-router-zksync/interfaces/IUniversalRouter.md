# Solidity API

## IUniversalRouter

### ExecutionFailed

```solidity
error ExecutionFailed(uint256 commandIndex, bytes message)
```

Thrown when a required command has failed

### ETHNotAccepted

```solidity
error ETHNotAccepted()
```

Thrown when attempting to send ETH directly to the contract

### TransactionDeadlinePassed

```solidity
error TransactionDeadlinePassed()
```

Thrown when executing commands with an expired deadline

### LengthMismatch

```solidity
error LengthMismatch()
```

Thrown when attempting to execute commands and an incorrect number of inputs are provided

### execute

```solidity
function execute(bytes commands, bytes[] inputs, uint256 deadline) external payable
```

Executes encoded commands along with provided inputs. Reverts if deadline has expired.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| commands | bytes | A set of concatenated commands, each 1 byte in length |
| inputs | bytes[] | An array of byte strings containing abi encoded inputs for each command |
| deadline | uint256 | The deadline by which the transaction must be executed |

