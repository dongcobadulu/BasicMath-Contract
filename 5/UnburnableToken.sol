// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract UnburnableToken {
    mapping (address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;
    mapping (address => bool) private hasClaimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    constructor() {
        totalSupply = 100000000;
    }

    // Mengubah jumlah klaim dari 1000 menjadi 5000
    function claim() public {
        if (totalClaimed == totalSupply) {
            revert AllTokensClaimed();
        }
        
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        balances[msg.sender] += 5000; // Mengubah nilai ini
        totalClaimed += 5000;         // Mengubah nilai ini
        
        hasClaimed[msg.sender] = true;
    }

    function safeTransfer(address _to, uint _amount) public {
        if (balances[msg.sender] < _amount) {
            revert UnsafeTransfer(_to);
        }
        
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }

        if (_to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
