// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// importing SimpleStorage contract into this contract.
// all SimpleStorage functions can be used using variables in
// ExtraStorage contract after importing.
import "./SimpleStorage.sol";

// inheriting SimpleStorage contract into this contract.
// all SimpleStorage functions can be used directly without any variables
// of ExtraStorage contract
contract ExtraStorage is SimpleStorage {

    // overriding the store function of SimpleStorage contract.
    // in order to do that override keyword should be added
    function store(uint256 _number) public override {
        number = _number + 5;
    }
}