var Master = artifacts.require("./Master.sol");
module.exports = function(deployer) {
  deployer.deploy(Master);
};

var Node = artifacts.require("./Node.sol");
module.exports = function(deployer) {
  deployer.deploy(Node);
};
