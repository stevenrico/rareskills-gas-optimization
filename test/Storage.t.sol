// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { Storage } from "../src/Storage.sol";

contract StorageTest is Test {
  Storage private _storage;

  function setUp() external {
    _storage = new Storage();
  }

  function testStorageLocation() external {
    assertEq(_storage.storageLocation(), 0);
  }

  function testGetAtSlot() external {
    assertEq(_storage.getAtSlot(0), 5);
    assertEq(_storage.getAtSlot(1), 10);
    assertEq(_storage.getAtSlot(2), 100);
    assertEq(_storage.getAtSlot(10), 0);
  }
}
