// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { Arrays } from "../src/Arrays.sol";

contract ArraysTest is Test {
  Arrays private _arrays;

  uint256[] private _nums;

  function setUp() external {
    _arrays = new Arrays();

    _nums = [5, 10, 15, 20, 25];
  }

  function testSet() external {
    vm.expectCall(address(_arrays), abi.encodeCall(_arrays.set, (_nums)));
    _arrays.set(_nums);

    assertEq(_arrays.get(), _nums);
  }

  function testGet() external {
    _arrays.set(_nums);

    assertEq(_arrays.get(), _nums);
  }

  function testGetLength() external {
    _arrays.set(_nums);

    assertEq(_arrays.getLength(), _nums.length);
  }

  function testGetSlotValue() external {
    _arrays.set(_nums);

    assertEq(_arrays.getSlotValue(), 5);
  }
}
