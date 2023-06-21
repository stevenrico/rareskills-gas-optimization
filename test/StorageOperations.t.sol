// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test } from "forge-std/Test.sol";
import { StorageOperations } from "../src/StorageOperations.sol";

contract StorageOperationsTest is Test {
  StorageOperations private _storageOperations;

  function setUp() external {
    _storageOperations = new StorageOperations();
  }

  function testZeroToOne() external {
    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToOne, ())
    );
    _storageOperations.setToOne();

    assertEq(_storageOperations.getInteger(), 1);
  }

  function testOneToOne() external {
    _storageOperations.setToOne();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToOne, ())
    );
    _storageOperations.setToOne();

    assertEq(_storageOperations.getInteger(), 1);
  }

  function testFiveThousandToOne() external {
    _storageOperations.setToFiveThousand();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToOne, ())
    );
    _storageOperations.setToOne();

    assertEq(_storageOperations.getInteger(), 1);
  }

  function testZeroToFiveThousand() external {
    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToFiveThousand, ())
    );
    _storageOperations.setToFiveThousand();

    assertEq(_storageOperations.getInteger(), 5000);
  }

  function testOneToFiveThousand() external {
    _storageOperations.setToOne();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToFiveThousand, ())
    );
    _storageOperations.setToFiveThousand();

    assertEq(_storageOperations.getInteger(), 5000);
  }

  function testFiveThousandToFiveThousand() external {
    _storageOperations.setToFiveThousand();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToFiveThousand, ())
    );
    _storageOperations.setToFiveThousand();

    assertEq(_storageOperations.getInteger(), 5000);
  }

  function testZeroToZero() external {
    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToZero, ())
    );
    _storageOperations.setToZero();

    assertEq(_storageOperations.getInteger(), 0);
  }

  function testOneToZero() external {
    _storageOperations.setToOne();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToZero, ())
    );
    _storageOperations.setToZero();

    assertEq(_storageOperations.getInteger(), 0);
  }

  function testFiveThousandToZero() external {
    _storageOperations.setToFiveThousand();

    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.setToZero, ())
    );
    _storageOperations.setToZero();

    assertEq(_storageOperations.getInteger(), 0);
  }

  function testGetInteger() external {
    assertEq(_storageOperations.getInteger(), 0);
  }

  function testGetAndSetInteger() external {
    vm.expectCall(
      address(_storageOperations),
      abi.encodeCall(_storageOperations.getAndSetInteger, ())
    );
    _storageOperations.getAndSetInteger();

    assertEq(_storageOperations.getInteger(), 1);
  }
}
