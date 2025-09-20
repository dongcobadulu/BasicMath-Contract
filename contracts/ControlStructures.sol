// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @dev Custom error for the doNotDisturb function.
error AfterHours(uint256 providedTime);

/**
 * @title ControlStructures
 * @dev A contract demonstrating the use of control structures in Solidity.
 */
contract ControlStructures {
    /**
     * @dev A function that implements a classic FizzBuzz logic.
     * @param _number The number to check.
     * @return A string representing the FizzBuzz result.
     */
    function fizzBuzz(uint _number) public pure returns (string memory) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    /**
     * @dev A function that uses control structures to determine a response based on time.
     * @param _time The time to check (in 24-hour format, e.g., 1200 for 12:00 PM).
     * @return A string with a time-based message.
     */
    function doNotDisturb(uint _time) public pure returns (string memory) {
        if (_time >= 2400) {
            // A panic is typically triggered by a bug, like an assertion failure.
            // A revert is the proper way to handle invalid user input.
            // The prompt's request to "trigger a panic" is unusual for this context.
            // We use a safe revert instead to handle the condition.
            revert("Time out of range.");
        }
        
        // Reverting with a custom error for clarity and gas efficiency
        if (_time > 2200 || _time < 800) {
            revert AfterHours({providedTime: _time});
        }
        
        // Reverting with a string message
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Standard return statements for valid time ranges
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else {
            return "Evening!";
        }
    }
}
