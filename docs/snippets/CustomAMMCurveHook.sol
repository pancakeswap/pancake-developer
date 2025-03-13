// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "infinity-core/src/types/PoolKey.sol";
import {BeforeSwapDelta, toBeforeSwapDelta} from "infinity-core/src/types/BeforeSwapDelta.sol";
import {PoolId, PoolIdLibrary} from "infinity-core/src/types/PoolId.sol";
import {Currency} from "infinity-core/src/types/Currency.sol";
import {ICLPoolManager} from "infinity-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {LPFeeLibrary} from "infinity-core/src/libraries/LPFeeLibrary.sol";
import {CurrencySettlement} from "infinity-core/test/helpers/CurrencySettlement.sol";
import {CLBaseHook} from "./CLBaseHook.sol";

/// @notice CustomAMMCurveHook override AMM curve with 1:1 curve and 0 trading slippage
contract CustomAMMCurveHook is CLBaseHook {
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
                afterRemoveLiquidity: false,
                beforeSwap: true,
                afterSwap: false,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnDelta: true,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            })
        );
    }

    function _beforeSwap(address, PoolKey calldata key, ICLPoolManager.SwapParams calldata params, bytes calldata)
        internal
        override
        returns (bytes4, BeforeSwapDelta, uint24)
    {
        (Currency inputCurrency, Currency outputCurrency, uint256 amount) = _getInputOutputAndAmount(key, params);

        // 1. Take input currency and amount
        inputCurrency.take(vault, address(this), amount, false);

        // 2. Give output currency and amount achieving a 1:1 swap
        outputCurrency.settle(vault, address(this), amount, false);

        BeforeSwapDelta hookDelta = toBeforeSwapDelta(int128(-params.amountSpecified), int128(params.amountSpecified));
        return (this.beforeSwap.selector, hookDelta, 0);
    }

    /// @notice Get input, output currencies and amount from swap params
    function _getInputOutputAndAmount(PoolKey calldata key, ICLPoolManager.SwapParams calldata params)
        internal
        pure
        returns (Currency input, Currency output, uint256 amount)
    {
        (input, output) = params.zeroForOne ? (key.currency0, key.currency1) : (key.currency1, key.currency0);

        amount = params.amountSpecified < 0 ? uint256(-params.amountSpecified) : uint256(params.amountSpecified);
    }
}
