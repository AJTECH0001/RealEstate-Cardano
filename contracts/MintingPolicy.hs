-- Minting script for fractional ownership tokens
mkMintingPolicy :: TxOutRef -> ScriptContext -> Bool
mkMintingPolicy oref ctx = True -- Simplified logic for minting

policy :: Scripts.MintingPolicy
policy = mkMintingPolicyScript $$(PlutusTx.compile [|| mkMintingPolicy ||])

mint :: Property -> Integer -> Contract w s Text ()
mint property fraction = do
  let value = Value.singleton "PropertyToken" (show $ propertyId property) fraction
  submitTxConstraintsWith @Void policy (mustMintValue value)
  logInfo @String "Minted fractional tokens"
