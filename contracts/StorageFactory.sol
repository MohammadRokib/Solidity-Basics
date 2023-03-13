// contract SimpleStorage will be imported in this contract.
// We will be able to interact with the SimpleStorage contract. This is an
// essential part working with solidity and working with smart contract.

// The ability of smart contracts to interact with each other is called
// composability.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// importing SimpleStorage. Similar to if we were to paste whole SimpleStorage
// code here.
import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageAra;

    // function which will create new SimpleStorage contracts
    function createSimpleStorage() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageAra.push(simpleStorage);
    }

    // function to access store function of SimpleStorage contract sotred
    // in simpleStorageAra
    function sfStore(uint256 ssIndex, uint256 ssNumber) public {
        // Address:
        // In order to interact with a contract we need the address of the contract

        // ABI - Application Binary Interface:
        // It tells the code how it can interact with the contract. It basically
        // tells the code about all the different inputs and ouputs that can be done
        // with the contract

        // creating a variable (sStorage) of type (SimpleStorage)
        // it will store the contract stored at the index (ssIndex)
        // in the array (simpleStorageAra)
        SimpleStorage sStorage = simpleStorageAra[ssIndex];

        // accessing the store function of the contract stored in
        // variable (sStorage)
        sStorage.store(ssNumber);

        // line 39 and 43 can be replaced by line 46 and will do the same thing
        // simpleStorageAra[ssIndex].store(ssNumber);
    }

    // function to read the number stored in SimpleStorage contract, which is stored
    // inside simpleStorageAra
    function sfGet(uint256 ssIndex) public view returns(uint256) {
        
        // creating a variable (sStorage) of type (SimpleStorage)
        // it will store the SimpleStorage contract stored at the index (ssIndex)
        // in the array (simpleStorageAra)
        SimpleStorage sStorage = simpleStorageAra[ssIndex];

        // accessing the retrieve function inside SimpleStorage contract
        // which is sotred in the simpleStorageAra
        return sStorage.retrieve();

        // line 53 and 57 can be replaced by line 60 and will do the same thing
        // return simpleStorageAra[ssIndex].retrieve();
    }
}

