pragma ^0.4.11;

import './IERC20.sol';

contract Token is ERC20{
	uint256 public constant _totalTokens = 1000000; // TODO: replace 1000000 value with predetermined value of number of households
	//address van block/Token
	//address _tokenAddress;//TODO: implisiet?
	//elke huishouding/meter bevat een token

	//die household/mense in huis moet dalk front end wees?
	//mapping(address => uint256) people;
	mapping (address => uint256) balances;
	//credits/bounty van water gespaar
	mapping (address => uint256) bounty;
	//id number van persoon
	mapping (address => string) id;
	//hoeveelheid die huishouding al gebruik het
	mapping (address => uint256) cumulativeUsage;

	function Token() {
		balances[msg.sender] = _totalTokens;
	}

	function totalTokens() constant returns (uint256 totalTokens) {
		return _totalTokens;
	}

/*
TODO: weet nie regtig of die reg is nie?
	function addNewToken(string _pid) returns (uint256 totalTokens) {
		_totalTokens++;
		return _totalTokens;
	}*/

	/*function transfer(address _to, uint256 _value) returns (bool success) {
		require(
			balances[msg.sender] >= _value
			&& _value > 0;
			);
		balances[msg.sender] -= _value;
		balances[_to] += _value;
		Transfer(msg.sender, _to, _value);
		return true;
	}

	/*
	* Called hourly to update water _usage
	**/
	function addWaterUsage(uint256 _usage, address _user) returns (uint256 cumulativeUsage) {
		cumulativeUsage[_user] = _usage;
		return cumulativeUsage[_user];
	}

	/*
	* Called once a month
	* Pay totals price and convert remainder to bounty
	*/
	function calculateBounty() returns (uint256 voucher) {

	}
}
