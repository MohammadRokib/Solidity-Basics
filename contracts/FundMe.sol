// Goal of this code
// --1 Get funds from users
// --2 Withdraw funds
// --3 Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public minUSD = 50 * 1e18;
        // minUSD is multiplied with 1e18 to match the decimal place
        // of the ETH value which is 1e18
    
    // list of funders 
    address[] public funders;
    address public owner;

    // apping the fund address to the fund amount
    mapping(address => uint256) public addToAmount;

    // A constructor is called immidiately after the contract is deployed
    // With this constructor we are setting up who the owner of the contract is
    // The owner of the contract will be the who deploys the contract
    constructor() {
        owner = msg.sender;
    }


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
        addToAmount[msg.sender] += msg.value;

        // msg.value ---> number of wei sent with the message
        // msg.sender --> address of the sender of the message
    }

    // function to withdraw the funded money
    function withdraw() public onlyOwner {

        // This will make sure that the withdraw function can only be used by the owner
        // require(msg.sender == owner, "Administrator only");

        // resetting the fund amount of every funder in funders list/array
        for (uint256 i = 0; i < funders.length; i++) {
            // accessing the address of the ith funder
            address funder = funders[i];

            // making the address amount 0 of the ith funder
            addToAmount[funder] = 0;
        }
        // even if we reset the fund amount of the funders, their addresses are still
        // there in the funders list/array

        // resetting the funders array
        funders = new address[](0);
        // will delete all the addresses of the funders from the funders array

        // to actually withdraw the fund have to be sent which can be done in 3 ways:
            
            // transfer: throws an error and reverts the transaction if it wasn't successful
            // payable(msg.sender).transfer(address(this).balance);
            // it says transer the balance of the address. where the address refers
            // to this (the contract we are in) contract.
            // we're using the payable keyword because only the payable function/address
            // can send funds.          msg.sender  = address
            //                  payable(msg.sender) = payable address


            // send: returns true if the transaction was successfull and false if not.
            //       but the contract wouldn't be reverted.
            // bool transactionStatus = payable(msg.sender).send(address(this).balance);
            // require(transactionStatus, "Transaction Failed"); // making sure that incomplete
                                                              // transactions are reverted.
            
            // call: a low level command
            // demo command of call
            //      (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
            // we just need the bool callSuccess so we will type:
            (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
            require(callSuccess, "Transaction Failed"); // to revert the transaction if failed
            // the recommended way of sending or receiving blockchain tokens is call.
    }

    // With the modifier we can use whatever method is given in it in any function.
    // we just have to add the name of the modifier at the end of the function declaration.
    modifier onlyOwner {
        require(msg.sender == owner, "Administrator only");
        _; // this represents the code in the function.

        // Here the first line is the method which we can use any function.
        // The second line represents the code in that function

        // So, these two line means that where ever we are going to use this modifier
        // first the require method will execute then the code in the function will execute.

        // If we want to execute the methods in the function first then the method
        // in the modifier then the code will be like this:
            // _;
            // require(msg.sender == owner, "Administrator only");
    }
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


