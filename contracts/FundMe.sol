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
        require(getConversionRate(msg.value) >= minUSD, "Minimum funding amount is 1ETH");

        // Whenever a require statement is used if the condition inside it is
        // not met then the transaction will be cancelled and any prior work
        // before it will be undone and it will send an error message.

        // adding the address of the funder in a list
        funders.push(msg.sender);

        // mapping the sender address to sender's fund amount
        addToAmount[msg.sender] = msg.value;
    }

    // function to get the price of Ethereum or any coin we are working with
    function getPrice() public view returns(uint256) {
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

    function getVersion() public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    // function to get the conversion rate of the coin we are using
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethUSD = (ethPrice * ethAmount) / 1e18;
        return ethUSD;
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