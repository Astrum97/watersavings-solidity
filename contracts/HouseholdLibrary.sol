pragma solidity ^0.4.11;

library HouseholdLibrary {
	function calculateBounty(uint256 _recommendedCumulativeUsage, uint256 _userCumulativeUsage) public pure returns (uint256 bounty) {
		return _recommendedCumulativeUsage - _userCumulativeUsage;
	}

	function calculateVoucher(uint256 _bounty, uint256 _factor) public pure returns (uint256 voucher){
		return _bounty * _factor;
	}

	function increasePrice(uint256 _usage, _recommendedUsage) public pure returns (uint256 newPrice) {
		return 1 * (_usage - _recommendedUsage);
	}

	/*function getAmountToPay(uint256 _usage, uint256 _price) public pure returns (uint256 amount) {
		return _usage * _price;
	}*/

	function centToRand(uint256 _cents) public pure returns (uint256 rands) {
		return _cents / 100;
	}

	function increasePenaltyFactor(uint256 _usage, uint256 _recommendedUsage) public pure returns (uint256 factor) {
		if(_recommendedUsage < _usage)
			return 1 * (_usage - _recommendedUsage);
		else
			return 0;
	}

	function calculateOutstandingBalance(uint256 _usage, uint256 _price, uint256 _factor) public pure returns (uint256 amount) {
		return centToRand(_usage * (_price + _factor));
	}

	function lowerPriceReq(uint256 _price) public pure returns (uint256 price){
		return centToRand((_price - 1) * 3000);
	}
}
