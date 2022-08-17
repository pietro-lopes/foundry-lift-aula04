// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T01Token.sol";

contract T01TokenTest is Test {
    T01Token public t01Token;
    uint8 public decimals = 9;
    uint256 public totalSupply = 1_000_000 * 10**decimals;
    address public owner = address(this);

    // Criando contrato
    function setUp() public {
        t01Token = new T01Token();
    }

    // Testando decimais
    function testSuccessDecimals() public {
        assertEq(t01Token.decimals(), decimals);
    }

    // Testando totalSupply do contrato
    function testSuccessTotalSupply() public {
        assertEq(t01Token.totalSupply(), totalSupply);
    }

    // Testando se foi mintado o totalSupply
    function testSuccessBalanceOfOwner() public {
        assertEq(t01Token.balanceOf(owner), totalSupply);
    }
}
