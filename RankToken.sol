pragma solidity ^0.4.23;

import './ERC20Files/MintableToken.sol';


contract RankToken is MintableToken {
    
    uint256 public constant decimals = 18;
    
    
    struct Score{
        int256 score;
        string description;
    }
    
    
    mapping(address => mapping(bytes32 => Score)) rankings;
    
    function () payable {
        mint(msg.sender); 

    }
    
    
    constructor(){
        _totalSupply = 10000*10**decimals;
        _cumulativeSupply = 10000*10**decimals;
        balances[owner] = 10000*10**decimals;
        cost = 0.00001 ether;
    }
    
    function safeChange(uint256 amount) returns (uint256){
        return (amount*_cumulativeSupply)/(_totalSupply*10**18);
        
    }

    
    function changeScore(address addr,bytes32 index, uint256 amount, bool down){
        require(balances[msg.sender] >= amount);
        require(amount >= (_totalSupply*10**decimals)/_cumulativeSupply);
        balances[msg.sender] -= amount;
        _totalSupply -= amount;
        
        if(down){rankings[addr][index].score -= int(safeChange(amount));}
        else{rankings[addr][index].score += int(safeChange(amount));}
        
    }
    
    function getScore(bytes32 index) returns (int256){
        return rankings[msg.sender][index].score;
    }
    
    function withdrawFunds(address _to) onlyOwner{
        _to.transfer(this.balance);
    }
    
    
}
