const express = require('express');
const { TransactionBuilder } = require('@emurgo/cardano-serialization-lib-nodejs');

const app = express();

app.post('/mint-tokens', async (req, res) => {
  const { propertyId, fraction } = req.body;
  // Logic to mint tokens using Cardano Serialization Library
  const txBuilder = new TransactionBuilder();
  // Mint logic
  res.json({ status: 'success' });
});

app.listen(3000, () => console.log('Server running on port 3000'));
