// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {

    uint128 private shares;
    uint private salary;
    uint public idNumber;
    string public name;

    error TooManyShares(uint newShares);

    constructor(uint _shares, string memory _name, uint _salary, uint _idNumber) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewSalary() public view returns (uint) {
        return salary;
    }

    function viewShares() public view returns (uint) {
        return shares;
    }

    function grantShares(uint _newShares) public {
        if (_newShares > 5000) {
            revert("Too many shares");
        }
        
        if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares);
        }

        shares += _newShares;
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
