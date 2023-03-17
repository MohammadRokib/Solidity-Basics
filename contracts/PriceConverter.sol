// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// importing the AggregatorV3Interface which we will use to get coin pricing
// same as if I had pasted the code here
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// libraries can't have state varibales and they can't send ether.
library PriceConverter {

    // function to get the price of Ethereum or any coin we are working with
    function getPrice() internal view returns(uint256) {
        // we will get the price of the coin using chainlink data feeds.
        // there is a contract named AggregatorV3Interface which does this for us.
        // there is a function inside it named getLatestPrice. and inside that
        // function there is a variable named "int price" which has the value.

        // this AggregatorV3Interface contract is outside of our project. so to
        // interact with the contract we need two things of the contract:
        // --1 ABI

        // --2 Address
            // [https://docs.chain.link/data-feeds/price-feeds/addresses/]
            // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e for Goerli testnet ETH/USD
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (, int price,,,) = priceFeed.latestRoundData();
        // the above line will return price of ETH in terms of USD
        // the price will be something like this 3000_00000000

        return uint256(price*1e10);
        // the ETH value will be like this ------------> 1_000000000000000000
        // the price we got is ---------------------> 3000_00000000
        // multiplying price with 1e10 (10^10) -----> 3000_000000000000000000
        // to make the decimal place of
        // the price similar to ETH we're

    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    // function to get the conversion rate of the coin we are using
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethUSD = (ethPrice * ethAmount) / 1e18;
        return ethUSD;
    }

}