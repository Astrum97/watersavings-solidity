<<<<<<< HEAD
const HouseholdLibrary = artifacts.require('HouseholdLibrary.sol');
const HouseholdContract = artifacts.require('HouseholdContract.sol');

module.exports = function (deployer) {
	deployer.deploy(HouseholdLibrary).then(() => {
       deployer.deploy(HouseholdContract);
   });
    deployer.link(HouseholdLibrary, HouseholdContract);
};
=======
var Master = artifacts.require("./Master.sol");
module.exports = function(deployer) {
  deployer.deploy(Master);
};

var Node = artifacts.require("./Node.sol");
module.exports = function(deployer) {
  deployer.deploy(Node);
};
>>>>>>> develop
