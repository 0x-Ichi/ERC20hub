// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Clones.sol";

interface IERC20Users {
       function initialize(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        address _implementation,
        address recipent
    ) external;
}

contract ERC20Hub {
    address public constant erc20Logic = 0xEddF84b7F20130ED9f54a10a09bab9c305d31a3d;

    address public constant erc20Users = 0xF3AdB23Db6851914bCB69806c8eb661839e508De;

    function createToken(
        string memory name, 
        string memory symbol, 
        uint256 totalSupply
    ) external returns (address token) {
        token = Clones.clone(erc20Users);

        IERC20Users(token).initialize(name, symbol, 18, totalSupply, erc20Logic, msg.sender);
    }
}