pragma solidity ^0.4.11;

library HouseholdLibrary {
	function calculateBounty(uint256 _recommendedCumulativeUsage, uint256 _userCumulativeUsage) public pure returns (uint256 bounty) {
		return _recommendedCumulativeUsage - _userCumulativeUsage;
	}

	function calculateVoucher(uint256 _bounty, uint256 _factor) public pure returns (uint256 voucher){
		return _bounty * _factor;
	}
}
