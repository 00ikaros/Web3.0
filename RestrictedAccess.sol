// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RestrictedAccess {
    address public owner = msg.sender;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}
