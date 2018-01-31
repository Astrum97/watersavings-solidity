var HouseholdContract = artifacts.require("./HouseholdContract.sol");
var HouseholdLibrary = artifacts.require("./HouseholdLibrary.sol");

module.exports = function (deployer) {
	deployer.deploy(HouseholdLibrary).then(() => {
        return deployer.deploy(HouseholdContract);
    });
    deployer.link(HouseholdLibrary, HouseholdContract);
};
