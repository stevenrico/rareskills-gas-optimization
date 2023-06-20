// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Add {
  uint256 private _a = 5;

  function plusOne() external view returns (uint256) {
    unchecked {
      return _a + 1;
    }
  }
}
