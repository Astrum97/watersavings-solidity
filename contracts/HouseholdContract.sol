pragma solidity ^0.4.11;

import "./HouseholdLibrary.sol";

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
	function addWaterUsage(uint256 _usage, address _user) public returns (uint256) {
		cumulativeUsage[_user] = _usage;
		return cumulativeUsage[_user];
	}

	/**
	* the cumulative water usage resets every month or when the user pays
	**/
	function resetWaterUsage(address _user) public returns (uint256) {
		cumulativeUsage[_user] = 0;
		return cumulativeUsage[_user];
	}

	/*
	* Called once a month, but updated regularly offchain
	* calculate _recommendedCumulativeUsage from frontend
	* Pay totals price and convert remainder to bounty
	*/
	function getBounty(uint256 _recommendedCumulativeUsage, address _user, uint256 _bountyFactor) view returns (uint256 voucher) {
		bounty[_user] = HouseholdLibrary.calculateBounty(_recommendedCumulativeUsage, cumulativeUsage[_user]);
		resetWaterUsage(_user);
		return HouseholdLibrary.calculateVoucher(bounty[_user], _bountyFactor);
	}
}
