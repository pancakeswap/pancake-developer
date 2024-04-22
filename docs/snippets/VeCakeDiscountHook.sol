// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {PoolKey} from "@pancakeswap/v4-core/src/types/PoolKey.sol";
import {PoolId, PoolIdLibrary} from "@pancakeswap/v4-core/src/types/PoolId.sol";
import {SwapFeeLibrary} from "@pancakeswap/v4-core/src/libraries/SwapFeeLibrary.sol";
import {ICLPoolManager} from "@pancakeswap/v4-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {CLBaseHook} from "./CLBaseHook.sol";

interface IVeCake {
    function balanceOf(address account) external view returns (uint256 balance);
}

/// @notice VeCakeDiscountHook is a dynamic swap fee hook that provide swap fee discount for veCake holders
///         To keep this simple, so long swapper has >= 1 veCake, they will get 50% discount on swap fee
contract VeCakeDiscountHook is CLBaseHook {
    using PoolIdLibrary for PoolKey;

    IVeCake veCake;

    constructor(ICLPoolManager _poolManager, address _veCake) CLBaseHook(_poolManager) {
        veCake = IVeCake(_veCake);
    }

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
                noOp: false
            })
        );
    }

    function beforeSwap(address, PoolKey calldata key, ICLPoolManager.SwapParams calldata, bytes calldata)
        external
        override
        poolManagerOnly
        returns (bytes4)
    {
        uint24 swapFee = getDefaultSwapFee(key);
        if (veCake.balanceOf(tx.origin) >= 1 ether) {
            swapFee = swapFee / 2;
        }

        poolManager.updateDynamicSwapFee(key, swapFee);
        return this.beforeSwap.selector;
    }

    /// @return the default swap fee for the pool
    function getDefaultSwapFee(PoolKey calldata key) internal view returns (uint24) {
        return key.fee & SwapFeeLibrary.STATIC_FEE_MASK;
    }
}
