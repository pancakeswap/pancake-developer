# Solidity API

## Constants

Constant state used by the Universal Router

### CONTRACT_BALANCE

```solidity
uint256 CONTRACT_BALANCE
```

_Used for identifying cases when this contract's balance of a token is to be used as an input
This value is equivalent to 1<<255, i.e. a singular 1 in the most significant bit._

### ALREADY_PAID

```solidity
uint256 ALREADY_PAID
```

_Used for identifying cases when a v2 pair has already received input tokens_

### ETH

```solidity
address ETH
```

_Used as a flag for identifying the transfer of ETH instead of a token_

### MSG_SENDER

```solidity
address MSG_SENDER
```

_Used as a flag for identifying that msg.sender should be used, saves gas by sending more 0 bytes_

### ADDRESS_THIS

```solidity
address ADDRESS_THIS
```

_Used as a flag for identifying address(this) should be used, saves gas by sending more 0 bytes_

### ADDR_SIZE

```solidity
uint256 ADDR_SIZE
```

_The length of the bytes encoded address_

### V3_FEE_SIZE

```solidity
uint256 V3_FEE_SIZE
```

_The length of the bytes encoded fee_

### NEXT_V3_POOL_OFFSET

```solidity
uint256 NEXT_V3_POOL_OFFSET
```

_The offset of a single token address (20) and pool fee (3)_

### V3_POP_OFFSET

```solidity
uint256 V3_POP_OFFSET
```

_The offset of an encoded pool key
Token (20) + Fee (3) + Token (20) = 43_

### MULTIPLE_V3_POOLS_MIN_LENGTH

```solidity
uint256 MULTIPLE_V3_POOLS_MIN_LENGTH
```

_The minimum length of an encoding that contains 2 or more pools_

