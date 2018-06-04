pragma solidity ^0.4.23;


import './StandardToken.sol';
import './Ownable.sol';
import './SafeMath.sol';


/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */

contract MintableToken is StandardToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event MintPaused();

  bool public mintingPaused = false;
  uint cost = 0.00001 ether;
  

  modifier canMint() {
    require(!mintingPaused);
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.

   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to) canMint payable public returns (bool) {
    require(msg.value >= cost);
    uint _amount = (msg.value*_totalSupply*10**18)/(cost*_cumulativeSupply);
    _totalSupply = _totalSupply.add(_amount);
    _cumulativeSupply = _cumulativeSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function pauseMinting() onlyOwner public returns (bool) {
    mintingPaused = true;
    emit MintPaused();
    return true;
  }
}
