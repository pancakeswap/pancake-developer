# Solidity API

## UniversalRouter

### checkDeadline

```solidity
modifier checkDeadline(uint256 deadline)
```

### constructor

```solidity
constructor(struct RouterParameters params) public
```

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

### execute

```solidity
function execute(bytes commands, bytes[] inputs) public payable
```

Executes encoded commands along with provided inputs.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| commands | bytes | A set of concatenated commands, each 1 byte in length |
| inputs | bytes[] | An array of byte strings containing abi encoded inputs for each command |

### successRequired

```solidity
function successRequired(bytes1 command) internal pure returns (bool)
```

### pause

```solidity
function pause() external
```

_called by the owner to pause, triggers stopped state_

### unpause

```solidity
function unpause() external
```

_called by the owner to unpause, returns to normal state_

### receive

```solidity
receive() external payable
```

To receive ETH from WETH and NFT protocols

