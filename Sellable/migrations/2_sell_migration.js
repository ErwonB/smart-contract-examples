const Migrations = artifacts.require("Sellable");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
