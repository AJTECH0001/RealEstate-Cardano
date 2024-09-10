# Real Estate Tokenization Platform
This project is a decentralized platform for tokenizing real estate properties on the Cardano blockchain. It enables fractional ownership of real estate assets by representing them as Cardano native tokens. The platform leverages Plutus smart contracts for secure token minting and trading, while users can interact with the system through a web-based frontend built with React.

## Features

Tokenization of Real Estate: Convert real estate properties into tradable Cardano native tokens.
Fractional Ownership: Allows multiple users to own fractions of a property through tokens.
Secure Transactions: Utilizes Plutus smart contracts for secure token minting and transfer.
Wallet Integration: Connect to Cardano wallets (e.g., Nami) for seamless interaction.
Plutus and Cardano Integration: Leverages Plutus for on-chain logic and @emurgo/cardano-serialization-lib-browser for off-chain transactions.

## Tech Stack
Frontend: React, TypeScript
Smart Contracts: Plutus (Haskell)
Blockchain: Cardano
Libraries:
```
@emurgo/cardano-serialization-lib-browser
```
Plutus tools

## Getting Started

### Prerequisites
Node.js (v14 or higher)
npm or yarn
A Cardano wallet (e.g., yoroi)
Plutus development environment (for compiling and deploying smart contracts)

### Setting up Plutus Smart Contracts:

Navigate to your Plutus directory and compile the Haskell/Plutus smart contracts. Ensure the contract is deployed on the Cardano blockchain. Once deployed, obtain the contract's address to interact with it in the frontend.

### Connecting to a Wallet
To interact with the Cardano blockchain, you’ll need to connect a wallet like yoroi:

Click the "Connect Wallet" button.
Approve the connection in your wallet extension.
Once connected, you can view your wallet's address and initiate transactions.

### Minting Property Tokens
After connecting your wallet, click the "Mint Property Token" button.
This will create a transaction that mints a native token representing ownership of a real estate property.

### Smart Contracts
The Plutus smart contract handles the tokenization of real estate properties. It is written in Haskell and deployed on the Cardano blockchain. The key components are:

Property Data Type: Represents a real estate property with an ID, owner, and value.
Minting Policy: Enforces the minting rules for the property tokens.

```
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}

module RealEstate where

import PlutusTx.Prelude
import Plutus.Contract
import Ledger
import Ledger.Constraints as Constraints
import PlutusTx
import Prelude (String)

data Property = Property
  { propertyId :: Integer
  , owner :: PubKeyHash
  , value :: Integer
  }

mkToken :: Property -> Contract w s Text ()
mkToken property = do
    let tokenName = "PropertyToken-" <> (show $ propertyId property)
        mintingPolicy = Constraints.mustMintValue $ Value.singleton "" tokenName 1
        ownerAddress = Ledger.pubKeyHashAddress $ owner property
    submitTxConstraintsWith @Void mintingPolicy Constraints.empty
    logInfo @String $ "Minted token for property: " <> tokenName
```

### Future Improvements
Property Marketplace: Add a marketplace where users can buy, sell, and trade property tokens.
Fractional Ownership Trading: Allow users to trade fractions of ownership in real-time.
DeFi Integration: Integrate decentralized finance (DeFi) options like collateralizing property tokens.