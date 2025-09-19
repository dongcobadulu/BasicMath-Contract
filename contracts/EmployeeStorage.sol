// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmployeeStorage {

    uint32 private idNumber;
    uint128 private shares;
    uint private salary;
    string private name;
    
    error NotAuthorized();

    constructor(
        uint32 _idNumber,
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
        uint32,
        uint128,
        uint,
        string memory
    ) {
        return (idNumber, shares, salary, name);
    }
}
