// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { Refunds } from "../src/Refunds.sol";

contract RefundsTest is Test {
  Refunds private _refunds;

  function setUp() external {
    _refunds = new Refunds();
  }

  function testSetZeroToNonZero() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.setZeroToNonZero, ())
    );
    _refunds.setZeroToNonZero();

    assertEq(_refunds.getZeroValue(), 5);
  }

  function testGetZeroValue() external {
    assertEq(_refunds.getZeroValue(), 0);
  }

  function testSetNonZeroToZero() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.setNonZeroToZero, ())
    );
    _refunds.setNonZeroToZero();

    assertEq(_refunds.getNonZeroValue(), 0);
  }

  function testGetNonZeroValue() external {
    assertEq(_refunds.getNonZeroValue(), 5);
  }

  function testSetNonZeroToZeroTwice() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.setNonZeroToZeroTwice, ())
    );
    _refunds.setNonZeroToZeroTwice();

    (uint256 numOne, uint256 numTwo) = _refunds.getNums();

    assertEq(numOne, 0);
    assertEq(numTwo, 0);
  }

  function testGetNums() external {
    (uint256 numOne, uint256 numTwo) = _refunds.getNums();

    assertEq(numOne, 5);
    assertEq(numTwo, 5000);
  }

  function testSwapZeroAndNonZero() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.swapZeroAndNonZero, ())
    );
    _refunds.swapZeroAndNonZero();

    (uint256 swapOne, uint256 swapTwo) = _refunds.getSwaps();

    assertEq(swapOne, 5);
    assertEq(swapTwo, 0);
  }

  function testGetSwaps() external {
    (uint256 swapOne, uint256 swapTwo) = _refunds.getSwaps();

    assertEq(swapOne, 0);
    assertEq(swapTwo, 5);
  }

  function testDeleteArrayZero() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.deleteArrayZero, ())
    );
    _refunds.deleteArrayZero();

    uint256[] memory arrayAtIndexZero = new uint256[](0);

    assertEq(_refunds.getArrayAtIndex(0), arrayAtIndexZero);
  }

  function testDeleteArrayOne() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.deleteArrayOne, ())
    );
    _refunds.deleteArrayOne();

    uint256[] memory arrayAtIndexOne = new uint256[](0);

    assertEq(_refunds.getArrayAtIndex(1), arrayAtIndexOne);
  }

  function testDeleteArrayTwo() external {
    vm.expectCall(
      address(_refunds), abi.encodeCall(_refunds.deleteArrayTwo, ())
    );
    _refunds.deleteArrayTwo();

    uint256[] memory arrayAtIndexTwo = new uint256[](0);

    assertEq(_refunds.getArrayAtIndex(2), arrayAtIndexTwo);
  }

  function testGetArrayAtIndex() external {
    uint256[] memory arrayAtIndexZero = new uint256[](1);
    arrayAtIndexZero[0] = 5;

    assertEq(_refunds.getArrayAtIndex(0), arrayAtIndexZero);

    uint256[] memory arrayAtIndexOne = new uint256[](2);
    arrayAtIndexOne[0] = 5;
    arrayAtIndexOne[1] = 50;

    assertEq(_refunds.getArrayAtIndex(1), arrayAtIndexOne);

    uint256[] memory arrayAtIndexTwo = new uint256[](3);
    arrayAtIndexTwo[0] = 5;
    arrayAtIndexTwo[1] = 50;
    arrayAtIndexTwo[2] = 5000;

    assertEq(_refunds.getArrayAtIndex(2), arrayAtIndexTwo);
  }
}
