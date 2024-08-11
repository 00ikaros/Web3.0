// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLottery {
    address[] public players;

    function enter() public payable {
        require(msg.value > .01 ether, "Not enough ether to enter");
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickWinner() public {
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
    }
}