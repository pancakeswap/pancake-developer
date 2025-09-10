---
description: Prediction 
---

# Prediction

**Prediction** is a decentralized prediction market platform built on BSC (Binance Smart Chain) that allows users to bet on the price movements of major cryptocurrencies including BNB, ETH, and BTC. 

The platform operates through a series of prediction rounds where users can place "Bull" (up) or "Bear" (down) bets on whether the price of the selected asset will increase or decrease.


## Supported Assets
The platform supports predictions on three major cryptocurrencies:
- BNB (Binance Coin): Native BSC token
- ETH (Ethereum): Ethereum token
- BTC (Bitcoin): Bitcoin token

Each asset has its own separate prediction contract instance with dedicated Chainlink oracle feeds.


## How It Works

### Prediction Rounds
Duration: Each prediction round lasts 5 minutes (300 seconds) 

Three Phases:
1. Betting Phase: Users can place bets during the first 5 minutes
2. Lock Phase: Betting stop for the round, fetch price from chainlink oracle
3. Close Phase: Final price is determined after another 5 minutes

### Betting Mechanism
Users can place two types of bets:
- Bull (Up): Betting that the price will be higher at the end of the round
- Bear (Down): Betting that the price will be lower at the end of the round

### Payout 

Your payout is based on **proportional distribution** among winners:

- **If You Win:** You share the total pot with other winners (minus 3% fee)
- **If You Lose:** You lose your entire bet amount

**Special Cases:**
- **Tie**: If lock price = close price, house wins all bets
- **Oracle Failure**: All users get refunded


### Example

**Round 800: BNB Price Prediction**

1. **Place Bet**: You bet **Bull** (price will go up) with **0.1 BNB**

2. **Lock Phase**: After 5 minutes, BNB price locks at **850 USD per BNB**

3. **Close Phase**: After another 5 minutes, BNB price closes at **860 USD per BNB**

4. **Result**: 860 > 850, so **Bull wins!** 🎉

