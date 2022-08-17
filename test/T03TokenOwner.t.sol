// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/T03TokenOwner.sol";

contract T03TokenOwnerTest is Test {
    T03TokenOwner public t03Token;
    uint256 public transferAmount;
    uint8 public decimals;
    address public owner = address(this);
    address public alice = vm.addr(1);

    // Criando contrato
    function setUp() public {
        t03Token = new T03TokenOwner();
        decimals = t03Token.decimals();
        transferAmount = 100 * 10**decimals;
    }

    // Testando transfer
    function testSuccessOwnerTransferToAlice() public {
        t03Token.transfer(alice, transferAmount);
        assertEq(t03Token.balanceOf(alice), transferAmount);
    }

    // Testando transferFrom
    function testSuccessOwnerTransferFromToAlice() public {
        t03Token.approve(owner, Test.UINT256_MAX);
        t03Token.transferFrom(owner, alice, transferAmount);
        assertEq(t03Token.balanceOf(alice), transferAmount);
    }

    // Testando transfer
    function testRevertAliceTransferToOwnerBefore2013() public {
        t03Token.transfer(alice, transferAmount);
        vm.startPrank(alice);
        vm.expectRevert(bytes("Failed to transfer... Please wait until 2023!"));
        t03Token.transfer(owner, transferAmount);
    }

    // Testando transferFrom
    function testRevertAliceTransferFromToOwnerBefore2013() public {
        t03Token.approve(owner, Test.UINT256_MAX);
        t03Token.transferFrom(owner, alice, transferAmount);
        vm.startPrank(alice);
        t03Token.approve(alice, Test.UINT256_MAX);
        vm.expectRevert(
            bytes("Failed to spend tokens... Please wait until 2023!")
        );
        t03Token.transferFrom(alice, owner, transferAmount);
    }

    // Testando transfer
    function testSuccessAliceTransferToOwnerAfter2013() public {
        t03Token.transfer(alice, transferAmount);
        vm.startPrank(alice);
        vm.warp(1672542000); // Sun Jan 01 2023 00:00:00 GMT-0300 (Brasilia Standard Time)
        t03Token.transfer(owner, transferAmount);
        assertEq(t03Token.balanceOf(alice), 0);
    }

    // Testando transfer
    function testSuccessAliceTransferFromToOwnerAfter2013() public {
        t03Token.transfer(alice, transferAmount);
        vm.startPrank(alice);
        t03Token.approve(alice, Test.UINT256_MAX);
        vm.warp(1672542000); // Sun Jan 01 2023 00:00:00 GMT-0300 (Brasilia Standard Time)
        t03Token.transferFrom(alice, owner, transferAmount);
        assertEq(t03Token.balanceOf(alice), 0);
    }
}
