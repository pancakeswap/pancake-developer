# Factory v2

:::warning
PancakeSwap is based on Uniswap v2. Read the [Uniswap v2 documentation](https://docs.uniswap.org/contracts/v2/overview).\
For more in-depth information on the core contract logic, read the [Uniswap v2 Core whitepaper](https://uniswap.org/whitepaper.pdf).
:::

## Contract info

**Contract name:** PancakeFactory

View [PancakeFactory.sol on GitHub](https://github.com/pancakeswap/pancake-contracts/blob/master/projects/exchange-protocol/contracts/PancakeFactory.sol).

| Chain    | Address                                    |
| -------- | ------------------------------------------ |
| BSC      | 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73 |
| ETH      | 0x1097053Fd2ea711dad45caCcc45EfF7548fCB362 |
| zkEVM    | 0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E |
| zkSync   | 0xd03D8D566183F0086d8D09A84E1e30b58Dd5619d |
| Arbitrum | 0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E |
| Linea    | 0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E |
| Base     | 0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E |
| opBNB    | 0x02a84c1b3BBD7401a5f7fa98a384EBC70bB5749E |

## Read functions

### getPair

`function getPair(address tokenA, address tokenB) external view returns (address pair);`

Address for `tokenA` and address for `tokenB` return address of pair contract (where one exists).

`tokenA` and `tokenB` order is interchangeable.

Returns `0x0000000000000000000000000000000000000000` as address where no pair exists.

### allPairs

`function allPairs(uint) external view returns (address pair);`

Returns the address of the `n`th pair (`0`-indexed) created through the Factory contract.

Returns `0x0000000000000000000000000000000000000000` where pair has not yet been created.

Begins at `0` for first created pair.

### allPairsLength

`function allPairsLength() external view returns (uint);`

Displays the current number of pairs created through the Factory contract as an integer.

### feeTo

`function feeTo() external view returns (address);`

The address to where non-LP-holder fees are sent.

### feeToSetter

`function feeToSetter() external view returns (address);`

The address with permission to set the feeTo address.

## Write functions

### createPair

function createPair(address tokenA, address tokenB) external returns (address pair);

Creates a pair for `tokenA` and `tokenB` where a pair doesn't already exist.

`tokenA` and `tokenB` order is interchangeable.

Emits `PairCreated` (see Events).

### setFeeTo

Sets address for `feeTo`.

### setFeeToSetter

Sets address for permission to adjust `feeTo`.

## Events

### PairCreated

`event PairCreated(address indexed token0, address indexed token1, address pair, uint);`

Emitted whenever a `createPair` creates a new pair.

`token0` will appear before `token1` in sort order.

The final `uint` log value will be `1` for the first pair created, `2` for the second, etc.

## Interface

```solidity
import '@uniswap/v2-core/contracts/interfaces/IPancakeFactory.sol';
```

```solidity
pragma solidity =0.5.16;


interface IPancakeFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
```
