// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Vault {
    address public owner;
    string private password;

    error Unauthorized();

    constructor(string memory pwd) {
        owner = msg.sender;
        password = pwd;
    }

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert Unauthorized();
        }
        _;
    }

    function set(string calldata pwd) external onlyOwner {
        password = pwd;
    }

    function get() external view onlyOwner returns (string memory) {
        return password;
    }
}

