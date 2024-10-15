// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {Lock} from "../contracts/Lock.sol";

contract LockTest is Test {
    address alice = address(0xaaa);
    address bob = address(0xbbb);
    Lock lock;
    uint256 constant JAN_1ST_2030 = 1893456000;

    function setUp() public {
        vm.label(alice, "ALICE");
        vm.label(bob, "BOB");

        vm.deal(alice, 2 ether);

        vm.prank(alice);
        lock = new Lock{value: 1 ether}(JAN_1ST_2030);
    }

    function testDeployment() public view {
        assertEq(lock.unlockTime(), JAN_1ST_2030, "Unlock time should be set correctly");
        assertEq(lock.owner(), alice, "Owner should be set correctly");
    }

    function testReceiveFunds() public view {
        assertEq(address(lock).balance, 1 ether, "Contract should hold the locked amount");
    }

    function testRevertUnlockTimeInPast() public {
        uint256 pastUnlockTime = block.timestamp - 1;
        vm.prank(alice);
        vm.expectRevert("Unlock time should be in the future");
        lock = new Lock{value: 1 ether}(pastUnlockTime);
    }

    function testWithdrawTooSoon() public {
        vm.prank(alice);
        vm.expectRevert("You can't withdraw yet");
        lock.withdraw();
    }

    function testWithdrawNotOwner() public {
        vm.warp(JAN_1ST_2030);
        vm.prank(bob);
        vm.expectRevert("You aren't the owner");
        lock.withdraw();
    }

    function testWithdrawSuccess() public {
        // Fast forward time to unlock time
        vm.warp(JAN_1ST_2030);

        vm.prank(alice);
        lock.withdraw();
        assertEq(address(lock).balance, 0, "Contract balance should be zero after withdrawal");
    }

    function testEmitWithdrawalEvent() public {
        vm.warp(JAN_1ST_2030 + 1);
        vm.prank(alice);
        vm.expectEmit(address(lock));
        emit Lock.Withdrawal(1 ether, block.timestamp);
        lock.withdraw();
    }

    function testTransferFundsToOwner() public {
        // Fast forward time to unlock time
        vm.warp(JAN_1ST_2030);
        uint256 initialBalance = alice.balance;

        vm.prank(alice);
        lock.withdraw();
        assertEq(alice.balance, initialBalance + 1 ether, "Owner should receive the locked funds");
    }
}
