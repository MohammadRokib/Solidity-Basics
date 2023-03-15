// Goal of this code
// --1 Get funds from users
// --2 Withdraw funds
// --3 Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// importing the AggregatorV3Interface which we will use to get coin pricing
// same as if I had pasted the code here
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    
    uint256 minUSD = 50;
    // function to allow users to send funds
    // the payable keyword at the end is used to make function payable.
    // For this the fund function will appear red.
    // Whenever a contract is deployed it gets a contract address which is
    // similar to an wallet address. That's why both contract and wallet
    // can hold blockchain token
    // to access the value attribute we have to use the global keyword msg.value
    function fund() public payable {
        
        // setting the minimum fund to 1ETH
        // 1 ETH = 1e18 wei. values are calculated in wei in the code.
        // Thus we have to convert it if we want to use different unit
        // Error message in quote. If the condition is not met
        require(msg.value >= minUSD, "Minimum funding amount is 1ETH");

        // Whenever a require statement is used if the condition inside it is
        // not met then the transaction will be cancelled and any prior work
        // before it will be undone and it will send an error message.
    }

    // function to get the price of Ethereum or any coin we are working with
    function getPrice() public {
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
    }

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    // function to get the conversion rate of the coin we are using
    function getConversionRate() public {
        
    }

    // function withdraw() {}
}

// Chainlink Data Feeds: Powering over $50 billion in DeFi world

    // How they work:
    // Different nodes of Chainlink gets data from different exchanges and
    // data providers and brings that data through a network of decentralized
    // Chainlink nodes, the Chainlink nodes use a median to figure out what the
    // actual price of the asset is, and then deliver that in a single transaction
    // to what's called a (reference, price feed or data) contract on chain that
    // other smart contracts can use. Then those smart contracts use that pricing
    // information to power their defy application.

// Chainlink VRF: Chainlink Verifiable Randomness Function

// Chainlink Keepers: Decentralized Event-Driven Execution