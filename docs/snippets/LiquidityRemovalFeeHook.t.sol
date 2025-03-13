// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {MockERC20} from "solmate/src/test/utils/mocks/MockERC20.sol";
import {Test} from "forge-std/Test.sol";
import {Constants} from "infinity-core/test/pool-cl/helpers/Constants.sol";
import {Currency} from "infinity-core/src/types/Currency.sol";
import {PoolKey} from "infinity-core/src/types/PoolKey.sol";
import {CLPoolParametersHelper} from "infinity-core/src/pool-cl/libraries/CLPoolParametersHelper.sol";
import {LiquidityRemovalFeeHook} from "../../src/pool-cl/LiquidityRemovalFeeHook.sol";
import {CLTestUtils} from "./utils/CLTestUtils.sol";
import {PoolIdLibrary} from "infinity-core/src/types/PoolId.sol";

contract LiquidityRemovalFeeHookTest is Test, CLTestUtils {
    using PoolIdLibrary for PoolKey;
    using CLPoolParametersHelper for bytes32;

    LiquidityRemovalFeeHook hook;
    Currency currency0;
    Currency currency1;
    PoolKey key;
    address alice = makeAddr("alice");

    function setUp() public {
        (currency0, currency1) = deployContractsWithTokens();
        hook = new LiquidityRemovalFeeHook(poolManager);

        // create the pool key
        key = PoolKey({
            currency0: currency0,
            currency1: currency1,
            hooks: hook,
            poolManager: poolManager,
            fee: uint24(3000), // 0.3% fee
            parameters: bytes32(uint256(hook.getHooksRegistrationBitmap())).setTickSpacing(10)
        });

        // initialize pool at 1:1 price point
        poolManager.initialize(key, Constants.SQRT_RATIO_1_1);

        // approve from alice for liquidity operation in the test cases below
        permit2Approve(alice, currency0, address(positionManager));
        permit2Approve(alice, currency1, address(positionManager));
    }

    function testRemoveLiquidity() public {
        MockERC20(Currency.unwrap(currency0)).mint(address(alice), 10 ether);
        MockERC20(Currency.unwrap(currency1)).mint(address(alice), 10 ether);

        vm.startPrank(alice);

        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 10 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 10 ether);

        // add 10 eth liquidity on each side
        uint256 tokenId = addLiquidity(key, 10 ether, 10 ether, -60, 60, alice);

        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 0 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 0 ether);

        // remove all liqudiity
        decreaseLiquidity(tokenId, key, 10 ether, 10 ether, -60, 60);

        // verify that only 9 ether received as 10% fee taken
        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 9 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 9 ether);
    }
}
