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

/// @notice VeCakeDiscountHook is a contract that provide 50% swap fee discount to veCake holder
/// @dev note the code is not production ready, it is only to share how a hook looks like
contract VeCakeDiscountHook is CLBaseHook {
    using PoolIdLibrary for PoolKey;

    IVeCake public veCake;
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
        uint24 swapFee = abi.decode(hookData, (uint24));
        poolIdToLpFee[key.toId()] = swapFee;

        return this.afterInitialize.selector;
    }

    function beforeSwap(address, PoolKey calldata key, ICLPoolManager.SwapParams calldata, bytes calldata)
        external
        override
        poolManagerOnly
        returns (bytes4, BeforeSwapDelta, uint24)
    {
        uint24 lpFee = poolIdToLpFee[key.toId()];

        if (veCake.balanceOf(tx.origin) >= 1 ether) {
            lpFee = lpFee / 2;
        }

        return (this.beforeSwap.selector, BeforeSwapDeltaLibrary.ZERO_DELTA, lpFee | LPFeeLibrary.OVERRIDE_FEE_FLAG);
    }
}
