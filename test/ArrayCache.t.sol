// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { ArrayCache } from "../src/ArrayCache.sol";

contract ArrayCacheTest is Test {
  ArrayCache private _arrayCache;

  function setUp() external {
    _arrayCache = new ArrayCache();
  }

  function testSum() external {
    assertEq(_arrayCache.sum(), 55);
  }

  function testSumWithCache() external {
    assertEq(_arrayCache.sumWithCache(), 55);
  }

  function testLoadSlotNums() external {
    assertEq(_arrayCache.loadSlotNums(), 10);
  }
}
