pragma solidity ^0.4.11;

import "./HouseholdLibrary.sol";

//contract_name.new().then(function(res) { sc = contract_name.at(res.address) }) //tik die lyntji in truffle console om die adres te kry dan sc.xxxxxx kan methods execute

contract HouseholdContract{

	//credits/bounty van water gespaar
	mapping (address => uint256) bounty;
	//id number van persoon
	mapping (address => string) id;
	//hoeveelheid die huishouding al gebruik het
	mapping (address => uint256) cumulativeUsage;

	/**
	* TODO: add stuff
	**/
	function HouseholdContract() {

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
		return cumulativeUsage[msg.sender];
	}

	/*
	* Called once a month, but updated regularly offchain
	* calculate _recommendedCumulativeUsage from frontend
	* Pay totals price and convert remainder to bounty
	*/
	function getBounty(uint256 _recommendedCumulativeUsage, uint256 _bountyFactor) view returns (uint256 voucher) {
		bounty[msg.sender] = HouseholdLibrary.calculateBounty(_recommendedCumulativeUsage, cumulativeUsage[msg.sender]);
		resetWaterUsage();
		return HouseholdLibrary.calculateVoucher(bounty[msg.sender], _bountyFactor);
	}
}
