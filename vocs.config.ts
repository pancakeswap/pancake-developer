import { defineConfig } from 'vocs';
import { theme } from './theme';

export default defineConfig({
  title: 'PancakeSwap Developer',
  description: 'PancakeSwap Developer Docs',
  logoUrl: {
    light: '/logo.svg',
    dark: '/logo_dark.svg',
  },
  titleTemplate: '%s | PancakeSwap Developer',
  topNav: [
    { text: 'EVM', link: '/' },
    { text: 'Aptos', link: '/contracts-aptos' },
    { text: 'Bug Bounty', link: '/bug-bounty' },
  ],
  sidebar: {
    '/': [
      {
        text: 'PancakeSwap V4',
        items: [
          {
            text: 'Overview',
            link: '/contracts/v4/overview',
            items: [
              {
                text: 'Accouting Layer | Vault',
                link: '/contracts/v4/overview/accounting-layer-vault',
              },
              {
                text: 'AMM Layer | Pool Manager',
                collapsed: true,
                link: '/contracts/v4/overview/amm-layer-poolmanager',
                items: [
                  {
                    text: 'Concentrated Liquidity',
                    link: '/contracts/v4/overview/amm-layer/concentrated-liquidity',
                  },
                  {
                    text: 'Liquidity Book',
                    link: '/contracts/v4/overview/amm-layer/liquidity-book',
                  },
                ],
              },
              {
                text: 'Custom Layer | Hook',
                link: '/contracts/v4/overview/custom-layer-hook',
              },
            ],
          },
          {
            text: 'Guides',
            items: [
              {
                text: 'Developing a hook',
                link: '/contracts/v4/guides/develop-a-hook',
              },
              {
                text: 'CL Pool - Swap and Liqudiity',
                link: '/contracts/v4/guides/concentrated-liquidity-swap-and-liquidity',
              },
              {
                text: 'Bin Pool - Swap and Liquidity',
                link: '/contracts/v4/guides/liquidity-book-swap-and-liquidity',
              },
            ],
          },
          {
            text: 'Resources',
            collapsed: true,
            items: [
              {
                text: 'Github',
                link: '/contracts/v4/resources/github',
              },
              {
                text: '<WIP> Addresses',
                link: '/contracts/v4/resources/addresses',
              },
            ],
          },
        ],
      },
      {
        text: 'PancakeSwap v3',
        items: [
          {
            text: 'Addresses',
            link: '/contracts/v3/addresses',
          },
          {
            text: 'Technical Overview',
            collapsed: true,
            items: [
              {
                text: 'PancakeV3Factory',
                link: '/contracts/v3/pancakev3factory',
              },
              {
                text: 'PancakeV3Pool',
                link: '/contracts/v3/pancakev3pool',
              },
              {
                text: 'NonfungiblePositionManager',
                link: '/contracts/v3/nonfungiblepositionmanager',
              },
              {
                collapsed: true,
                text: 'SmartRouter',
                link: '/contracts/v3/smartrouter',
                items: [
                  {
                    text: 'v3SwapRouter',
                    link: '/contracts/v3/smartrouter/v3swaprouter',
                  },
                  {
                    text: 'v2SwapRouter',
                    link: '/contracts/v3/smartrouter/v2swaprouter',
                  },
                  {
                    text: 'StableSwapRouter',
                    link: '/contracts/v3/smartrouter/stableswaprouter',
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        text: 'PancakeSwap v2',
        collapsed: true,
        items: [
          {
            text: 'FactoryV2',
            link: '/contracts/v2/factory-v2',
          },
          {
            text: 'RouterV2',
            link: '/contracts/v2/router-v2',
          },
        ],
      },
      {
        text: '',
        items: [
          {
            text: 'StableSwap',
            collapsed: true,
            items: [
              {
                text: 'Overview',
                link: '/contracts/stableswap/overview',
              },
              {
                text: 'Pool addresses',
                link: '/contracts/stableswap/stableswap-pools',
              },
            ],
          },
          {
            text: 'MasterChef',
            collapsed: true,
            items: [
              {
                text: 'Addresses',
                link: '/contracts/masterchef/addresses',
              },
              {
                text: 'v3',
                link: '/contracts/masterchef/masterchef-v3',
              },
            ],
          },
          {
            text: 'veCake and Gauge voting',
            link: '/contracts/vecake-and-gauge-voting',
          },
          {
            text: 'Syrup Pools',
            collapsed: true,
            items: [
              {
                text: 'Overview',
                link: '/contracts/syrup-pools',
              },
              {
                text: 'SmartChefInitializable',
                link: '/contracts/syrup-pools/smartchefinitializable',
              },
            ],
          },
          {
            text: 'Farm Booster (bCAKE)',
            link: '/contracts/farm-booster-bcake',
          },
          {
            text: 'IFO Commit Limit',
            link: '/contracts/ifo-commit-limit-icake',
          },
          {
            text: 'Cross Chain CAKE Bridging',
            link: '/contracts/cross-chain-cake-bridging',
          },
          {
            text: 'CAKE Syrup Pool (deprecated)',
            link: '/contracts/fixed-term-staking-cake-pool',
          },
          {
            text: 'IFO',
            link: '/contracts/ifo',
          },
          {
            text: 'Prediction',
            link: '/contracts/prediction-v2',
          },
          {
            text: 'Lottery',
            collapsed: true,
            items: [
              { text: 'Overview', link: '/contracts/lottery-v2' },
              {
                text: 'Contract',
                link: '/contracts/lottery-v2/lottery-contract',
              },
            ],
          },
          {
            text: 'Market Maker Pool',
            link: '/contracts/market-maker-pool',
          },
        ],
      },
    ],
    '/contracts-aptos': [
      {
        text: 'PancakeSwap v2',
        items: [
          {
            text: 'v2',
            items: [
              {
                text: 'Overview',
                link: '/contracts-aptos/v2/overview',
              },
              {
                text: 'Technical Overview',
                collapsed: true,
                items: [
                  {
                    text: 'Core',
                    link: '/contracts-aptos/v2/swap-core-v2',
                  },
                  {
                    text: 'Router',
                    link: '/contracts-aptos/v2/router-v2',
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        text: 'MasterChef',
        link: '/contracts-aptos/masterchef',
      },
      {
        text: 'Syrup Pools',
        link: '/contracts-aptos/syrup-pools',
      },
      {
        text: 'IFO',
        link: '/contracts-aptos/ifo',
      },
      {
        text: 'Utils',
        link: '/contracts-aptos/utils',
      },
    ],
  },
  theme,
});
