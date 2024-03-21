# Solidity API

## Allowance

### updateAll

```solidity
function updateAll(struct IAllowanceTransfer.PackedAllowance allowed, uint160 amount, uint48 expiration, uint48 nonce) internal
```

Sets the allowed amount, expiry, and nonce of the spender's permissions on owner's token.

_Nonce is incremented.
If the inputted expiration is 0, the stored expiration is set to block.timestamp_

### updateAmountAndExpiration

```solidity
function updateAmountAndExpiration(struct IAllowanceTransfer.PackedAllowance allowed, uint160 amount, uint48 expiration) internal
```

Sets the allowed amount and expiry of the spender's permissions on owner's token.

_Nonce does not need to be incremented._

### pack

```solidity
function pack(uint160 amount, uint48 expiration, uint48 nonce) internal pure returns (uint256 word)
```

Computes the packed slot of the amount, expiration, and nonce that make up PackedAllowance

