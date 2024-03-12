# SmartRouterV3

## Contract Info

[Contract address](/contracts/v3/addresses#smart-router)

:::info
## Notice

At the very end of all swaps via router, `refundETH` should be called. PancakeSwap will ensure this.
:::

## API

### constructor

`constructor(address _factoryV2, address _deployer, address _factoryV3, address _positionManager, address _stableFactory, address _stableInfo, address _WETH9) public`
