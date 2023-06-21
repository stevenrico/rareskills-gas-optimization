// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { DoNothing } from "../src/DoNothing.sol";

contract DoNothingTest is Test {
  DoNothing private _doNothing;

  function setUp() external {
    _doNothing = new DoNothing();
  }

  function testDoPayable() external {
    vm.expectCall(address(_doNothing), abi.encodeCall(_doNothing.doPayable, ()));
    _doNothing.doPayable();
  }

  function testDoNonPayable() external {
    vm.expectCall(
      address(_doNothing), abi.encodeCall(_doNothing.doNonPayable, ())
    );
    _doNothing.doNonPayable();
  }
}
