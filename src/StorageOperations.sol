// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract StorageOperations {
  uint256 private _integer;

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * 0 => 1:                  43_324      22_324
   * 5000 => 1:               26_224       5_224
   * 1 => 1:                  23_424       2_424
   */
  function setToOne() external {
    _integer = 1;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * 0 => 5000:               43_303      22_303
   * 1 => 5000:               26_203       5_203
   * 5000 => 5000:            23_403       2_403
   */
  function setToFiveThousand() external {
    _integer = 5000;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * 0 => 0:                  23_446       2_446
   * 1 => 0:                  21_446         446
   * 5000 => 0:               21_446         446
   */
  function setToZero() external {
    _integer = 0;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * _integer == 0:           23_355       2_355
   * _integer == 1:           23_355       2_355
   * _integer == 5000:        23_355       2_355
   */
  function getInteger() external view returns (uint256) {
    return _integer;
  }

  /**
   * [DESCRIPTION]            [TOTAL]     [NO TX]
   * _integer == 0:           43_391      22_391
   * _integer == 1:           26_291       5_291
   * _integer == 5000:        26_291       5_291
   */
  function getAndSetInteger() external {
    uint256 integer = _integer;

    _integer = integer + 1;
  }
}
