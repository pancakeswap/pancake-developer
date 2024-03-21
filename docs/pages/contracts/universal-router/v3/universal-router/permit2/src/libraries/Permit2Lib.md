# Solidity API

## Permit2Lib

Enables efficient transfers and EIP-2612/DAI
permits for any token by falling back to Permit2.

### DAI_DOMAIN_SEPARATOR

```solidity
bytes32 DAI_DOMAIN_SEPARATOR
```

_The unique EIP-712 domain domain separator for the DAI token contract._

### WETH9_ADDRESS

```solidity
bytes32 WETH9_ADDRESS
```

_The address for the WETH9 contract on Ethereum mainnet, encoded as a bytes32._

### PERMIT2

```solidity
contract IAllowanceTransfer PERMIT2
```

_The address of the Permit2 contract the library will use._

### transferFrom2

```solidity
function transferFrom2(contract ERC20 token, address from, address to, uint256 amount) internal
```

Transfer a given amount of tokens from one user to another.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | contract ERC20 | The token to transfer. |
| from | address | The user to transfer from. |
| to | address | The user to transfer to. |
| amount | uint256 | The amount to transfer. |

### permit2

```solidity
function permit2(contract ERC20 token, address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) internal
```

Permit a user to spend a given amount of
another user's tokens via native EIP-2612 permit if possible, falling
back to Permit2 if native permit fails or is not implemented on the token.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | contract ERC20 | The token to permit spending. |
| owner | address | The user to permit spending from. |
| spender | address | The user to permit spending to. |
| amount | uint256 | The amount to permit spending. |
| deadline | uint256 | The timestamp after which the signature is no longer valid. |
| v | uint8 | Must produce valid secp256k1 signature from the owner along with r and s. |
| r | bytes32 | Must produce valid secp256k1 signature from the owner along with v and s. |
| s | bytes32 | Must produce valid secp256k1 signature from the owner along with r and v. |

### simplePermit2

```solidity
function simplePermit2(contract ERC20 token, address owner, address spender, uint256 amount, uint256 deadline, uint8 v, bytes32 r, bytes32 s) internal
```

Simple unlimited permit on the Permit2 contract.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | contract ERC20 | The token to permit spending. |
| owner | address | The user to permit spending from. |
| spender | address | The user to permit spending to. |
| amount | uint256 | The amount to permit spending. |
| deadline | uint256 | The timestamp after which the signature is no longer valid. |
| v | uint8 | Must produce valid secp256k1 signature from the owner along with r and s. |
| r | bytes32 | Must produce valid secp256k1 signature from the owner along with v and s. |
| s | bytes32 | Must produce valid secp256k1 signature from the owner along with r and v. |

