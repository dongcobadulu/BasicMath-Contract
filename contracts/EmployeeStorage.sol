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

    constructor(uint128 _shares, uint _salary, uint _idNumber, string memory _name) {
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

    /**
    * Do not modify this function. It is used to enable the unit test for this pin
    * to check whether or not you have configured your storage variables to make
    * use of packing.
    *
    * If you wish to cheat, simply modify this function to always return `0`
    * I'm not your boss ¯\_(ツ)_/¯
    *
    * Fair warning though, if you do cheat, it will be on the blockchain having been
    * deployed by your wallet....FOREVER!
    */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload (_slot)
        }
    }

    /**
    * Warning: Anyone can use this function at any time!
    */
    function debugResetShares() public onlyOwner {
        shares = 1000;
    }
}
