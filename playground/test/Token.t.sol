// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    address alice = address(0xaaa);
    address bob = address(0xbbb);
    Token token;

    function setUp() public {
        vm.label(alice, "ALICE");
        vm.label(bob, "BOB");

        vm.prank(alice);
        token = new Token(1_000_000);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 * 1e18);
        assertLe(token.totalSupply(), 1_000_000 * 1e18);
        assertGt(token.totalSupply(), 0);
        assertNotEq(token.totalSupply(), 0);
    }

    function testInitialAliceBalance() public {
        assertEq(token.balanceOf(alice), 1_000_000 * 1e18);
    }

    function testTransfer() public {
        vm.prank(alice);
        token.transfer(bob, 100 * 1e18);

        assertEq(token.balanceOf(bob), 100 * 1e18);
    }

    function testTransferFail() public {
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 2_000_000 * 1e18);
    }

    function testName() public {
        assertEq(token.name(), "My Token");
    }

    function testSymbol() public {
        assertEq(token.symbol(), "TOKEN");
    }
}
