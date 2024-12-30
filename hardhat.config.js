require("@nomicfoundation/hardhat-toolbox");
require("hardhat-tracer");

//require("@nomiclabs/hardhat-etherscan");
//require("@nomiclabs/hardhat-waffle");
//require("@nomiclabs/hardhat-solhint");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.7",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
    networks: {
      hardhat: {
        timeout: 0,
        initialBaseFeePerGas: 0,
        forking: {
          enabled: true,
          url: "https://eth-mainnet.alchemyapi.io/v2/ATNwBnRSug_WEQgInYn9W4PLANPCpOgT",
          timeout: 0,
        },
      }
    }
  },
};
