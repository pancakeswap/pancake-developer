// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";
import {Test} from "forge-std/Test.sol";
import {Constants} from "@pancakeswap/v4-core/test/pool-cl/helpers/Constants.sol";
import {Currency} from "@pancakeswap/v4-core/src/types/Currency.sol";
import {PoolKey} from "@pancakeswap/v4-core/src/types/PoolKey.sol";
import {CLPoolParametersHelper} from "@pancakeswap/v4-core/src/pool-cl/libraries/CLPoolParametersHelper.sol";
import {LiquidityRemovalFeeHook} from "../../src/pool-cl/LiquidityRemovalFeeHook.sol";
import {CLTestUtils} from "./utils/CLTestUtils.sol";
import {PoolIdLibrary} from "@pancakeswap/v4-core/src/types/PoolId.sol";
import {ICLSwapRouterBase} from "@pancakeswap/v4-periphery/src/pool-cl/interfaces/ICLSwapRouterBase.sol";
import {INonfungiblePositionManager} from
    "@pancakeswap/v4-periphery/src/pool-cl/interfaces/INonfungiblePositionManager.sol";

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

        // initialize pool at 1:1 price point and set 3000 as initial lp fee, lpFee is stored in the hook
        poolManager.initialize(key, Constants.SQRT_RATIO_1_1, abi.encode(uint24(3000)));

        // approve from alice for liquidity ops in the test cases below
        vm.startPrank(alice);
        MockERC20(Currency.unwrap(currency0)).approve(address(nfp), type(uint256).max);
        MockERC20(Currency.unwrap(currency1)).approve(address(nfp), type(uint256).max);
        vm.stopPrank();
    }

    function testRemoveLiquidity() public {
        MockERC20(Currency.unwrap(currency0)).mint(address(alice), 10 ether);
        MockERC20(Currency.unwrap(currency1)).mint(address(alice), 10 ether);

        vm.startPrank(alice);

        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 10 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 10 ether);

        // add 10 eth liquidity on each side
        (uint256 tokenId, uint128 liquidity) = _addLiquidity(key, 10 ether, 10 ether, -60, 60);

        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 0 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 0 ether);

        // remove all liqudiity
        _removeLiquidity(tokenId, liquidity);

        // verify that only 9 ether received as 10% fee taken
        assertEq(MockERC20(Currency.unwrap(currency0)).balanceOf(alice), 9 ether);
        assertEq(MockERC20(Currency.unwrap(currency1)).balanceOf(alice), 9 ether);
    }

    function _addLiquidity(PoolKey memory key, uint256 amount0, uint256 amount1, int24 tickLower, int24 tickUpper)
        internal
        returns (uint256 tokenId, uint128 liquidity)
    {
        INonfungiblePositionManager.MintParams memory param = INonfungiblePositionManager.MintParams({
            poolKey: key,
            tickLower: tickLower,
            tickUpper: tickUpper,
            salt: bytes32(0),
            amount0Desired: amount0,
            amount1Desired: amount1,
            amount0Min: 0,
            amount1Min: 0,
            recipient: address(alice),
            deadline: block.timestamp
        });

        (tokenId, liquidity,,) = nfp.mint(param);
    }

    function _removeLiquidity(uint256 tokenId, uint128 liquidity) internal {
        INonfungiblePositionManager.DecreaseLiquidityParams memory param = INonfungiblePositionManager
            .DecreaseLiquidityParams({
            tokenId: tokenId,
            liquidity: liquidity,
            amount0Min: 0,
            amount1Min: 0,
            deadline: block.timestamp
        });

        nfp.decreaseLiquidity(param);
    }
}
