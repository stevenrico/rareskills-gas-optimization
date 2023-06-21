// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract DoNothing {
  function doPayable() external payable { }

  function doNonPayable() external { }
}
