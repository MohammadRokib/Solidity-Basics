// Goal of this code
// --1 Get funds from users
// --2 Withdraw funds
// --3 Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 minUSD = 50 * 1e18;
        // minUSD is multiplied with 1e18 to match the decimal place
        // of the ETH value which is 1e18
    
    // list of funders 
    address[] public funders;

    // apping the fund address to the fund amount
    mapping(address => uint256) addToAmount;

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
        // require(getConversionRate(msg.value) >= minUSD, "Minimum funding amount is 1ETH");
            // The line above won't work since we've removed the getConversionRate function
            // and put it in the PriceConverter library. Since we're using a library now
            // similar task can be done by the line below:
        require(msg.value.getConversionRate() >= minUSD, "Insufficient fund");
            // getConversionRate(msg.value)
            // msg.value.getConversionRate()
            // these two are the same thing the only difference is first one is used
            // for functions in a contract and the second one is used for function
            // in library

            // msg.value.getConversionRate()
            // -- here msg.value is the first parameter for the getConversionRate
            // function. If another parameter had to be passed then it would be
            // written as: msg.value.getConversionRate(uint256 secondParameter)

        // Whenever a require statement is used if the condition inside it is
        // not met then the transaction will be cancelled and any prior work
        // before it will be undone and it will send an error message.

        // adding the address of the funder in a list
        funders.push(msg.sender);

        // mapping the sender address to sender's fund amount
        addToAmount[msg.sender] = msg.value;

        // msg.value ---> number of wei sent with the message
        // msg.sender --> address of the sender of the message
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