require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-web3");
require("@nomicfoundation/hardhat-toolbox");

const ALCHEMY_API_KEY = "y92VpodAvAezj4yVjMKx8tSW4zw4od8i";

const SEPOLIA_PRIVATE_KEY = 
"7f83e7ff3fd64783267942ae953d574f0f0acb013a51daf64df340aee840125b";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  }
};
