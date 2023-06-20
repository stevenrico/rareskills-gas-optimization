// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Storage {
  uint256 private _a;

  function storageLocation() external pure returns (uint256) {
    uint256 slotLocation;

    assembly {
      slotLocation := _a.slot
    }

    return slotLocation;
  }
}
