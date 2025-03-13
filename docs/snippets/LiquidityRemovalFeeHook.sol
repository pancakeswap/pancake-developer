// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "infinity-core/src/types/PoolKey.sol";
import {BalanceDelta, toBalanceDelta} from "infinity-core/src/types/BalanceDelta.sol";
import {PoolId, PoolIdLibrary} from "infinity-core/src/types/PoolId.sol";
import {Currency} from "infinity-core/src/types/Currency.sol";
import {ICLPoolManager} from "infinity-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {CurrencySettlement} from "infinity-core/test/helpers/CurrencySettlement.sol";
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
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: true
            })
        );
    }

    function _afterRemoveLiquidity(
        address sender,
        PoolKey calldata key,
        ICLPoolManager.ModifyLiquidityParams calldata params,
        BalanceDelta delta,
        BalanceDelta feesAccrued,
        bytes calldata hookData
    ) internal override returns (bytes4, BalanceDelta) {
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
