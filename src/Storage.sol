// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Storage {
  uint256 private _a = 5;
  uint256 private _b = 10;
  uint256 private _c = 100;

  function storageLocation() external pure returns (uint256) {
    uint256 slotLocation;

    assembly {
      slotLocation := _a.slot
    }

    return slotLocation;
  }

  function getAtSlot(uint256 slot) external view returns (uint256) {
    uint256 value;

    assembly {
      value := sload(slot)
    }

    return value;
  }
}
