// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "../test/vyper/VyperDeploy.sol";

interface IVoting {
    function vote(address) external returns (bool);

    function voted(address) external returns (bool);

    function candidate(address) external returns (uint256);
}

contract Deploy is Script {
    VyperDeployer deployer;
    IVoting voting;

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function run() external {
        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
