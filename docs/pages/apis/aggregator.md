---
description: Integrate with the PancakeSwap Aggregator API to get optimal swap quotes and execute token swaps.
---

# Aggregator API — Integration Guide

This guide explains how to integrate with the PancakeSwap Aggregator API to get optimal swap quotes and execute token swaps on supported chains.

## Overview

The Aggregator API helps you:

- **Get a quote** — Find the best swap route across multiple DEXs and pool types (V2, V3, Stable).
- **Get calldata** — Turn that quote into transaction data you can send on-chain.
- **Execute** — Submit the transaction to the blockchain using the returned `value`, `calldata`, and `to` (router address).

Supported networks: **Ethereum** (`chainId: 1`) and **Base** (`chainId: 8453`).

---

## Base URL and authentication

| Environment | Base URL |
| --- | --- |
| Production | `https://hub-gateway.pancakeswap.com` |

### Required headers

| Header | Value | Description |
| --- | --- | --- |
| `x-secure-token` | `<your-secret-token>` | Your API token (obtain from PancakeSwap). |
| `Content-Type` | `application/json` | Required for `POST /v1/calldata` only. |

---

## Integration flow

```
┌─────────────┐    GET /v2/quote     ┌─────────────┐    POST /v1/calldata   ┌─────────────┐
│   Client    │ ──────────────────► │  Aggregator │ ────────────────────► │   Client    │
│             │  (chainId, src,     │     API     │  (quote + recipient,   │             │
│             │   dst, amountIn)    │             │   slippageTolerance)   │             │
└─────────────┘                     └─────────────┘                        └─────────────┘
       │                                    │                                      │
       │◄───────────────────────────────────┼──────────────────────────────────────┘
       │         Quote (routes, amounts)    │
       │         Calldata (value, calldata, to)
       ▼
  Send transaction to chain (to = router, data = calldata, value = value)
```

1. Call `GET /v2/quote` with token addresses and amount as query parameters.
2. Call `POST /v1/calldata` with the quote response plus `recipient` and `slippageTolerance`.
3. Send a transaction to the returned `to` address with `calldata` as `data` and `value` as the native token value (e.g. BNB).

---

## Step 1: Get a quote

**Endpoint:** `GET /v2/quote`

Get the best swap route and expected output amount for a given input.

### Query parameters

| Parameter | Type | Required | Description |
| --- | --- | --- | --- |
| `chainId` | number | Yes | Chain ID. Supported: **1** (Ethereum), **8453** (Base). |
| `src` | string | Yes | Source token contract address. Use `0x0000000000000000000000000000000000000000` for the chain's native token (ETH). |
| `dst` | string | Yes | Destination token contract address. Use the zero address for native token. |
| `amountIn` | string | Yes | Input amount in **wei** (smallest unit). Example: `"1000000000000000000"` for 1 token with 18 decimals. |
| `gasPrice` | string | No | Gas price in wei for route optimization. Omit to use current network gas price. |
| `maxHops` | string | No | Max hops in a route. Default: `"2"`. Min: 1, Max: 4. |
| `maxSplits` | string | No | Max route splits. Default: `"2"`. Min: 1, Max: 4. |

### Example request

```bash
curl -G "https://hub-gateway.pancakeswap.com/v2/quote" \
  -H "x-secure-token: YOUR_SECRET_TOKEN" \
  --data-urlencode "chainId=1" \
  --data-urlencode "src=0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2" \
  --data-urlencode "dst=0xdAC17F958D2ee523a2206206994597C13D831ec7" \
  --data-urlencode "amountIn=1000000000000000000" \
  --data-urlencode "maxHops=2" \
  --data-urlencode "maxSplits=2"
```

### Success response (200)

:::info
If the response contains an `error` object, treat it as a failed quote — see [Error handling](#error-handling).
:::

| Field | Type | Description |
| --- | --- | --- |
| `srcToken` | object | Source token info (address, decimals, symbol, name, chainId). |
| `dstToken` | object | Destination token info. |
| `fromAmount` | string | Input amount in wei. |
| `dstAmount` | string | Expected output amount in wei. |
| `protocols` | array | Route(s) with path, pools, and per-route amounts. |
| `gas` | number | Estimated gas (gas units). Multiply by gas price in wei for cost. |

### Example response

```json
{
  "srcToken": {
    "address": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
    "decimals": 18,
    "symbol": "WETH",
    "name": "Wrapped Ether",
    "chainId": 1
  },
  "dstToken": {
    "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
    "decimals": 6,
    "symbol": "USDT",
    "name": "Tether USD",
    "chainId": 1
  },
  "fromAmount": "1000000000000000000",
  "dstAmount": "3192936412525193112600",
  "protocols": [
    {
      "percent": 55,
      "path": ["..."],
      "pools": ["..."],
      "inputAmount": "550000000000000000",
      "outputAmount": "1755948085078420231919"
    },
    {
      "percent": 45,
      "path": ["..."],
      "pools": ["..."],
      "inputAmount": "450000000000000000",
      "outputAmount": "1436988327446772880681"
    }
  ],
  "gas": 306000
}
```

Use this entire response as the base for the `/calldata` request in Step 2.

---

## Step 2: Get calldata

**Endpoint:** `POST /v1/calldata`

Convert a quote into transaction parameters: `value`, `calldata`, and router address `to`.

### Request body

Send the full JSON object returned from `/quote`, and add:

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| *(all quote fields)* | — | Yes | Include `srcToken`, `dstToken`, `fromAmount`, `dstAmount`, `protocols`, and `gas` from the quote response. |
| `recipient` | string | Yes | Address that will receive the output tokens. Use the user's wallet address. |
| `slippageTolerance` | number | Yes | Allowed price movement: **0–1** (e.g. `0.05` = 5%). |

### Example request

```bash
curl -X POST "https://hub-gateway.pancakeswap.com/v1/calldata" \
  -H "Content-Type: application/json" \
  -H "x-secure-token: YOUR_SECRET_TOKEN" \
  -d '{
    "srcToken": { "address": "0x0000000000000000000000000000000000000000", "decimals": 18, "symbol": "ETH", "name": "Ether", "chainId": 1 },
    "dstToken": { "address": "0xdAC17F958D2ee523a2206206994597C13D831ec7", "decimals": 6, "symbol": "USDT", "name": "Tether USD", "chainId": 1 },
    "fromAmount": "1000000000000000000",
    "dstAmount": "3192936412525",
    "protocols": ["..."],
    "gas": 248000,
    "recipient": "0x9D24d495F7380BA80dC114D8C2cF1a54a68e25A4",
    "slippageTolerance": 0.005
  }'
```

### Success response (200)

| Field | Type | Description |
| --- | --- | --- |
| `value` | string | Amount of **native token (ETH)** to send in hex. Use `"0x0"` or `"0x00"` when swapping ERC-20 only. |
| `calldata` | string | Hex-encoded calldata for the router. |
| `to` | string | **Router contract address** — send the transaction to this address. |

### Example response

```json
{
  "value": "0x00",
  "calldata": "0x9aa90356...",
  "to": "0x..."
}
```

---

## Step 3: Execute the swap

Using the `/calldata` response:

1. **To:** use the `to` field (router contract).
2. **Data:** use the `calldata` field.
3. **Value:** use the `value` field (BNB to send; use `0` for ERC-20-only swaps).
4. **Gas:** use the `gas` from the quote as a limit; add a small buffer if desired.

```javascript
const tx = {
  to: calldataResponse.to,         // Router address from /calldata
  data: calldataResponse.calldata, // Hex calldata from /calldata
  value: calldataResponse.value,   // BigInt or hex (BNB amount; 0n for ERC-20 only)
  gasLimit: quoteResponse.gas * 120n / 100n  // 20% buffer
};
const hash = await wallet.sendTransaction(tx);
```

:::note
**ERC-20 input:** The user must approve the router (`to` address) to spend the source token before sending this transaction.

**Native token (ETH) input:** Ensure `value` matches the intended ETH amount.
:::

---

## Error handling

### Quote errors (in response body)

When no route is found or something fails, the API may still return `200` with an `error` object in the JSON:

```json
{
  "error": {
    "statusCode": "ASM-5002",
    "message": "No route found",
    "error": "Quote failed"
  }
}
```

Always check for `response.error` and treat it as a failed quote. Do not pass such a response to `/calldata`.

### Error codes

| Code | Meaning |
| --- | --- |
| `ASM-4001` | Invalid input (validation failed). |
| `ASM-4002` | Invalid liquidity provider. |
| `ASM-4003` | Invalid pool type. |
| `ASM-5000` | Server error. |
| `ASM-5001` | Not found. |
| `ASM-5002` | Swap route not found. |
| `ASM-5003` | Quote not found. |
| `ASM-5004` | Tick spacing not found for fee config. |
| `ASM-5005` | Chain not found. |
| `ASM-5006` | Subgraph provider not found. |
| `ASM-5007` | V2 candidate pool not found. |
| `ASM-5008` | V3 candidate pool not found. |
| `ASM-5009` | On-chain provider not found. |

### HTTP status codes

| Code | Meaning |
| --- | --- |
| `400` | Bad request — validation error or calldata generation failed. |
| `429` | Too many requests — rate limit hit. Retry after the indicated time. |
| `5xx` | Server error — retry with exponential backoff. |

Validation error example:

```json
{
  "statusCode": 400,
  "message": "recipient is required",
  "error": "Validation failed"
}
```
