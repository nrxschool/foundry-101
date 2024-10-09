// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Cofre {
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

contract B is Cofre {
    constructor() Cofre("123") {}

    function getB() external view returns (address) {
        return owner;
    }

    function getB2() external view returns (string memory) {
        return "123";
    }

}
