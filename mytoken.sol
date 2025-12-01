    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.26;

    import "./IERC20.sol";

    contract ERC20 is IERC20 {
        string public name;
        string public symbol;   
        uint8 public decimals;
        uint256 private _totalSupply;

        mapping(address => uint256) private _balances;

        constructor() {
            name = "MyToken";
            symbol = "MYT";
            decimals = 18;

            uint256 initialSupply = 1_000_000 * (10 ** uint256(decimals));
            _totalSupply = initialSupply;
            _balances[msg.sender] = initialSupply;
        }

        function totalSupply() external view override returns (uint256) {
            return _totalSupply;
        }

        function balanceOf(address account) external view override returns (uint256)
        {
            return _balances[account];
        }

        function transfer(address recipient, uint256 amount) external override returns (bool)
        {
            require(recipient != address(0), "transfer to zero address");
            require(_balances[msg.sender] >= amount, "insufficient");
            _balances[msg.sender] -= amount;
            _balances[recipient] += amount;
            return true;
        }
        // seul le "sender" lui-meme peut appeler la fonction.
        function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool)
        {
            require(sender == msg.sender, "only sender can call transferFrom");
            require(recipient != address(0), "transfer to zero address");
            require(_balances[sender] >= amount, "insufficient balance");
            _balances[sender] -= amount;
            _balances[recipient] += amount;
            return true;
        }
    }
