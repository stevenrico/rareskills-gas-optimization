// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Refunds {
  uint256 private _zeroValue;
  uint256 private _nonZeroValue = 5;

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100 <-
   */

  /**
   * [GAS COST] 43_326
   */
  function setZeroToNonZero() external {
    _zeroValue = 5;
  }

  function getZeroValue() external view returns (uint256) {
    return _zeroValue;
  }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000
   * sclear           -   4_800         21_200 <-
   *
   * max_refund = 26_000 / 5 => 5_200
   * potential_cost = 26_000 - 5_200 => 20_800
   */

  /**
   * [GAS COST] 21_425
   */
  function setNonZeroToZero() external {
    _nonZeroValue = 0;
  }

  function getNonZeroValue() external view returns (uint256) {
    return _nonZeroValue;
  }

  uint256 private _numOne = 5;
  uint256 private _numTwo = 5000;

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000
   * coldsload        +   2_100         28_100
   * sreset           +   2_900         31_000
   * sclear           -   3_100         27_900
   * sclear           -   3_100         24_800 <-
   *
   * max_refund = 31_000 / 5 = 6_200
   * potential_cost = 31_000 - 6_200 => 24_800
   */

  /**
   * [GAS COST] 25_006
   */
  function setNonZeroToZeroTwice() external {
    _numOne = 0;
    _numTwo = 0;
  }

  function getNums() external view returns (uint256, uint256) {
    return (_numOne, _numTwo);
  }

  uint256 private _swapOne;
  uint256 private _swapTwo = 5;

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100
   * coldsload        +   2_100         45_200
   * sreset           +   2_900         48_100
   * sclear           -   4_800         43_300 <-
   *
   * max_refund = 48_100 / 5 = 9_620
   * potential_cost = 30_000 - 9_620 => 20_380
   */

  /**
   * [GAS COST] 43_559
   */
  function swapZeroAndNonZero() external {
    _swapOne = 5;
    _swapTwo = 0;
  }

  function getSwaps() external view returns (uint256, uint256) {
    return (_swapOne, _swapTwo);
  }

  mapping(uint256 => uint256[]) private _arrays;

  constructor() {
    _arrays[0] = [5];
    _arrays[1] = [5, 50];
    _arrays[2] = [5, 50, 5000];
  }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000
   * coldsload        +   2_100         28_100
   * sreset           +   2_900         31_000
   * sclear           -   3_100         26_200
   * sclear           -   3_100         24_800 <-
   *
   * max_refund = 31_000 / 5 = 6_200
   * potential_cost = 31_000 - 6_200 => 24_800
   */

  /**
   * [GAS COST] 25_214
   */
  function deleteArrayZero() external {
    delete _arrays[0];
  }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000
   * coldsload        +   2_100         28_100
   * sreset           +   2_900         31_000
   * coldsload        +   2_100         33_100
   * sreset           +   2_900         36_000
   * sclear           -   2_400         33_600
   * sclear           -   2_400         31_200
   * sclear           -   2_400         28_800 <-
   *
   * max_refund = 36_000 / 5 = 7_200
   * potential_cost = 36_000 - 7_200 => 28_800
   */

  /**
   * [GAS COST] 29_219
   */
  function deleteArrayOne() external {
    delete _arrays[1];
  }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000
   * coldsload        +   2_100         28_100
   * sreset           +   2_900         31_000
   * coldsload        +   2_100         33_100
   * sreset           +   2_900         36_000
   * coldsload        +   2_100         38_100
   * sreset           +   2_900         41_000
   * sclear           -   2_050         38_950
   * sclear           -   2_050         36_900
   * sclear           -   2_050         34_850
   * sclear           -   2_050         32_800 <-
   *
   * max_refund = 41_000 / 5 = 8_200
   * potential_cost = 41_000 - 8_200 => 32_800
   */

  /**
   * [GAS COST] 33_294
   */
  function deleteArrayTwo() external {
    delete _arrays[2];
  }

  function getArrayAtIndex(uint256 index)
    external
    view
    returns (uint256[] memory)
  {
    return _arrays[index];
  }
}
