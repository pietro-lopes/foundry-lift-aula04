// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract T04TokenSale {
    constructor(address token) {
        _liftToken = IERC20Metadata(token);
        owner = payable(msg.sender);
        _liftDecimals = _liftToken.decimals();
    }

    IERC20Metadata private _liftToken;
    address payable public owner;
    uint256 public constant MIN_BUY = 1 gwei;
    uint256 public constant MAX_BUY = 1 ether;
    uint8 private _liftDecimals;
    uint8 private constant _MATIC_DECIMALS = 18;

    function buy1pra1() public payable returns (bool) {
        require(
            MAX_BUY >= msg.value,
            "Por favor, tenha pena do seu rico dinheirinho..."
        );
        require(
            MIN_BUY <= msg.value,
            unicode"Por favor, não seja tão mão de vaca, pelo menos 1 gwei..."
        );

        bool success = _liftToken.transferFrom(
            owner,
            msg.sender,
            msg.value / 10**(_MATIC_DECIMALS - _liftDecimals)
        );
        require(success, "Run out of tokens...");
        owner.transfer(msg.value);
        emit Sold(
            msg.sender,
            msg.value / 10**(_MATIC_DECIMALS - _liftDecimals)
        );
        return true;
    }

    event Sold(address indexed to, uint256 amount);
}
