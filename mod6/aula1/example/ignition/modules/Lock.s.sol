// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../../contracts/Lock.sol";

contract Deploy is Script {
    function run() external {
        uint256 ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
        uint256 unlockTime = block.timestamp + ONE_YEAR_IN_SECS;

        vm.startBroadcast();
        new Lock(unlockTime);
        vm.stopBroadcast();
    }
}