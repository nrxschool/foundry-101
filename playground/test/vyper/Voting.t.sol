// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VyperDeployer} from "./VyperDeploy.sol";

interface IVoting {
    function vote(address) external returns (bool);

    function voted(address) external returns (bool);

    function candidate(address) external returns (uint256);
}

contract VotingTest is VyperDeployer {
    VyperDeployer deployer;
    IVoting voting;
    address alice = address(0xaAaAaAaaAaAaAaaAaAAAAAAAAaaaAaAaAaaAaaAa);
    address bob = address(0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB);

    function setUp() public {
        deployer = new VyperDeployer();
        voting = IVoting(deployer.deployContract("Voting"));
    }

    function testVote() public {
        vm.prank(alice);
        voting.vote(alice);

        assertEq(voting.candidate(alice), 1);
        assertEq(voting.voted(alice), true);
    }

    function testVoteTwice() public {
        voting.vote(alice);

        vm.expectRevert("You have already voted.");
        voting.vote(alice);
    }

    function testFuzz_Vote(address _candidate) public {
        vm.assume(_candidate != address(0));

        vm.prank(alice);
        bool result = voting.vote(_candidate);
        assertTrue(result, "Voting should succeed.");

        assertTrue(voting.voted(alice), "Voter should be marked as having voted.");
        assertEq(voting.candidate(_candidate), 1, "Candidate should have one vote.");

        vm.prank(alice);
        vm.expectRevert("You have already voted.");
        voting.vote(_candidate);
    }
}
