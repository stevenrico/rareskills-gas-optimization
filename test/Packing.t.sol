// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { Packing } from "../src/Packing.sol";

contract PackingTest is Test, Packing {
  Packing private _packing;

  function setUp() external {
    _packing = new Packing();
  }

  function testSetStake() external {
    vm.warp(1_438_226_773_000);
    vm.expectCall(address(_packing), abi.encodeCall(_packing.setStake, ()));
    _packing.setStake();

    Stake memory stake = _packing.getStake();

    assertEq(stake.amount, 500);
    assertEq(stake.timestamp, 1_438_226_773_000);
  }

  function testGetStake() external {
    Stake memory stake = _packing.getStake();

    assertEq(stake.amount, 0);
    assertEq(stake.timestamp, 0);
  }
}
