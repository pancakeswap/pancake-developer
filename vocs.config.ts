import { defineConfig } from "vocs";
import { theme } from "./theme";

export default defineConfig({
  title: "PancakeSwap Developer",
  description: "Your DEX Your Innovation",
  logoUrl: {
    light: "/logo.svg",
    dark: "/logo_dark.svg",
  },
  ogImageUrl:
    "https://vocs.dev/api/og?logo=%logo&title=%title&description=%description",

  titleTemplate: "%s | PancakeSwap Developer",
  topNav: [
    { text: "EVM", link: "/contracts/infinity/overview" },
    { text: "Aptos", link: "/contracts-aptos" },
    { text: "APIs", link: "/apis/subgraph" },
    { text: "Bug Bounty", link: "/bug-bounty" },
  ],
  sidebar: {
    "/contracts": [
      {
        text: "PancakeSwap Infinity",
        items: [
          {
            text: "Overview",
            link: "/contracts/infinity/overview",
            items: [
              {
                text: "Accounting Layer - Vault",
                link: "/contracts/infinity/overview/accounting-layer-vault",
              },
              {
                text: "AMM Layer - Pool Manager",
                link: "/contracts/infinity/overview/amm-layer-poolmanager",
                items: [
                  {
                    text: "Concentrated Liquidity",
                    link: "/contracts/infinity/overview/amm-layer/concentrated-liquidity",
                  },
                  {
                    text: "Liquidity Book",
                    link: "/contracts/infinity/overview/amm-layer/liquidity-book",
                  },
                ],
              },
              {
                text: "Custom Layer - Hook",
                link: "/contracts/infinity/overview/custom-layer-hook",
              },
              {
                text: "Farms",
                link: "/contracts/infinity/overview/farms",
              },
            ],
          },
          {
            text: "Guides",
            items: [
              {
                text: "Developing a hook",
                link: "/contracts/infinity/guides/develop-a-hook",
                collapsed: true,
                items: [
                  {
                    text: "Taking a fee via Hook",
                    link: "/contracts/infinity/guides/hook-examples/taking-fee-via-hook",
                  },
                  {
                    text: "Overwriting AMM curve",
                    link: "/contracts/infinity/guides/hook-examples/overwriting-amm-curve",
                  },
                ],
              },
              {
                text: "Manage Liquidity",
                link: "/contracts/infinity/guides/manage-liquidity",
              },
              {
                text: "Perform a swap",
                link: "/contracts/infinity/guides/perform-a-swap",
              },
            ],
          },
          {
            text: "Resources",
            collapsed: true,
            items: [
              {
                text: "Github",
                link: "/contracts/infinity/resources/github",
              },
              {
                text: "Addresses",
                link: "/contracts/infinity/resources/addresses",
              },
            ],
          },
          {
            text: "FAQ",
            collapsed: true,
            link: "/contracts/infinity/faq",
            items: [
              {
                text: "PancakeSwap Infinity vs Uniswap v4",
                link: "/contracts/infinity/faq/pancakeswap-infinity-vs-uniswap-v4",
              },
            ],
          },
        ],
      },
      {
        text: "PancakeSwap v3",
        items: [
          {
            text: "Addresses",
            link: "/contracts/v3/addresses",
          },
          {
            text: "Github",
            link: "/contracts/v3/github",
          },
          {
            text: "Technical Overview",
            collapsed: true,
            items: [
              {
                text: "PancakeV3Factory",
                link: "/contracts/v3/pancakev3factory",
              },
              {
                text: "PancakeV3Pool",
                link: "/contracts/v3/pancakev3pool",
              },
              {
                text: "NonfungiblePositionManager",
                link: "/contracts/v3/nonfungiblepositionmanager",
              },
              {
                collapsed: true,
                text: "SmartRouter",
                link: "/contracts/v3/smartrouter",
                items: [
                  {
                    text: "v3SwapRouter",
                    link: "/contracts/v3/smartrouter/v3swaprouter",
                  },
                  {
                    text: "v2SwapRouter",
                    link: "/contracts/v3/smartrouter/v2swaprouter",
                  },
                  {
                    text: "StableSwapRouter",
                    link: "/contracts/v3/smartrouter/stableswaprouter",
                  },
                ],
              },
            ],
          },
          {
            text: "FAQ",
            link: "/contracts/v3/faq",
          },
        ],
      },
      {
        text: "PancakeSwap v2",
        items: [
          {
            text: "Addresses",
            link: "/contracts/v2/addresses",
          },
          {
            text: "Github",
            link: "/contracts/v2/github",
          },
          {
            text: "Technical Overview",
            collapsed: true,
            items: [
              {
                text: "FactoryV2",
                link: "/contracts/v2/factory-v2",
              },
              {
                text: "RouterV2",
                link: "/contracts/v2/router-v2",
              },
            ],
          },
          {
            text: "FAQ",
            link: "/contracts/v2/faq",
          },
        ],
      },
      {
        text: "",
        items: [
          {
            text: "Prediction",
            collapsed: true,
            items: [
              { text: "Overview", link: "/contracts/prediction" },
              {
                text: "Address",
                link: "/contracts/prediction/addresses",
              },
              {
                text: "How to bet and claim",
                link: "/contracts/prediction/how-to-bet-and-claim",
              },
              {
                text: "FAQ",
                link: "/contracts/prediction/faq",
              },
            ],
          },
          {
            text: "Pancake Gifts",
            link: "/contracts/pancake-gifts/addresses",
          },
          {
            text: "Crosschain",
            link: "/contracts/crosschain/addresses",
          },
          {
            text: "Universal Router",
            link: "/contracts/universal-router/addresses",
          },
          {
            text: "Permit2",
            collapsed: true,
            items: [
              {
                text: "Overview",
                link: "/contracts/permit2",
              },
              {
                text: "Addresses",
                link: "/contracts/permit2/addresses",
              },
              {
                text: "How to revoke permit2 approval",
                link: "/contracts/permit2/how-to-revoke-permit2-approval",
              },
            ],
          },
          {
            text: "PancakeSwap X",
            collapsed: true,
            items: [
              {
                text: "Addresses",
                link: "/contracts/pcsx/addresses",
              },
              {
                text: "Github",
                link: "/contracts/pcsx/github",
              },
            ],
          },
          {
            text: "StableSwap",
            collapsed: true,
            items: [
              {
                text: "Overview",
                link: "/contracts/stableswap/overview",
              },
              {
                text: "Pool addresses",
                link: "/contracts/stableswap/stableswap-pools",
              },
            ],
          },
          {
            text: "MasterChef",
            collapsed: true,
            items: [
              {
                text: "Addresses",
                link: "/contracts/masterchef/addresses",
              },
              {
                text: "v3",
                link: "/contracts/masterchef/masterchef-v3",
              },
            ],
          },
          {
            text: "Syrup Pools",
            link: "/contracts/syrup-pools",
          },
          {
            text: "Cake",
            collapsed: true,
            items: [
              {
                text: "Addresses",
                link: "/contracts/cake",
              },
              {
                text: "Cross Chain CAKE Bridging",
                link: "/contracts/cake/cross-chain-cake-bridging",
              },
            ],
          },
          {
            text: "IFO",
            link: "/contracts/ifo",
          },
          {
            text: "Lottery",
            collapsed: true,
            items: [
              { text: "Overview", link: "/contracts/lottery-v2" },
              {
                text: "Contract",
                link: "/contracts/lottery-v2/lottery-contract",
              },
            ],
          },
        ],
      },

      {
        text: "Deprecated",
        items: [
          {
            text: "veCake and Gauge voting",
            link: "/contracts/vecake-and-gauge-voting",
          },
          {
            text: "CAKE Syrup Pool",
            link: "/contracts/fixed-term-staking-cake-pool",
          },
          {
            text: "Farm Booster (bCAKE)",
            link: "/contracts/farm-booster-bcake",
          },
          {
            text: "Market Maker Pool",
            link: "/contracts/market-maker-pool",
          },
          {
            text: "NFT Market",
            link: "/contracts/nft-market",
          },
          {
            text: "Affiliate Program",
            link: "/contracts/affiliate-program/overview",
          },
        ],
      },
    ],
    "/contracts-aptos": [
      {
        text: "PancakeSwap v2",
        items: [
          {
            text: "v2",
            items: [
              {
                text: "Overview",
                link: "/contracts-aptos/v2/overview",
              },
              {
                text: "Technical Overview",
                collapsed: true,
                items: [
                  {
                    text: "Core",
                    link: "/contracts-aptos/v2/swap-core-v2",
                  },
                  {
                    text: "Router",
                    link: "/contracts-aptos/v2/router-v2",
                  },
                ],
              },
            ],
          },
        ],
      },
      {
        text: "MasterChef",
        link: "/contracts-aptos/masterchef",
      },
      {
        text: "Syrup Pools",
        link: "/contracts-aptos/syrup-pools",
      },
      {
        text: "IFO",
        link: "/contracts-aptos/ifo",
      },
      {
        text: "Utils",
        link: "/contracts-aptos/utils",
      },
    ],
  },
  theme,
});
