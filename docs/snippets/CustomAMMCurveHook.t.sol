// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";
import {Test} from "forge-std/Test.sol";
import {Constants} from "@pancakeswap/v4-core/test/pool-cl/helpers/Constants.sol";
import {Currency} from "@pancakeswap/v4-core/src/types/Currency.sol";
import {PoolKey} from "@pancakeswap/v4-core/src/types/PoolKey.sol";
import {CLPoolParametersHelper} from "@pancakeswap/v4-core/src/pool-cl/libraries/CLPoolParametersHelper.sol";
import {CustomAMMCurveHook} from "../../src/pool-cl/CustomAMMCurveHook.sol";
import {CLTestUtils} from "./utils/CLTestUtils.sol";
import {PoolIdLibrary} from "@pancakeswap/v4-core/src/types/PoolId.sol";
import {ICLSwapRouterBase} from "@pancakeswap/v4-periphery/src/pool-cl/interfaces/ICLSwapRouterBase.sol";
import {LPFeeLibrary} from "@pancakeswap/v4-core/src/libraries/LPFeeLibrary.sol";

contract CustomAMMCurveHookTest is Test, CLTestUtils {
    using PoolIdLibrary for PoolKey;
    using CLPoolParametersHelper for bytes32;

    CustomAMMCurveHook hook;
    Currency currency0;
    Currency currency1;
    PoolKey key;
    address alice = makeAddr("alice");

    function setUp() public {
        (currency0, currency1) = deployContractsWithTokens();
        hook = new CustomAMMCurveHook(poolManager);

        // create the pool key
        key = PoolKey({
            currency0: currency0,
            currency1: currency1,
            hooks: hook,
            poolManager: poolManager,
            fee: uint24(3000), // 0.3% fee
            parameters: bytes32(uint256(hook.getHooksRegistrationBitmap())).setTickSpacing(10)
        });

        // initialize pool at 1:1 price point and set 3000 as initial lp fee, lpFee is stored in the hook
        poolManager.initialize(key, Constants.SQRT_RATIO_1_1, abi.encode(uint24(3000)));

        // Add some liquidity so currency does not go negative and negate in Vault.sol
        MockERC20(Currency.unwrap(currency0)).mint(address(this), 100 ether);
        MockERC20(Currency.unwrap(currency1)).mint(address(this), 100 ether);
        addLiquidity(key, 100 ether, 100 ether, -60, 60);

        // approve from alice for swap in the test cases below
        vm.startPrank(alice);
        MockERC20(Currency.unwrap(currency0)).approve(address(swapRouter), type(uint256).max);
        MockERC20(Currency.unwrap(currency1)).approve(address(swapRouter), type(uint256).max);
        vm.stopPrank();

        // mint alice token for trade later
        MockERC20(Currency.unwrap(currency0)).mint(address(alice), 100 ether);
        MockERC20(Currency.unwrap(currency1)).mint(address(alice), 100 ether);

        // mint hook some token for take/settle
        MockERC20(Currency.unwrap(currency0)).mint(address(hook), 100 ether);
        MockERC20(Currency.unwrap(currency1)).mint(address(hook), 100 ether);
    }

    function testSwapZeroForOne_exactIn() public {
        vm.prank(alice);
        uint256 amtOut = swapRouter.exactInputSingle(
            ICLSwapRouterBase.V4CLExactInputSingleParams({
                poolKey: key,
                zeroForOne: true,
                recipient: address(alice),
                amountIn: 1 ether,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0,
                hookData: new bytes(0)
            }),
            block.timestamp
        );

        assertEq(amtOut, 1 ether);
    }

    function testSwapOneForZero_exactIn() public {
        vm.prank(alice);
        uint256 amtOut = swapRouter.exactInputSingle(
            ICLSwapRouterBase.V4CLExactInputSingleParams({
                poolKey: key,
                zeroForOne: false,
                recipient: address(alice),
                amountIn: 1 ether,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0,
                hookData: new bytes(0)
            }),
            block.timestamp
        );

        assertEq(amtOut, 1 ether);
    }

    function testSwapZeroForOne_exactOut() public {
        vm.prank(alice);
        uint256 amtIn = swapRouter.exactOutputSingle(
            ICLSwapRouterBase.V4CLExactOutputSingleParams({
                poolKey: key,
                zeroForOne: true,
                recipient: address(alice),
                amountOut: 1 ether,
                amountInMaximum: type(uint128).max,
                sqrtPriceLimitX96: 0,
                hookData: new bytes(0)
            }),
            block.timestamp
        );

        assertEq(amtIn, 1 ether);
    }

    function testSwapOneForZero_exactOut() public {
        vm.prank(alice);
        uint256 amtIn = swapRouter.exactOutputSingle(
            ICLSwapRouterBase.V4CLExactOutputSingleParams({
                poolKey: key,
                zeroForOne: false,
                recipient: address(alice),
                amountOut: 1 ether,
                amountInMaximum: type(uint128).max,
                sqrtPriceLimitX96: 0,
                hookData: new bytes(0)
            }),
            block.timestamp
        );

        assertEq(amtIn, 1 ether);
    }
}
