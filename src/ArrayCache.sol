// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract ArrayCache {
  uint256[] private _nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * warmaccess x10   +   1_000         24_100 <-
   */

  /**
   * [GAS COST] 49_169
   * [LOOP OPERATIONS] 49_169 - 24_100 => 25_069
   */
  function sum() external view returns (uint256 total) {
    for (uint256 i = 0; i < _nums.length; i++) {
      total += _nums[i];
    }
  }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100 <-
   */

  /**
   * [GAS COST] 48_158
   * [LOOP OPERATIONS] 48_158 - 23_100 => 25_058
   */
  function sumWithCache() external view returns (uint256) {
    uint256 total;
    uint256 length = _nums.length;

    for (uint256 i = 0; i < length; i++) {
      total += _nums[i];
    }

    return total;
  }

  function loadSlotNums() external view returns (uint256 value) {
    assembly {
      value := sload(_nums.slot)
    }
  }
}
