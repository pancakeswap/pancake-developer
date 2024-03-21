# Solidity API

## Dispatcher

Called by the UniversalRouter contract to efficiently decode and execute a singular command

### InvalidCommandType

```solidity
error InvalidCommandType(uint256 commandType)
```

### BuyPunkFailed

```solidity
error BuyPunkFailed()
```

### BuyPancakeNFTFailed

```solidity
error BuyPancakeNFTFailed()
```

### InvalidOwnerERC721

```solidity
error InvalidOwnerERC721()
```

### InvalidOwnerERC1155

```solidity
error InvalidOwnerERC1155()
```

### BalanceTooLow

```solidity
error BalanceTooLow()
```

### dispatch

```solidity
function dispatch(bytes1 commandType, bytes inputs) internal returns (bool success, bytes output)
```

Decodes and executes the given command with the given inputs

_2 masks are used to enable use of a nested-if statement in execution for efficiency reasons_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| commandType | bytes1 | The command type to execute |
| inputs | bytes | The inputs to execute the command with |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| success | bool | True on success of the command, false on failure |
| output | bytes | The outputs or error messages, if any, from the command |

### execute

```solidity
function execute(bytes commands, bytes[] inputs) external payable virtual
```

Executes encoded commands along with provided inputs.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| commands | bytes | A set of concatenated commands, each 1 byte in length |
| inputs | bytes[] | An array of byte strings containing abi encoded inputs for each command |

### callAndTransfer721

```solidity
function callAndTransfer721(bytes inputs, address protocol) internal returns (bool success, bytes output)
```

Performs a call to purchase an ERC721, then transfers the ERC721 to a specified recipient

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| inputs | bytes | The inputs for the protocol and ERC721 transfer, encoded |
| protocol | address | The protocol to pass the calldata to |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| success | bool | True on success of the command, false on failure |
| output | bytes | The outputs or error messages, if any, from the command |

### callAndTransfer1155

```solidity
function callAndTransfer1155(bytes inputs, address protocol) internal returns (bool success, bytes output)
```

Performs a call to purchase an ERC1155, then transfers the ERC1155 to a specified recipient

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| inputs | bytes | The inputs for the protocol and ERC1155 transfer, encoded |
| protocol | address | The protocol to pass the calldata to |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| success | bool | True on success of the command, false on failure |
| output | bytes | The outputs or error messages, if any, from the command |

### getValueAndData

```solidity
function getValueAndData(bytes inputs) internal pure returns (uint256 value, bytes data)
```

Helper function to extract `value` and `data` parameters from input bytes string

_The helper assumes that `value` is the first parameter, and `data` is the second_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| inputs | bytes | The bytes string beginning with value and data parameters |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| value | uint256 | The 256 bit integer value |
| data | bytes | The data bytes string |

