pragma ^0.4.11;

import './IERC20.sol';

contract Token is ERC20{
	uint256 public constant _totalSupply = 1000000; //TODO: replace 1000000 value with predetermined value of number of households
	//hoeveelheid die huishouding al gebruik het
	//address van block/Token
	//elke huishouding/meter bevat een token
	//id number van persoon
	//credits/bounty van spaar

	function totalSupply() constant returns (uint256 totalSupply) {

	}
}
