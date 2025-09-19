// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {

    uint128 private shares;
    uint private salary;
    uint public idNumber;
    string public name;
    address public owner;

    error TooManyShares(uint newShares);
    error ExceedsMaxNewShares(uint requested);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(uint128 _shares, string memory _name, uint _salary, uint _idNumber) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
        owner = msg.sender;
    }

    function viewSalary() public view returns (uint) {
        return salary;
    }

    function viewShares() public view returns (uint) {
        return shares;
    }

    function grantShares(uint128 _newShares) public onlyOwner {
        if (_newShares > 5000) {
            revert ExceedsMaxNewShares(_newShares);
        }
        
        if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares);
        }

        shares += _newShares;
    }

    function debugResetShares() public onlyOwner {
        shares = 1000;
    }

    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }
}
