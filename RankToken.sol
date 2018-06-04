pragma solidity ^0.4.18;

import './MintableToken.sol';


contract RankToken is MintableToken {
    
    uint256 public constant decimals = 18;
    
    
    struct Score{
        int256 score;
        string description;
    }
    
    
    mapping(address => mapping(uint256 => Score)) rankings;
    
    function () payable {
        if(cost > 0) { mint(msg.sender); }
        else{
            balances[msg.sender].add(10000*10**decimals); 
            totalSupply = totalSupply.add(10000*10**decimals);
        }
    }
    
    
    function RankToken(){
        totalSupply = 10000*10**decimals;
        cumulativeSupply = 10000*10**decimals;
        balances[owner] = 10000*10**decimals;
        cost = 0.00001 ether;
    }
    
    function safeChange(uint256 amount) returns (uint256){
        return (amount*cumulativeSupply)/(totalSupply*10**18);
        
    }

    
    function changeScore(address addr, uint256 amount, bool down){
        require(balances[msg.sender] >= amount);
        require(amount >= (totalSupply*10**decimals)/cumulativeSupply);
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        
        if(down){rankings[addr][0].score -= int(safeChange(amount));}
        else{rankings[addr][0].score += int(safeChange(amount));}
        
    }
    
    function getScore(uint index) returns (int256){
        return rankings[msg.sender][index].score;
    }
    
    function withdrawFunds(address _to) onlyOwner{
        _to.transfer(this.balance);
    }
    
    
}