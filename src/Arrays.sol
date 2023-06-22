// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Arrays {
  uint256[] private _nums;

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * [] => []:                 24_142       3_142
   * [] => [5,50,500]:        111_039      90_039
   * [5,50,500] => []:         33_672      12_672
   * [] => [5,10,15,20,25]:   155_647     134_647
   * [5,10,15,20,25] => []:    41_750      20_750
   * [5,50,500] => [5,...,25]: 84_447      63_447
   * [5,...,25] => [5,50,500]: 40_337      19_337
   */
  function set(uint256[] calldata nums) external {
    _nums = nums;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * _nums == []:              23_692       2_692
   * _nums == [5,50,500]:      30_468       9_468
   * _nums == [5,...,25]:      34_938      13_938
   */
  function get() external view returns (uint256[] memory) {
    return _nums;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * _nums == []:              23_366       2_366
   * _nums == [5,50,500]:      23_366       2_366
   * _nums == [5,...,25]:      23_366       2_366
   */
  function getLength() external view returns (uint256) {
    return _nums.length;
  }

  function getSlotValue() external view returns (uint256 value) {
    assembly {
      value := sload(_nums.slot)
    }
  }
}
