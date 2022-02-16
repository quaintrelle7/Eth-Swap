// Takes a small contract and put them on Blockchain
// Artifacts is like Javascript Version of Smart Contract

const Token = artifacts.require("Token");
const EthSwap = artifacts.require("EthSwap");

//  Can use await keyword only when you are in async

module.exports = async function (deployer) {

    await deployer.deploy(Token);
    const token = await Token.deployed()

    await deployer.deploy(EthSwap, token.address);
    const ethSwap = await EthSwap.deployed()

    //Transfer all token to EthSwap 1 Mn
    await token.transfer(ethSwap.address, '1000000000000000000000000')

};
