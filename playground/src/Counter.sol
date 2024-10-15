// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint256 count;

    function incc() external {
        count++;
    }

    function set(uint256 number) external {
        count = number;
    }

    function get() external view returns (uint256) {
        return count;
    }
}
