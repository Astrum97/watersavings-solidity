pragma solidity ^0.4.11;

import "./HouseholdLibrary.sol";

/*
 * Zander Labuschagne se baie werk volg Hier
 * 23585137@protonmail.ch | zander.labuschagne@protonmail.ch
 * Hierdie kode word gepubliseer onder die BSD-3 nuwe of hersiende lisensie
 */

//HouseHoldContract.new().then(function(res) { sc = HouseHoldContract.at(res.address) }) //tik die lyntji in truffle console om die adres te kry dan sc.xxxxxx kan methods execute

contract HouseholdContract {

	//credits/bounty van water gespaar
	mapping (address => uint256) bounty;
	//id number van persoon
	mapping (address => string) id;
	//hoeveelheid die huishouding al gebruik het
	mapping (address => uint256) cumulativeUsage;

	mapping (address => uint256) price;

	uint8 private litre_price;

	function HouseholdContract() {
		setLitrePrice(1);
		setInitPrice();
	}

	/*
	 * To change the R/litre if desired
	**/
	function setLitrePrice(uint8 _litre_price) public returns (uint8 r_litre_price) {
		litre_price = _litre_price;
		return litre_price;
	}

	/*
	 * Set the SA ID number to link the contract instance to the person responsible for the HouseHoldContract
	**/
	function setId(string _id) public returns (string r_id) {
		id[msg.sender] = _id;
		return id[msg.sender];
	}

	/*
	 * Assign the default price of water to the contract instance
	**/
	function setInitPrice() public {
		price[msg.sender] = litre_price;
	}

	/*
	* Called hourly or daily to update water _usage
	* Called from water metre
	**/
	function addWaterUsage(uint256 _usage) public returns (uint256 usage) {
		cumulativeUsage[msg.sender] = _usage;
		return cumulativeUsage[msg.sender];
	}

	/**
	* the cumulative water usage resets every month or when the user pays
	**/
	function resetWaterUsage() public returns (uint256 usage) {
		cumulativeUsage[msg.sender] = 0;
		//resets the Pi.... --assumption
		return cumulativeUsage[msg.sender];
	}

	/*
	* calculate _recommendedCumulativeUsage from frontend
	* Pay totals price and convert remainder to bounty and return voucher as well
	*/
	function pay(uint256 _recommendedCumulativeUsage, uint256 _bountyFactor) public returns (uint256 r_voucher, uint256 r_amount) {
		uint256 voucher = 0;
		if (_recommendedCumulativeUsage >= cumulativeUsage[msg.sender]) {
			bounty[msg.sender] += HouseholdLibrary.calculateBounty(_recommendedCumulativeUsage, cumulativeUsage[msg.sender]);
			voucher = HouseholdLibrary.calculateVoucher(bounty[msg.sender], _bountyFactor);
			bounty[msg.sender] = 0;
		}
		else
			price[msg.sender] += HouseholdLibrary.increasePrice(cumulativeUsage[msg.sender], _recommendedCumulativeUsage, litre_price);
		uint256 amount = HouseholdLibrary.calculateOutstandingBalance(cumulativeUsage[msg.sender], price[msg.sender], 0);
		resetWaterUsage();
		return (voucher, HouseholdLibrary.centToRand(amount));
	}

	function getOutstandingBalance(uint256 _recommendedCumulativeUsage) view returns (uint256 balance) {
		return HouseholdLibrary.calculateOutstandingBalance(cumulativeUsage[msg.sender], price[msg.sender], HouseholdLibrary.increasePenaltyFactor(cumulativeUsage[msg.sender], _recommendedCumulativeUsage, litre_price));
	}

	/*
	* function to lower price if it is high by paying much more tha n usual price
	**/
	function lowerPrice(uint256 _factor) public returns (uint256 r_price) {
		if (price[msg.sender] > litre_price) {
			price[msg.sender] -= _factor;
		}

		return price[msg.sender];
	}

	/*
	 * If one wants to preview the amount to be paid in order to lower the price/litre if it were raised due to increasePenaltyFactor
	**/
	function getLowerPriceReq() public view returns (uint256 amount) {
		return HouseholdLibrary.lowerPriceReq(price[msg.sender], litre_price);
	}

	/*
	 * Get current water usage for personal interests
	**/
	function getWaterUsage() public view returns (uint256 usage) {
		return cumulativeUsage[msg.sender];
	}

	/*
	 * Get the current bounty for testing purposes
	**/
	function getBounty() public view returns (uint256 r_bounty) {
		return bounty[msg.sender];
	}
}
