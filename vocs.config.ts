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
                  }
                ]
              },
              {
                text: 'Custom Layer | Hook',
                link: '/contracts/v4/overview/custom-layer-hook',
              },
            ]
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
              }
            ]
          },
          {
            text: 'Resources',
            items: [
              {
                text: 'Github',
                link: '/contracts/v4/resources/github',
              },
              {
                text: '<WIP> Addresses',
                link: '/contracts/v4/resources/addresses',
              },
            ]
          }
        ]
      },
      {
        text: 'PancakeSwap v3',
        items: [
          {
            text: 'Addresses',
            link: '/contracts/exchange/v3/addresses',
          },
          {
            text: 'Technical Overview',
            collapsed: true,
            items: [
              {
                text: 'PancakeV3Factory',
                link: '/contracts/exchange/v3/pancakev3factory',
              },
              {
                text: 'PancakeV3Pool',
                link: '/contracts/exchange/v3/pancakev3pool',
              },
              {
                text: 'NonfungiblePositionManager',
                link: '/contracts/exchange/v3/nonfungiblepositionmanager',
              },
              {
                collapsed: true,
                text: 'SmartRouter',
                items: [
                  {
                    text: 'v3SwapRouter',
                    link: '/contracts/exchange/v3/smartrouterv3/v3swaprouter',
                  },
                  {
                    text: 'v2SwapRouter',
                    link: '/contracts/exchange/v3/smartrouterv3/v2swaprouter',
                  },
                  {
                    text: 'StableSwapRouter',
                    link: '/contracts/exchange/v3/smartrouterv3/stableswaprouter',
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        text: 'PancakeSwap v2',
        items: [
          {
            text: 'FactoryV2',
            link: '/contracts/exchange/v2/factory-v2',
          },
          {
            text: 'RouterV2',
            link: '/contracts/exchange/v2/router-v2',
          },
        ],
      },
      {
        text: 'StableSwap',
        items: [
          {
            text: 'Overview',
            link: '/contracts/exchange/stableswap',
          },
          {
            text: 'Pool addresses',
            link: '/contracts/exchange/stableswap/stableswap-pools',
          },
        ],
      },
      {
        text: 'Syrup Pools',
        link: '/contracts/syrup-pools',
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
        text: 'CAKE',
        items: [
          {
            text: 'MasterChef',
            items: [
              {
                text: 'v2',
                link: '/contracts/main-staking-masterchef-contract',
              },
              {
                text: 'v3',
                link: '/contracts/main-staking-masterchef-contract/masterchef-v3',
              },
            ],
          },
          {
            text: 'veCake and Gauge voting',
            link: '/contracts/vecake-and-gauge-voting',
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
        ],
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
    '/contracts-aptos': [
      {
        text: 'Exchange',
        items: [
          {
            text: 'v2',
            items: [
              {
                text: 'Overview',
                link: '/contracts-aptos/exchange/v2/overview',
              },
              {
                text: 'Technical Overview',
                collapsed: true,
                items: [
                  {
                    text: 'Core',
                    link: '/contracts-aptos/exchange/v2/swap-core-v1',
                  },
                  {
                    text: 'Router',
                    link: '/contracts-aptos/exchange/v2/router-v2',
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
