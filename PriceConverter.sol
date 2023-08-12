// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    //get the Price of ETH in USD
    function getPrice() internal view returns(uint256){
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    //convert the ETH in USD
    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPriceInUsd = getPrice();
        uint256 ethAmountInUsd = (ethPriceInUsd * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}