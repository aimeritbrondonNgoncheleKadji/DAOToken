const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKey = "private";
const polygonTestnetRpcUrl = "https://damp-weathered-owl.matic-testnet.discover.quiknode.pro/a5a7e19bda74323c64f890f3ee596ff2fa88a82b/";


module.exports = {

  networks: {
    polygon: {
      provider: () => new HDWalletProvider(privateKey, 'https://rpc-mainnet.maticvigil.com/'),
      network_id: 137, // ID du réseau Polygon Mainnet
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    mumbai: {
      provider: () => new HDWalletProvider(privateKey, 'https://rpc-mumbai.maticvigil.com/'),
      network_id: 80001, // ID du réseau Polygon Mumbai Testnet
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    bsctestnet: {
      provider: () => new HDWalletProvider(privateKey, 'https://data-seed-prebsc-1-s1.binance.org:8545/'),
      network_id: 97,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
  },
  compilers: {
    solc: {
      version: "0.8.4",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    },
  },

};