# Solidity API

## IAllowanceTransfer

Handles ERC20 token permissions through signature based allowance setting and ERC20 token transfers by checking allowed amounts

_Requires user's token approval on the Permit2 contract_

### AllowanceExpired

```solidity
error AllowanceExpired(uint256 deadline)
```

Thrown when an allowance on a token has expired.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| deadline | uint256 | The timestamp at which the allowed amount is no longer valid |

### InsufficientAllowance

```solidity
error InsufficientAllowance(uint256 amount)
```

Thrown when an allowance on a token has been depleted.

#### Parameters

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount | uint256 | The maximum amount allowed |

### ExcessiveInvalidation

```solidity
error ExcessiveInvalidation()
```

Thrown when too many nonces are invalidated.

### NonceInvalidation

```solidity
event NonceInvalidation(address owner, address token, address spender, uint48 newNonce, uint48 oldNonce)
```

Emits an event when the owner successfully invalidates an ordered nonce.

### Approval

```solidity
event Approval(address owner, address token, address spender, uint160 amount, uint48 expiration)
```

Emits an event when the owner successfully sets permissions on a token for the spender.

### Permit

```solidity
event Permit(address owner, address token, address spender, uint160 amount, uint48 expiration, uint48 nonce)
```

Emits an event when the owner successfully sets permissions using a permit signature on a token for the spender.

### Lockdown

```solidity
event Lockdown(address owner, address token, address spender)
```

Emits an event when the owner sets the allowance back to 0 with the lockdown function.

### PermitDetails

```solidity
struct PermitDetails {
  address token;
  uint160 amount;
  uint48 expiration;
  uint48 nonce;
}
```

### PermitSingle

```solidity
struct PermitSingle {
  struct IAllowanceTransfer.PermitDetails details;
  address spender;
  uint256 sigDeadline;
}
```

### PermitBatch

```solidity
struct PermitBatch {
  struct IAllowanceTransfer.PermitDetails[] details;
  address spender;
  uint256 sigDeadline;
}
```

### PackedAllowance

```solidity
struct PackedAllowance {
  uint160 amount;
  uint48 expiration;
  uint48 nonce;
}
```

### TokenSpenderPair

```solidity
struct TokenSpenderPair {
  address token;
  address spender;
}
```

### AllowanceTransferDetails

```solidity
struct AllowanceTransferDetails {
  address from;
  address to;
  uint160 amount;
  address token;
}
```

### allowance

```solidity
function allowance(address user, address token, address spender) external view returns (uint160 amount, uint48 expiration, uint48 nonce)
```

A mapping from owner address to token address to spender address to PackedAllowance struct, which contains details and conditions of the approval.
The mapping is indexed in the above order see: allowance[ownerAddress][tokenAddress][spenderAddress]

_The packed slot holds the allowed amount, expiration at which the allowed amount is no longer valid, and current nonce thats updated on any signature based approvals._

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

