const toDo = artifacts.require("ToDo");

module.exports = function (deployer) {
  deployer.deploy(toDo);
};
