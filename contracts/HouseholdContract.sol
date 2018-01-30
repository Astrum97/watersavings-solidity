pragma solidity ^0.4.11;

import "./HouseholdLibrary.sol";

/*
 * Zander Labuschagne se baie werk volg Hier
 * 23585137@protonmail.ch | zander.labuschagne@protonmail.ch
 * Hierdie kode word gepubliseer onder die GNU GPL weergawe 2 lisensie
 */

//contract_name.new().then(function(res) { sc = contract_name.at(res.address) }) //tik die lyntji in truffle console om die adres te kry dan sc.xxxxxx kan methods execute

contract HouseholdContract{

	//credits/bounty van water gespaar
	mapping (address => uint256) bounty;
	//id number van persoon
	mapping (address => string) id;
	//hoeveelheid die huishouding al gebruik het
	mapping (address => uint256) cumulativeUsage;

	mapping (address => uint256) price;

	uint8 litre_price;

	/**
	* TODO: add stuff
	**/
	function HouseholdContract() {
		setLitrePrice(1);
		setInitPrice();
	}

	function setLitrePrice(uint8 _litre_price) public returns (uint8 r_litre_price) {
		litre_price = _litre_price;
		return litre_price;
	}

	function setId(string _id) public returns (string r_id) {
		id[msg.sender] = _id;
		return id[msg.sender];
	}

	function setInitPrice() public {
		price[msg.sender] = litre_price;
	}

	/*
	* Called hourly or daily to update water _usage
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
	* Called once a month, but updated regularly offchain
	* calculate _recommendedCumulativeUsage from frontend
	* Pay totals price and convert remainder to bounty
	*/
	function pay(uint256 _recommendedCumulativeUsage, uint256 _bountyFactor) public returns (uint256 r_voucher, uint256 r_amount) {
		uint256 voucher = 0;
		if(_recommendedCumulativeUsage >= cumulativeUsage[msg.sender]) {
			bounty[msg.sender] += HouseholdLibrary.calculateBounty(_recommendedCumulativeUsage, cumulativeUsage[msg.sender]);
			voucher = HouseholdLibrary.calculateVoucher(bounty[msg.sender], _bountyFactor);
		}
		else
			price[msg.sender] += HouseholdLibrary.increasePrice(cumulativeUsage[msg.sender], _recommendedCumulativeUsage, litre_price);
		uint256 amount = HouseholdLibrary.calculateOutstandingBalance(cumulativeUsage[msg.sender], price[msg.sender], 0);
		resetWaterUsage();
		return (voucher, HouseholdLibrary.centToRand(amount));
	}

	function getOutstandingBalance(uint256 _recommendedCumulativeUsage) returns (uint256 balance) {
		return HouseholdLibrary.calculateOutstandingBalance(cumulativeUsage[msg.sender], price[msg.sender], HouseholdLibrary.increasePenaltyFactor(cumulativeUsage[msg.sender], _recommendedCumulativeUsage, litre_price));
	}

	/*
	* function to lower price if it is high
	**/
	function lowerPrice(uint256 _factor) public returns (uint256 r_price) {
		if(price[msg.sender] > litre_price) {
			price[msg.sender] -= _factor;
		}

		return price[msg.sender];
	}

	function getLowerPriceReq() public view returns (uint256 amount) {
		return HouseholdLibrary.lowerPriceReq(price[msg.sender], litre_price);
	}

	function getWaterUsage() public view returns (uint256 usage) {
		return cumulativeUsage[msg.sender];
	}

	function getBounty() public view returns (uint256 r_bounty) {
		return bounty[msg.sender];
	}
}
