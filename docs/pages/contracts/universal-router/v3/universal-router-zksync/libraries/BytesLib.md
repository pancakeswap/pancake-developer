# Solidity API

## BytesLib

### SliceOutOfBounds

```solidity
error SliceOutOfBounds()
```

### toAddress

```solidity
function toAddress(bytes _bytes) internal pure returns (address _address)
```

Returns the address starting at byte 0

_length and overflow checks must be carried out before calling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to slice |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| _address | address | The address starting at byte 0 |

### toPool

```solidity
function toPool(bytes _bytes) internal pure returns (address token0, uint24 fee, address token1)
```

Returns the pool details starting at byte 0

_length and overflow checks must be carried out before calling_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to slice |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| token0 | address | The address at byte 0 |
| fee | uint24 | The uint24 starting at byte 20 |
| token1 | address | The address at byte 23 |

### toLengthOffset

```solidity
function toLengthOffset(bytes _bytes, uint256 _arg) internal pure returns (uint256 length, uint256 offset)
```

Decode the `_arg`-th element in `_bytes` as a dynamic array

_The decoding of `length` and `offset` is universal,
whereas the type declaration of `res` instructs the compiler how to read it._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to slice |
| _arg | uint256 | The index of the argument to extract |

#### Return Values

| Name | Type | Description |
| ---- | ---- | ----------- |
| length | uint256 | Length of the array |
| offset | uint256 | Pointer to the data part of the array |

### toBytes

```solidity
function toBytes(bytes _bytes, uint256 _arg) internal pure returns (bytes res)
```

Decode the `_arg`-th element in `_bytes` as `bytes`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to extract a bytes string from |
| _arg | uint256 | The index of the argument to extract |

### toAddressArray

```solidity
function toAddressArray(bytes _bytes, uint256 _arg) internal pure returns (address[] res)
```

Decode the `_arg`-th element in `_bytes` as `address[]`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to extract an address array from |
| _arg | uint256 | The index of the argument to extract |

### toBytesArray

```solidity
function toBytesArray(bytes _bytes, uint256 _arg) internal pure returns (bytes[] res)
```

Decode the `_arg`-th element in `_bytes` as `bytes[]`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to extract a bytes array from |
| _arg | uint256 | The index of the argument to extract |

### toUintArray

```solidity
function toUintArray(bytes _bytes, uint256 _arg) internal pure returns (uint256[] res)
```

Decode the `_arg`-th element in `_bytes` as `uint[]`

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| _bytes | bytes | The input bytes string to extract an uint array from |
| _arg | uint256 | The index of the argument to extract |

