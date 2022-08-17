// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T02TokenWithTax.sol";

contract T02TokenWithTaxTest is Test {
    T02TokenWithTax public t02Token;
    uint256 public transferAmount;
    uint256 public tax;
    uint8 public decimals;
    address public owner = address(this);
    address public alice = vm.addr(1);

    // Criando contrato
    function setUp() public {
        t02Token = new T02TokenWithTax();
        tax = t02Token.TAX();
        decimals = t02Token.decimals();
        transferAmount = 100 * 10**decimals;
    }

    // Testando transfer
    function testSuccessTransferWithTax() public {
        t02Token.transfer(alice, transferAmount);
        assertEq(
            t02Token.balanceOf(alice),
            transferAmount - ((transferAmount * tax) / 100)
        );
    }

    // Testando transferFrom
    function testSuccessTransferFromWithTax() public {
        t02Token.approve(owner, Test.UINT256_MAX);
        t02Token.transferFrom(owner, alice, transferAmount);
        assertEq(
            t02Token.balanceOf(alice),
            transferAmount - ((transferAmount * tax) / 100)
        );
    }
}
