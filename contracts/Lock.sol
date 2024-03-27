// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {FloorToken, ILBFactory} from "@traderjoe-xyz/floor-token/src/FloorToken.sol";
import {TransferTripleTaxToken} from "@traderjoe-xyz/floor-token/src/TransferTripleTaxToken.sol";
import {ERC20, IERC20} from "@traderjoe-xyz/floor-token/src/TransferTaxToken.sol";

contract MyLotusFork is FloorToken, TransferTripleTaxToken {
    constructor(
        string memory name,
        string memory symbol,
        address owner,
        IERC20 tokenY,
        ILBFactory lbFactory,
        uint24 activeId,
        uint16 binStep,
        uint256 tokenPerBin
    )
        FloorToken(tokenY, lbFactory, activeId, binStep, tokenPerBin)
        TransferTripleTaxToken(name, symbol, owner)
    {}

    function totalSupply()
        public
        view
        override(ERC20, FloorToken)
        returns (uint256)
    {
        return ERC20.totalSupply();
    }

    function balanceOf(
        address account
    ) public view override(FloorToken, ERC20) returns (uint256) {
        return ERC20.balanceOf(account);
    }

    function mint(
        address account,
        uint256 amount
    ) internal override(FloorToken) {
        ERC20._update(address(0), account, amount);
    }

    function burn(
        address account,
        uint256 amount
    ) internal override(FloorToken) {
        ERC20._update(account, address(0), amount);
    }

    function beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        FloorToken._beforeTokenTransfer(from, to, amount);
    }
}
