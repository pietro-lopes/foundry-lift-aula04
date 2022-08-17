// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract T03TokenOwner is ERC20 {
    constructor() ERC20("Tarefa 03 Lift", "LFTO") {
        // Mintando 1 milhão de moedas para o dono
        _mint(msg.sender, 1_000_000 * 10**decimals());
        // Definindo o dono como o msg.sender
        owner = msg.sender;
    }

    // Iniciando a variável para modificação pelo constructor acima
    address public owner;

    function decimals() public view virtual override returns (uint8) {
        return 9;
    }

    // Precisamos sobreescrever função padrão que está no ERC20
    // para adicionar a condição do exercício proposto
    function transfer(address to, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        address from = _msgSender();
        // Compara se a hora do block é maior ou igual a 1 de Jan de 2023
        // ou se quem está mandando a transação é o dono do token
        if (block.timestamp >= 1672542000 || owner == from) {
            // Sun Jan 01 2023 00:00:00 GMT-0300 (Brasilia Standard Time)
            _transfer(from, to, amount);
            return true;
        }
        revert("Failed to transfer... Please wait until 2023!");
    }

    // Mesma coisa que o transfer, mas no transferFrom
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        if (block.timestamp >= 1672542000 || owner == from) {
            // Sun Jan 01 2023 00:00:00 GMT-0300 (Brasilia Standard Time)
            _transfer(from, to, amount);
            return true;
        }
        revert("Failed to spend tokens... Please wait until 2023!");
    }
}
