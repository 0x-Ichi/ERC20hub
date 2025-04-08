// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC20Users {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    bool public initialized;

    bytes32 private constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function initialize(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        address _implementation,
        address recipent
    ) external {
        require(!initialized, "Already initialized");
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        initialized = true;
        _balances[recipent] = _initialSupply;

        emit Transfer(address(0), recipent, _initialSupply);

        _setImplementation(_implementation);

        /*
        (bool success, ) = _implementation.delegatecall(
            abi.encodeWithSignature("_mint(address,uint256)", recipent, _initialSupply)
        );
        require(success, "Mint failed");
        */
    }

    function _getImplementation() internal view returns (address impl) {
        assembly {
            impl := sload(_IMPLEMENTATION_SLOT)
        }
    }

    function _setImplementation(address newImplementation) internal {
        require(newImplementation.code.length > 0, "Invalid implementation");
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    fallback() external payable {
        address impl = _getImplementation();
        require(impl != address(0), "Implementation not set");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0  { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {}
}
