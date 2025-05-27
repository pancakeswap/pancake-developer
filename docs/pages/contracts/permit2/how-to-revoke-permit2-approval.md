# Revoking Permit2 approval

## Context

With the recent PancakeSwap UI update, users may have noticed that they are prompted to sign a Permit2 approval granting `type(uint256).max` instead of just the intended trading amount, with an expiration set to 30 days later.

This approach is designed to enhance user experience by reducing the need to sign a Permit2 approval before every swap.

## How to revoke permt2 approval 

For users concerned about this broad approval, the following guide explains how to revoke it.

::::steps
#### Step 1: Identify Key Addresses

Before proceeding, gather the necessary addresses,

Assume 
- User Address: `0x42571B8414c68B63A2729146CE93F23639d25399`
- Token Address (CAKE): `0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82`
- Spender (UniversalRouter): `0xd9C500DfF816a1Da21A48A732d3498Bf09dc9AEB`
- Permit2 contract: `0x31c2F6fcFf4F8759b3Bd5Bf0e1084A055615c768`

#### Step 2: Verify allowance 

Use a blockchain explorer or interact with the Permit2 contract directly by calling:

```solidity
permit2.allowance(user, token, spender)
```

If approval has been granted, you will see a response similar to:
```solidity
[ allowance(address,address,address) method Response ]
  // how much token allowance granted to universal router 
  amount   uint160 :  1461501637330902918203684832716283019655932542975 
  // when this approval expire 
  expiration   uint48 :  1750921247 
  nonce   uint48 :  1
```

This indicates that the UniversalRouter has been granted permission to spend the specified amount of CAKE tokens on behalf of the user, with the given expiration timestamp.

#### Step 3: Revoke the Approval

To revoke the approval, call:

```solidity
permit2.approve(token, spender, amount=0, expiration=0);
```
This will reset the allowance and expiration, effectively revoking access.

#### Step 4: Confirm Revocation
Re-run the check from Step 2:

```solidity
permit2.allowance(user, token, spender)
```

The expected response should show:

```solidity
[ allowance(address,address,address) method Response ]
  amount   uint160 :  0
  // current block.timestamp 
  expiration   uint48 :  1748334096
  nonce   uint48 :  0
```
