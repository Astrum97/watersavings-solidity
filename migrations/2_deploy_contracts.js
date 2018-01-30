const HouseholdLibrary = artifacts.require('HouseholdLibrary.sol');
const HouseholdContract = artifacts.require('HouseholdContract.sol');

module.exports = function (deployer) {
	deployer.deploy(HouseholdLibrary).then(() => {
       deployer.deploy(HouseholdContract);
   });
    deployer.link(HouseholdLibrary, HouseholdContract);
};
