# Solidity API

## AllowanceTransfer

### allowance

```solidity
mapping(address => mapping(address => mapping(address => struct IAllowanceTransfer.PackedAllowance))) allowance
```

Maps users to tokens to spender addresses and information about the approval on the token

_Indexed in the order of token owner address, token address, spender address
The stored word saves the allowed amount, expiration on the allowance, and nonce_

### approve

```solidity
function approve(address token, address spender, uint160 amount, uint48 expiration) external
```

Approves the spender to use up to amount of the specified token up until the expiration

_The packed allowance also holds a nonce, which will stay unchanged in approve
Setting amount to type(uint160).max sets an unlimited approval_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to approve |
| spender | address | The spender address to approve |
| amount | uint160 | The approved amount of the token |
| expiration | uint48 | The timestamp at which the approval is no longer valid |

### permit

```solidity
function permit(address owner, struct IAllowanceTransfer.PermitSingle permitSingle, bytes signature) external
```

Permit a spender to a given amount of the owners token via the owner's EIP-712 signature

_May fail if the owner's nonce was invalidated in-flight by invalidateNonce_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the tokens being approved |
| permitSingle | struct IAllowanceTransfer.PermitSingle | Data signed over by the owner specifying the terms of approval |
| signature | bytes | The owner's signature over the permit data |

### permit

```solidity
function permit(address owner, struct IAllowanceTransfer.PermitBatch permitBatch, bytes signature) external
```

Permit a spender to the signed amounts of the owners tokens via the owner's EIP-712 signature

_May fail if the owner's nonce was invalidated in-flight by invalidateNonce_

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | The owner of the tokens being approved |
| permitBatch | struct IAllowanceTransfer.PermitBatch | Data signed over by the owner specifying the terms of approval |
| signature | bytes | The owner's signature over the permit data |

### transferFrom

```solidity
function transferFrom(address from, address to, uint160 amount, address token) external
```

Transfer approved tokens from one address to another

_Requires the from address to have approved at least the desired amount
of tokens to msg.sender._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | The address to transfer from |
| to | address | The address of the recipient |
| amount | uint160 | The amount of the token to transfer |
| token | address | The token address to transfer |

### transferFrom

```solidity
function transferFrom(struct IAllowanceTransfer.AllowanceTransferDetails[] transferDetails) external
```

Transfer approved tokens in a batch

_Requires the from addresses to have approved at least the desired amount
of tokens to msg.sender._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| transferDetails | struct IAllowanceTransfer.AllowanceTransferDetails[] | Array of owners, recipients, amounts, and tokens for the transfers |

### lockdown

```solidity
function lockdown(struct IAllowanceTransfer.TokenSpenderPair[] approvals) external
```

Enables performing a "lockdown" of the sender's Permit2 identity
by batch revoking approvals

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| approvals | struct IAllowanceTransfer.TokenSpenderPair[] | Array of approvals to revoke. |

### invalidateNonces

```solidity
function invalidateNonces(address token, address spender, uint48 newNonce) external
```

Invalidate nonces for a given (token, spender) pair

_Can't invalidate more than 2**16 nonces per transaction._

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| token | address | The token to invalidate nonces for |
| spender | address | The spender to invalidate nonces for |
| newNonce | uint48 | The new nonce to set. Invalidates all nonces less than it. |

