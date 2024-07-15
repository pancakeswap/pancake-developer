// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PoolKey} from "@pancakeswap/v4-core/src/types/PoolKey.sol";
import {BalanceDelta, BalanceDeltaLibrary} from "@pancakeswap/v4-core/src/types/BalanceDelta.sol";
import {BeforeSwapDelta, BeforeSwapDeltaLibrary} from "@pancakeswap/v4-core/src/types/BeforeSwapDelta.sol";
import {PoolId, PoolIdLibrary} from "@pancakeswap/v4-core/src/types/PoolId.sol";
import {ICLPoolManager} from "@pancakeswap/v4-core/src/pool-cl/interfaces/ICLPoolManager.sol";
import {LPFeeLibrary} from "@pancakeswap/v4-core/src/libraries/LPFeeLibrary.sol";
import {CLBaseHook} from "./CLBaseHook.sol";

interface IVeCake {
    function balanceOf(address account) external view returns (uint256 balance);
}

/// @notice VeCakeTimeLockHook is a contract that allows only veCake holders to mint for the first hour of pool initialization
/// @dev note the code is not production ready, it is only to share how a hook looks like
contract VeCakeTimeLockHook is CLBaseHook {
    using PoolIdLibrary for PoolKey;

    IVeCake public veCake;
    mapping(PoolId => uint256) public poolInitializationTime;
    mapping(PoolId => uint24) public poolIdToLpFee;

    constructor(ICLPoolManager _poolManager, address _veCake) CLBaseHook(_poolManager) {
        veCake = IVeCake(_veCake);
    }

    function getHooksRegistrationBitmap() external pure override returns (uint16) {
        return _hooksRegistrationBitmapFrom(
            Permissions({
                beforeInitialize: false,
                afterInitialize: true,
                beforeAddLiquidity: false,
                afterAddLiquidity: false,
                beforeRemoveLiquidity: false,
                afterRemoveLiquidity: false,
                beforeSwap: true,
                afterSwap: false,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnsDelta: false,
                afterSwapReturnsDelta: false,
                afterAddLiquidityReturnsDelta: false,
                afterRemoveLiquidityReturnsDelta: false
            })
        );
    }

    function afterInitialize(address, PoolKey calldata key, uint160, int24, bytes calldata hookData)
        external
        override
        returns (bytes4)
    {
        poolInitializationTime[key.toId()] = block.timestamp;

        uint24 swapFee = abi.decode(hookData, (uint24));
        poolIdToLpFee[key.toId()] = swapFee;

        return this.afterInitialize.selector;
    }

    function beforeSwap(address, PoolKey calldata key, ICLPoolManager.SwapParams calldata, bytes calldata)
        external
        view
        override
        poolManagerOnly
        returns (bytes4, BeforeSwapDelta, uint24)
    {
        uint256 initializationTime = poolInitializationTime[key.toId()];
        uint24 swapFee = poolIdToLpFee[key.toId()];

        if (block.timestamp < initializationTime + 1 hours && veCake.balanceOf(tx.origin) > 0) {
            swapFee = 0; 
        }

        return (this.beforeSwap.selector, BeforeSwapDeltaLibrary.ZERO_DELTA, swapFee | LPFeeLibrary.OVERRIDE_FEE_FLAG);
    }
}
