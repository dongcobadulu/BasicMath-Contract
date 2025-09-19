// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {

    uint64 private idNumber;
    uint128 private shares;
    uint private salary;
    string private name;
    
    error NotAuthorized();

    constructor(
        uint64 _idNumber,
        uint128 _shares,
        uint _salary,
        string memory _name
    ) {
        idNumber = _idNumber;
        shares = _shares;
        salary = _salary;
        name = _name;
    }

    function getEmployeeData() public view returns (
        uint64,
        uint128,
        uint,
        string memory
    ) {
        return (idNumber, shares, salary, name);
    }
}
