// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "@pancakeswap/v4-core/src/types/PoolKey.sol";
import {BalanceDelta, toBalanceDelta} from "@pancakeswap/v4-core/src/types/BalanceDelta.sol";
import {PoolId, PoolIdLibrary} from "@pancakeswap/v4-core/src/types/PoolId.sol";
import {Currency} from "@pancakeswap/v4-core/src/types/Currency.sol";
import {ICLPoolManager} from "@pancakeswap/v4-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {CurrencySettlement} from "@pancakeswap/v4-core/test/helpers/CurrencySettlement.sol";
import {CLBaseHook} from "./CLBaseHook.sol";

/// @notice LiquidityRemovalFeeHook takes 10% fee when user remove liquidity
contract LiquidityRemovalFeeHook is CLBaseHook {
    using PoolIdLibrary for PoolKey;
    using CurrencySettlement for Currency;

    constructor(ICLPoolManager _poolManager) CLBaseHook(_poolManager) {}

    function getHooksRegistrationBitmap() external pure override returns (uint16) {
        return _hooksRegistrationBitmapFrom(
            Permissions({
                beforeInitialize: false,
                afterInitialize: false,
                beforeAddLiquidity: false,
                afterAddLiquidity: false,
                beforeRemoveLiquidity: false,
                afterRemoveLiquidity: true,
                beforeSwap: false,
                afterSwap: false,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnsDelta: false,
                afterSwapReturnsDelta: false,
                afterAddLiquidityReturnsDelta: false,
                afterRemoveLiquidityReturnsDelta: true
            })
        );
    }

    function afterRemoveLiquidity(
        address sender,
        PoolKey calldata key,
        ICLPoolManager.ModifyLiquidityParams calldata params,
        BalanceDelta delta,
        bytes calldata hookData
    ) external override poolManagerOnly returns (bytes4, BalanceDelta) {

        // delta would be positive here as user is removing liquidity
        uint128 amt0Fee = uint128(delta.amount0()) / 10;
        uint128 amt1Fee = uint128(delta.amount1()) / 10;

        key.currency0.take(vault, address(this), amt0Fee, false);
        key.currency1.take(vault, address(this), amt1Fee, false);

        // take 10% fee 
        BalanceDelta feeDelta = toBalanceDelta(int128(amt0Fee), int128(amt1Fee));

        return (this.afterRemoveLiquidity.selector, feeDelta);
    }
}
