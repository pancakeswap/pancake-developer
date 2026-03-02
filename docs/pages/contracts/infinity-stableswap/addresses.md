---
description: Infinity Stableswap
---

# Infinity Stableswap

The `CLStableSwapHook` is a smart contract hook that extends PancakeSwap Infinity's concentrated liquidity functionality to support stable swap. It implements a Curve-style StableSwap AMM as a hook on top of the Infinity CLPoolManager, providing low-slippage swaps for similarly-priced assets (stablecoins, LSTs, etc.).

## How It Works

The system consists of three core contracts:

- **CLStableSwapPoolFactory** - Entry point for developers to create pools and add initial liquidity. Orchestrates pool deployment and initialization with the Infinity CLPoolManager.
- **CLStableSwapHookFactory** - Vyper factory that deploys individual pool hooks using blueprint patterns. Maintains a registry of all pools and their metadata.
- **CLStableSwapHook** - The core AMM logic (Vyper). Each pool is a separate hook instance that implements the StableSwap invariant. Also acts as the ERC20 LP token (18 decimals).

**Architecture flow:**

1. `CLStableSwapPoolFactory.createPool()` calls `CLStableSwapHookFactory.deploy_plain_pool()` to deploy a new hook instance
2. The factory then initializes the pool with `CLPoolManager.initialize()`
3. Swaps route through the Infinity CLPoolManager, which calls the hook's `beforeSwap()` to execute the StableSwap logic
4. Liquidity operations (`add_liquidity`, `remove_liquidity`) are called directly on the hook contract

## Key Features for Developers

### 1. **Create Pools**

Use `CLStableSwapPoolFactory` to create new stableswap pools.

```solidity
ICLStableSwapPoolFactory.CreatePoolParam memory params = ICLStableSwapPoolFactory.CreatePoolParam({
    name: "USDC-USDT",
    symbol: "cUSDT",
    coins: [USDC, USDT],              // Token addresses (must be sorted)
    A: 200,                            // Amplification coefficient
    fee: 1000000,                      // 0.01% swap fee (1e10 precision)
    offpegFeeMultiplier: 20000000000,  // Dynamic fee multiplier when pool is imbalanced
    maExpTime: 866,                    // EMA window (~10 min, calculated as seconds / ln(2))
    implementationIdx: 0,              // Implementation version
    assetTypes: [0, 0],                // 0=Standard, 1=Oracle, 3=ERC4626
    methodIds: [bytes4(0), bytes4(0)], // Oracle method IDs (for asset type 1)
    oracles: [address(0), address(0)]  // Oracle addresses (for asset type 1)
});

// Create pool only
PoolKey memory key = poolFactory.createPool(params);

// Or create pool and add initial liquidity in one transaction
(PoolKey memory key, uint256 lpMinted) = poolFactory.createPoolAndAddLiquidity(
    params,
    ICLStableSwapPoolFactory.AddLiquidityParam({
        amount0: 1000e6,     // Amount of token0
        amount1: 1000e6,     // Amount of token1
        minMintAmount: 0,    // Minimum LP tokens (slippage protection)
        receiver: msg.sender // LP token recipient
    })
);
```

**Asset Types:**
| Value | Type | Description |
| ----- | ---- | ----------- |
| 0 | Standard | Regular ERC20 tokens (USDC, USDT, DAI) |
| 1 | Oracle | Tokens with a rate oracle (wstETH, cbETH) - requires `methodIds` and `oracles` |
| 3 | ERC4626 | Vault tokens (sDAI) - rate from `convertToAssets()` |

### 2. **Add Liquidity**

Call `add_liquidity` directly on the hook (pool) contract. Tokens must be approved to the hook beforehand.

```solidity
// Approve tokens to the hook
IERC20(token0).approve(hookAddress, amount0);
IERC20(token1).approve(hookAddress, amount1);

// Add liquidity - returns LP tokens minted
uint256 lpMinted = ICLStableSwapHook(hookAddress).add_liquidity(
    amount0,         // Amount of token0
    amount1,         // Amount of token1
    minMintAmount,   // Minimum LP tokens to receive
    receiver         // LP token recipient
);
```

### 3. **Remove Liquidity**

Three methods for removing liquidity:

```solidity
// Proportional withdrawal - burn LP tokens, receive both tokens proportionally
(uint256 amount0, uint256 amount1) = hook.remove_liquidity(
    burnAmount,    // LP tokens to burn
    minAmount0,    // Minimum token0 to receive
    minAmount1,    // Minimum token1 to receive
    receiver,      // Token recipient
    true           // Claim admin fees
);

// Single-token withdrawal - burn LP tokens, receive one token
uint256 amountOut = hook.remove_liquidity_one_coin(
    burnAmount,    // LP tokens to burn
    true,          // true = token0, false = token1
    minReceived,   // Minimum tokens to receive
    receiver       // Token recipient
);

// Imbalanced withdrawal - specify exact token amounts to receive
uint256 lpBurned = hook.remove_liquidity_imbalance(
    amount0,         // Exact token0 to receive
    amount1,         // Exact token1 to receive
    maxBurnAmount,   // Maximum LP tokens to burn
    receiver         // Token recipient
);
```

### 4. **Swap**

Swaps are routed through the Infinity CLPoolManager (e.g. via the Universal Router). The hook's `beforeSwap()` handles the StableSwap math internally.

#### Quoting

Use the quoting functions on the hook contract for off-chain price estimation:

```solidity
// Get output amount for a given input
uint256 amountOut = hook.get_dy(0, 1, amountIn);   // token0 -> token1
uint256 amountOut = hook.get_dy(1, 0, amountIn);   // token1 -> token0

// Get required input for a desired output
uint256 amountIn = hook.get_dx(0, 1, desiredOut);   // How much token0 for desiredOut of token1

// Estimate LP tokens for a deposit
uint256 lpTokens = hook.calc_token_amount([amount0, amount1], true);   // true = deposit

// Estimate tokens from single-coin LP withdrawal
uint256 tokenOut = hook.calc_withdraw_one_coin(lpBurnAmount, 0);   // 0 = token0 index
```

### 5. **Dynamic Fees**

The pool uses dynamic fees that increase when the pool is imbalanced (depegged). This protects LPs from adverse selection.

```solidity
// Get current fee between two tokens (1e10 precision)
uint256 currentFee = hook.dynamic_fee(0, 1);

// View base fee configuration
uint256 baseFee = hook.fee();                          // Base swap fee
uint256 multiplier = hook.offpeg_fee_multiplier();     // Depeg fee multiplier
```

**Fee precision:** All fees use `1e10` denomination. For example:
- `1000000` = 0.01%
- `4000000` = 0.04%
- `50000000` = 0.5%

**Admin fee:** 50% of swap fees are collected as admin fees.

### 6. **Pool Discovery**

Use the hook factory to find pools and query pool metadata:

```solidity
// Find a pool for a token pair
address pool = hookFactory.find_pool_for_coins(tokenA, tokenB);

// Query pool info
address[] memory coins = hookFactory.get_coins(pool);
uint256[] memory balances = hookFactory.get_balances(pool);
uint256 A = hookFactory.get_A(pool);
(uint256 fee, uint256 adminFee) = hookFactory.get_fees(pool);
uint256 nCoins = hookFactory.get_n_coins(pool);
uint8[] memory assetTypes = hookFactory.get_pool_asset_types(pool);

// Pool registry
uint256 totalPools = hookFactory.pool_count();
address poolAtIndex = hookFactory.pool_list(index);
```

### 7. **Price Oracle**

Each pool exposes an EMA (exponential moving average) price oracle:

```solidity
uint256 spotPrice = hook.get_p(0);          // Current state price
uint256 emaPrice = hook.price_oracle(0);     // EMA price oracle
uint256 lastPrice = hook.last_price(0);      // Price from last swap
uint256 virtualPrice = hook.get_virtual_price(); // LP token price
uint256 dOracle = hook.D_oracle();           // TVL oracle
```

## Contract Addresses

### CLStableSwapPoolFactory

**Mainnet**

| Chain | Address |
| ----- | ------- |
| BSC   | 0x3669dDD1a9ee009dB9Eb2174C5C760FFfc66cfeF |

### CLStableSwapHookFactory

**Mainnet**

| Chain | Address |
| ----- | ------- |
| BSC   | 0x44de03599d1088b205D959b09A842448A0a63173 |

