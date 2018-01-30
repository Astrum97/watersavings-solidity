var HouseholdContract = artifacts.require('./HouseholdContract.sol');

contract('HouseholdContract', function(accounts) {
  let contract;
  const parent = accounts[0];

  before(async function(){
    contract = await HouseholdContract.deployed();
  });

  it("HouseholdContract contract is deployed.", async function() {
    assert(contract);
  });

  

});
