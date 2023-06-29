// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Demo {
    event Played(bool result, string user, string bot);

    uint public checker;

    modifier isCorrect(bytes32 user) {
        if (user == keccak256(abi.encodePacked("paper"))) {
            _;
        }
        if (user == keccak256(abi.encodePacked("scissors"))) {
            _;
        }
        if (user == keccak256(abi.encodePacked("stone"))) {
            _;
        }
    }

    mapping (address => bytes32) commits;
    string[3] ways = ["paper", "scissors", "stone"];

    function commitVote(bytes32 hashedVote) external isCorrect(hashedVote) 
{
        commits[msg.sender] = hashedVote;
    }

    function revealVote(address vote) external {
        bytes32 commit = keccak256(abi.encodePacked(vote, msg.sender));
        require(commit == commits[msg.sender]);

        string memory bot = ways[random()];
        if (keccak256(abi.encodePacked(bot)) == 
keccak256(abi.encodePacked("paper"))) {
            if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("stone"))) {
                emit Played(false, "stone", "paper");
            } else {
                if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("scissors"))) {
                    emit Played(true, "scissors", "paper");
                } else {
                    emit Played(true, "paper", "paper");
                }
            }
        }
        if (keccak256(abi.encodePacked(bot)) == 
keccak256(abi.encodePacked("stone"))) {
            if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("stone"))) {
                emit Played(true, "stone", "stone");
            } else {
                if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("scissors"))) {
                    emit Played(false, "scissors", "stone");
                } else {
                    emit Played(true, "paper", "stone");
                }
            }
        } else {
            if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("stone"))) {
                emit Played(true, "stone", "scissors");
            } else {
                if (keccak256(abi.encodePacked(vote)) == 
keccak256(abi.encodePacked("scissors"))) {
                    emit Played(true, "scissors", "scissors");
                } else {
                    emit Played(false, "paper", "scissors");
                }
            }
        }

        delete commits[msg.sender];
    }

    uint public counter = 1;
    function random() public returns (uint rand) {
        counter++;
        checker = uint(keccak256(abi.encodePacked(block.timestamp, 
msg.sender, counter))) % 3;
        rand = checker;
    }
}
