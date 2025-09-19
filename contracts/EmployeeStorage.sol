// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "hardhat/console.sol";

error TooManyShares(uint newShares);

contract EmployeeStorage {
    uint16 private shares;
    uint248 private salary;
    string public name;
    uint public idNumber;

    constructor(uint16 _shares, string memory _name, uint248 _salary, uint _idNumber) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewShares() public view returns (uint16) {
        return shares;
    }

    function viewSalary() public view returns (uint248) {
        return salary;
    }

    function grantShares(uint _newShares) public {
        if (_newShares > 5000) {
            revert("Too many shares");
        }
        
        uint newTotalShares = uint(shares) + _newShares;

        if (newTotalShares > 5000) {
            revert TooManyShares(newTotalShares);
        }

        shares = uint16(newTotalShares);
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
