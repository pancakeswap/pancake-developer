// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {PoolKey} from "infinity-core/src/types/PoolKey.sol";
import {LPFeeLibrary} from "infinity-core/src/libraries/LPFeeLibrary.sol";
import {BeforeSwapDelta, BeforeSwapDeltaLibrary} from "infinity-core/src/types/BeforeSwapDelta.sol";
import {PoolId, PoolIdLibrary} from "infinity-core/src/types/PoolId.sol";
import {ICLPoolManager} from "infinity-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {CLBaseHook} from "./CLBaseHook.sol";

interface IVeCake {
    function balanceOf(address account) external view returns (uint256 balance);
}

/// @notice VeCakeSwapDiscountHook provides 50% swap fee discount for veCake holder
/// Idea:
///   1. PancakeSwap has veCake (vote-escrowed Cake), user obtain veCake by locking cake
///   2. If the swapper holds veCake, provide 50% swap fee discount
/// Implementation:
///   1. When pool is initialized, at `afterInitialize` we store what is the intended swap fee for the pool
//    2. During `beforeSwap` callback, the hook checks if users is veCake holder and provide discount accordingly
contract VeCakeSwapDiscountHook is CLBaseHook {
    using PoolIdLibrary for PoolKey;
    using LPFeeLibrary for uint24;

    IVeCake public veCake;
    mapping(PoolId => uint24) public poolIdToLpFee;

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
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            })
        );
    }

    /// @notice The hook called before a swap
    /// @return bytes4 The function selector for the hook
    /// @return BeforeSwapDelta The hook's delta in specified and unspecified currencies.
    /// @return uint24 Optionally override the lp fee, only used if three conditions are met:
    ///     1) the Pool has a dynamic fee,
    ///     2) the value's override flag is set to 1 i.e. vaule & OVERRIDE_FEE_FLAG = 0x400000 != 0
    ///     3) the value is less than or equal to the maximum fee (1 million)
    function _beforeSwap(address, PoolKey calldata key, ICLPoolManager.SwapParams calldata, bytes calldata)
        internal
        override
        returns (bytes4, BeforeSwapDelta, uint24)
    {
        uint24 lpFee = poolIdToLpFee[key.toId()];

        /// If veCake holder, lpFee is half
        if (veCake.balanceOf(tx.origin) >= 1 ether) {
            lpFee = poolIdToLpFee[key.toId()] / 2;
        }

        return (this.beforeSwap.selector, BeforeSwapDeltaLibrary.ZERO_DELTA, lpFee | LPFeeLibrary.OVERRIDE_FEE_FLAG);
    }

    /// @notice Update the lp fee for a pool
    /// @dev warning: in production, ensure this function is only callable by authorized user
    function setLpFee(PoolKey calldata key, uint24 lpFee) external {
        poolIdToLpFee[key.toId()] = lpFee;
    }
}
