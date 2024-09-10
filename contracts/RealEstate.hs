{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}

module RealEstate where

import           PlutusTx.Prelude
import           Plutus.Contract
import           Ledger
import           Ledger.Constraints as Constraints
import           PlutusTx
import           Prelude (String)

-- Data type to represent real estate property
data Property = Property
  { propertyId :: Integer
  , owner :: PubKeyHash
  , value :: Integer -- Property value in ADA
  }

-- Tokenize the property as native Cardano tokens
mkToken :: Property -> Contract w s Text ()
mkToken property = do
    let tokenName = "PropertyToken-" <> (show $ propertyId property)
        mintingPolicy = Constraints.mustMintValue $ Value.singleton "" tokenName 1
        o wnerAddress = Ledger.pubKeyHashAddress $ owner property
    submitTxConstraintsWith @Void mintingPolicy Constraints.empty
    logInfo @String $ "Minted token for property: " <> tokenName
