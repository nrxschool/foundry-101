// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {console2} from "forge-std/console2.sol";
import {Script} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract Deploy is Script {
    address[] public clients;
    uint256 public amount = 100 * 1e18;

    function setUp() public {
        clients = [
            0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f,
            0x70997970C51812dc3A010C7d01b50e0d17dc79C8,
            0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC,
            0x90F79bf6EB2c4f870365E785982E1f101E93b906,
            0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65
        ];
    }

    function run() external {
        vm.startBroadcast(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );

        Token token = new Token(1_000_000 * 1e18);

        token.transfer(clients[0], amount);
        token.transfer(clients[1], amount);
        token.transfer(clients[2], amount);
        token.transfer(clients[3], amount);
        token.transfer(clients[4], amount);

        console2.log("Balance of client 0 is:", token.balanceOf(clients[0]));
        console2.log("Balance of client 1 is:", token.balanceOf(clients[1]));
        console2.log("Balance of client 2 is:", token.balanceOf(clients[2]));
        console2.log("Balance of client 3 is:", token.balanceOf(clients[3]));
        console2.log("Balance of client 4 is:", token.balanceOf(clients[4]));

        vm.stopBroadcast();
    }
}
