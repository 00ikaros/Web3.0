// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(bytes32 => uint) public votesReceived;

    bytes32[] public candidateList;

    // Constructor to initialize candidates
    constructor(bytes32[] memory candidateNames) {
        candidateList = candidateNames;
    }

    // Vote for a candidate
    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate), "Not a valid candidate.");
        require(!hasVoted[msg.sender], "Already voted.");
        
        votesReceived[candidate] += 1;
        hasVoted[msg.sender] = true;
    }

    // Check if the candidate is valid
    function validCandidate(bytes32 candidate) view public returns(bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }

    // Get the total votes for a candidate
    function totalVotesFor(bytes32 candidate) view public returns(uint) {
        require(validCandidate(candidate), "Not a valid candidate.");
        return votesReceived[candidate];
    }
}
