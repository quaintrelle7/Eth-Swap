// Artifacts is like Javascript Version of Smart Contract
// Same like making migration DB but here in Truffle

const Migrations = artifacts.require("Migrations");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
