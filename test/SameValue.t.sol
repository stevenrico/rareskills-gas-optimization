// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { SameValue } from "../src/SameValue.sol";

contract SameValueTest is Test {
  SameValue private _sameValue;

  function setUp() external {
    _sameValue = new SameValue();
  }

  function testSetValue() external {
    vm.expectCall(address(_sameValue), abi.encodeCall(_sameValue.setValue, (5)));
    _sameValue.setValue(5);

    assertEq(_sameValue.getValue(), 5);
  }

  function testSetValueWithChecks() external {
    vm.expectCall(
      address(_sameValue), abi.encodeCall(_sameValue.setValueWithChecks, (5))
    );
    _sameValue.setValueWithChecks(5);

    assertEq(_sameValue.getValue(), 5);
  }

  function testGetValue() external {
    assertEq(_sameValue.getValue(), 5);
  }
}
