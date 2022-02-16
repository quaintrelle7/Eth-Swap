// SPDX-License: MIT
pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
    //name, token are the state variables becuase what data is stored in them is stored on the blockchain

    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint256 public rate = 100;

    event TokenPurchased(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );

    event TokenSold(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );

    constructor(Token _token) public {
        //_token is a local variable

        token = _token;
    }

    function buyTokens() public payable {
        //Redemption0 rate = No .of tokens they recieve for one token
        //Amount of Eths * Redemption rate
        // Calculate No. of tokens to buy
        uint256 tokenAmount = msg.value * rate;

        require((token.balanceOf(address(this)) >= tokenAmount));

        token.transfer(msg.sender, tokenAmount);

        //emit an event -- Triggering an event
        emit TokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens(uint256 _amount) public {
        // User can't sell more tokens than they have
        require(token.balanceOf(msg.sender) >= _amount);

        //Calculate amount of ether to redeem
        uint256 etherAmount = _amount / rate;

        require(address(this).balance >= etherAmount);
        token.transferFrom(msg.sender, address(this), _amount);
        //Perform Sale
        msg.sender.transfer(etherAmount);
        emit TokenSold(msg.sender, address(token), _amount, rate);
    }
}
