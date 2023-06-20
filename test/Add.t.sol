// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { Add } from "../src/Add.sol";

contract AddTest is Test {
  Add private _add;

  function setUp() external {
    _add = new Add();
  }

  function testPlusOne() external {
    assertEq(_add.plusOne(), 6);
  }
}
