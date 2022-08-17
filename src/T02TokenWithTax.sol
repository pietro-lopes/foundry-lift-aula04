// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract T02TokenWithTax is ERC20 {
    constructor() ERC20("Tarefa 02 Lift", "LFTX") {
        _mint(msg.sender, 1_000_000 * 10**decimals());
    }

    uint256 public constant TAX = 5;

    function decimals() public view virtual override returns (uint8) {
        return 9;
    }

    function transfer(address to, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        address owner = _msgSender();
        uint256 taxAmount = (amount * TAX) / 100;
        uint256 newAmount = amount - taxAmount;
        _transfer(owner, to, newAmount);
        _burn(owner, taxAmount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        uint256 taxAmount = (amount * TAX) / 100;
        uint256 newAmount = amount - taxAmount;
        _transfer(from, to, newAmount);
        _burn(from, taxAmount);
        return true;
    }
}
