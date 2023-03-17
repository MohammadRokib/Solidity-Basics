// SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0;
pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        unchecked {bigNumber++;}
    }
}

// The versions of solidity before 0.8.0 were like this
    // If I were to declare a uint8 variable bigNumber. It's maximum capacity
    // is 255. Because uint8 can only hold 8 bits. And with 8 bits we can only count
    // up to 255. [also true for version 0.8.0 and after]

    // But now, if I add 1 with bigNumber it would become 256. But bigNumber can't
    // hold 256 because it is a uint8 variable.

    // So, for versions prior to 0.8.0 bigNumber would reset to its minimum value
    // which is 0. Because on those versions of solidity, unsigned integers ran on
    // the concept of being unchecked. Which is if we pass a value greater than its
    // upper limit, it would reset to its lower limit 0.

    // And for version 0.8.0 and later if we werer to add 1 with bigNumber, it
    // will give an error since bigNumber is a uint8 variable. And adding 1 will
    // make its value surpass its upper limit. Because the unsigned integers on these
    // versions runs on the concept of being checked. Which gives an error if we go
    // past the upper limit of any unsigned integer.
    // And if we want use the unchecked beavior on version 0.8.0 or later we just have
    // to use the keyword unchecked.

// Resetting issue or the unchecked behavior on versions prior to 0.8.0 were resolved
// by the library named SafeMath.