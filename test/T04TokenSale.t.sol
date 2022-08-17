// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T01Token.sol";
import "../src/T04TokenSale.sol";

contract T04TokenSaleTest is Test {
    T01Token public t01Token;
    T04TokenSale public t04TokenSale;
    address public alice = vm.addr(1);
    address public bob = vm.addr(2);
    uint256 public minBuy;
    uint256 public maxBuy;

    // Criando contrato
    function setUp() public {
        // Criando label pra facilitar debug caso necessário
        vm.label(alice, "Alice");
        vm.label(bob, "Bob");
        // Ativando a conta alice (owner) pra dar deploy nos contratos t01 e t04
        vm.startPrank(alice);
        t01Token = new T01Token();
        t04TokenSale = new T04TokenSale(address(t01Token));
        t01Token.approve(address(t04TokenSale), Test.UINT256_MAX);
        minBuy = t04TokenSale.MIN_BUY();
        maxBuy = t04TokenSale.MAX_BUY();
        vm.stopPrank();
        // Iremos usar o bob pra comprar do nosso contrato
        // Então daremos o máximo possível de Ether pra essa conta
        vm.deal(bob, Test.UINT256_MAX);
    }

    // Testando compra acima do permitido
    function testRevertBuyAboveMax() public {
        vm.prank(bob);
        vm.expectRevert(
            bytes("Por favor, tenha pena do seu rico dinheirinho...")
        );
        t04TokenSale.buy1pra1{value: maxBuy + 1}();
    }

    // Testando compra máxima
    function testSuccessBuyMax() public {
        vm.prank(bob);
        bool success = t04TokenSale.buy1pra1{value: maxBuy}();
        assertTrue(success);
    }

    // Testando compra mínima
    function testSuccessBuyMin() public {
        vm.prank(bob);
        bool success = t04TokenSale.buy1pra1{value: minBuy}();
        assertTrue(success);
    }

    // Testando compra abaixo do permitido
    function testRevertBuyBelowMin() public {
        vm.prank(bob);
        vm.expectRevert(
            bytes(
                unicode"Por favor, não seja tão mão de vaca, pelo menos 1 gwei..."
            )
        );
        t04TokenSale.buy1pra1{value: minBuy - 1}();
    }

    // Teste de fuzz
    function testFuzzBuy(uint256 amount) public {
        vm.prank(bob);
        if (minBuy > amount) {
            vm.expectRevert(
                bytes(
                    unicode"Por favor, não seja tão mão de vaca, pelo menos 1 gwei..."
                )
            );
            t04TokenSale.buy1pra1{value: amount}();
            return;
        }
        if (maxBuy < amount) {
            vm.expectRevert(
                bytes("Por favor, tenha pena do seu rico dinheirinho...")
            );
            t04TokenSale.buy1pra1{value: amount}();
            return;
        }
        bool success = t04TokenSale.buy1pra1{value: amount}();
        assertTrue(success);
    }

    receive() external payable {}
}
