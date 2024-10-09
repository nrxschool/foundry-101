// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20} from "solady/tokens/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 amount) {
        _mint(msg.sender, amount * 1e18);
    }

    function name() public pure override returns (string memory) {
        return "My Token";
    }

    function symbol() public pure override returns (string memory) {
        return "TOKEN";
    }
}
