// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WithdrawalContract {
    address public richest;
    uint public mostSent;

    receive() external payable {
        require(msg.value > mostSent, "There is already a higher contribution");

        if (richest != address(0)) {
            payable(richest).transfer(mostSent);
        }
        richest = msg.sender;
        mostSent = msg.value;
    }

    function withdraw() public {
        require(msg.sender == richest, "Only the current leader can withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }
}
