const Migrations = artifacts.require("DIR_contract");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
