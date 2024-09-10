import React, { useState } from 'react';
import { Address, TransactionBuilder, Value } from '@emurgo/cardano-serialization-lib-browser'; // Import specific modules

const RealEstateTokenization = () => {
  const [address, setAddress] = useState('');

  // Connect to Cardano wallet
  const connectWallet = async () => {
    try {
      const wallet = await window.cardano.enable(); // Connect to Cardano wallet (like Nami)
      const networkId = await wallet.getNetworkId(); // Get network ID (1 for mainnet, 0 for testnet)
      const address = await wallet.getChangeAddress(); // Get change address
      setAddress(address);
    } catch (error) {
      console.error('Error connecting to wallet:', error);
    }
  };

  
  return (
    <div>
      <h1>Real Estate Tokenization</h1>
      <button onClick={connectWallet}>Connect Wallet</button>
      {address && <p>Connected to: {address}</p>}
    </div>
  );
};

export default RealEstateTokenization;
