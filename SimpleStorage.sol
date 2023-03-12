// How to select the version of solidity

// pragma solidity 0.8.7; // using exactly 0.807
// pragma solidity ^0.8.7 // using any version of 0.8 from 0.8.7 to above
// pragma solidity >=0.8.7 <0.9.0 // using from 0.8.7 - 0.8.9

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    uint256 public number;
    struct People{
        string name;
        uint256 number;
    }

    People[] public person;
    mapping(string => uint256) public nameToNum;

    function store(uint256 _number) public {
        number = _number;
        // number = number + 1;
    }

    function retrieve() public view returns(uint256) {
        return number;
    }

    function addPerson(string memory _name, uint256 num) public {
        // method-1 for storing people [by creating a new People type variable]
        
            // creating new person --1
            // People memory newPerson = People({name: _name, number: num});
            // person.push(newPerson); // pushing the variable
            // person.push(People({name: _name, number: num})); // pushing directly

            // creating new person --2
            // People memory newPerson = People(_name, num);
            // person.push(newPerson); // pushing the variable
        
        // method-2 for storing pe ople [pushing directly]
        person.push(People(_name, num));
        nameToNum[_name] = num;
    }
}

// calldata -> temporary variables that can't be modified
// memory -> temporary variables that can be modified
// storage -> permanent variables that can be modified

// Data locations (calldata, memory, storage) can only be specified for
// array, struct or mapping. String is an array