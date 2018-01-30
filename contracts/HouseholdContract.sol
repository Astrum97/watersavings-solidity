pragma solidity ^0.4.11;

import "./HouseholdLibrary.sol";

//contract_name.new().then(function(res) { sc = contract_name.at(res.address) }) //tik die lyntji in truffle console om die adres te kry dan sc.xxxxxx kan methods execute

contract HouseholdContract {

	//credits/bounty van water gespaar
	mapping (address => uint256) bounty;
	//id number van persoon
	mapping (address => string) id;
	//hoeveelheid die huishouding al gebruik het
	mapping (address => uint256) cumulativeUsage;

	mapping (address => uint256) previousPurchase;

	mapping (address => uint256) price;

	/**
	* TODO: add stuff
	**/
	function HouseholdContract() public {
		price[msg.sender] = 100;
	}

	/*
	* Called hourly or daily to update water _usage
	**/
	function addWaterUsage(uint256 _usage) public returns (uint256) {
		cumulativeUsage[msg.sender] = _usage;
		return cumulativeUsage[msg.sender];
	}

	/**
	* the cumulative water usage resets every month or when the user pays
	**/
	function resetWaterUsage() public returns (uint256) {
		cumulativeUsage[msg.sender] = 0;
		//resets the Pi.... --assumption
		return cumulativeUsage[msg.sender];
	}

	/*
	* Called once a month, but updated regularly offchain
	* calculate _recommendedCumulativeUsage from frontend
	* Pay totals price and convert remainder to bounty
	*/
	function pay(uint256 _recommendedCumulativeUsage, uint256 _bountyFactor) public returns (uint256 voucher, uint256 amount) {
		uint256 voucher2 = 0;
		if (_recommendedCumulativeUsage > cumulativeUsage[msg.sender]) {
			bounty[msg.sender] += HouseholdLibrary.calculateBounty(_recommendedCumulativeUsage, cumulativeUsage[msg.sender]);
			voucher2 = HouseholdLibrary.calculateVoucher(bounty[msg.sender], _bountyFactor);
		}
		else
			price[msg.sender] += 50;
		uint256 amount2 = cumulativeUsage[msg.sender] * price[msg.sender];
		resetWaterUsage();
		return (voucher2, amount2 / 100);
	}

	/*
	* add function to use voucher to lower water price
	**/


	function getWaterUsage() public view returns (uint256 usage) {
		return cumulativeUsage[msg.sender];
	}

	function getBounty() public view returns (uint256 bountyp) {
		return bounty[msg.sender];
	}
}
