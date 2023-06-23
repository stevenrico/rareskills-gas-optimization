// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test, console } from "forge-std/Test.sol";
import { Memory } from "../src/Memory.sol";

contract MemoryTest is Test {
  Memory private _memory;

  function setUp() external {
    _memory = new Memory();
  }

  function testCallWithMemory() external {
    vm.expectCall(
      address(_memory), abi.encodeCall(_memory.callWithMemory, "0x00ff00ff")
    );
    _memory.callWithMemory("0x00ff00ff");
  }

  function testCallWithCalldata() external {
    vm.expectCall(
      address(_memory), abi.encodeCall(_memory.callWithCalldata, "0x00ff00ff")
    );
    _memory.callWithCalldata("0x00ff00ff");
  }
}
