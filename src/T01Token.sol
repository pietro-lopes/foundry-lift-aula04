// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract T01Token is ERC20 {
    constructor() ERC20("Tarefa 01 Lift", "LFT") {
        // Mintando 1 milhão de tokens para nosso owner
        _mint(msg.sender, 1_000_000 * 10**decimals());
    }

    // Alguns tokens adotam decimal 9 em vez de 18
    // Vamos colocar 9 no nosso
    function decimals() public view virtual override returns (uint8) {
        return 9;
    }
}
