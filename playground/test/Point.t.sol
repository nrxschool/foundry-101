// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";

event Vector(uint256 indexed module);

event Point(uint256 indexed x, uint256 indexed y, uint256 indexed z);

event Called();

contract Cartesian {
    function makePoint(uint256 x, uint256 y, uint256 z) public {
        emit Point(x, y, z);
    }

    function makeVector(uint256 x, uint256 y, uint256 z) public {
        uint256 m = x ** 2 + y ** 2 + z ** 2;
        emit Vector(m);
    }

    function call() public {
        emit Called();
    }
}

contract CartesianB {
    function makeVector(uint256 x, uint256 y, uint256 z) public {
        uint256 m = x ** 2 + y ** 2 + z ** 2;
        emit Vector(m);
    }
}

contract CartesianTest is Test {
    Cartesian cartesian;
    CartesianB b;

    function setUp() public {
        cartesian = new Cartesian();
        b = new CartesianB();
    }

    function testEmitEventSimple() public {
        vm.expectEmit();
        emit Called();

        cartesian.call();
    }

    function testEmitEventTopics() public {
        vm.expectEmit(true, false, false, false);
        emit Point(1, 0, 0);

        cartesian.makePoint(1, 2, 3);
    }

    function testFailEmitEventEmmiter() public {
        vm.expectEmit(true, false, false, false, address(cartesian));
        emit Vector(14);

        b.makeVector(1, 2, 3);
   }
}
