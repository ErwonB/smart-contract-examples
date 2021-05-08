const Ballots = artifacts.require("Ballot");

module.exports = function (deployer) {
  deployer.deploy(Ballots, [
    "0x0000000000000000000000000000000000000000000000000000006d6168616d",
  ]);
};
