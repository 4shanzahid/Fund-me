// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

//custom erros to save gas
error NotEnoughUSD();
error CallFailed();
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 constant MINIMUM_USD =5e18;

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    //setting the owner of the contract 
    constructor() {
        i_owner = msg.sender; //as we are making the transction by deploying the contract
    }

    //send money to the contract
    function fund() public payable {

        //Cannot send less than 5$
         if (msg.value.getConversionRate() < MINIMUM_USD) {
            revert NotEnoughUSD();
        }
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    //withdraw all money
    function withdraw() public onlyOwner {

        //use for loop to set total amount to 0
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        //rest the funders array to 0
        funders = new address[](0);

        //transfer all funds to you wallet
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        if (!callSuccess) {
            revert CallFailed();
        }
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }        
        _; //execute the rest of the code in the function
    }

    //if someone doesnot use fund() to send ETH
    receive() external payable {
        fund();
    } 

    fallback() external payable {
        fund();
    }
}