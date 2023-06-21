// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract SameValue {
  uint256 private _value = 5;

  /**
   * [DESCRIPTION]    [TOTAL]     [NO TX]     [DIFF]
   * 5 => 5:          23_638      2_638       +105
   * 5 => 10:         26_438      5_438       -4
   */
  function setValue(uint256 newValue) external {
    _value = newValue;
  }

  /**
   * [DESCRIPTION]    [TOTAL]     [NO TX]     [DIFF]
   * 5 => 5:          23_533      2_533       -105
   * 5 => 10:         26_442      5_442       +4
   */
  function setValueWithChecks(uint256 newValue) external {
    uint256 value = _value;

    // Code that uses 'value' for a specific purpose

    if (value != newValue) {
      _value = newValue;
    }
  }

  function getValue() external view returns (uint256) {
    return _value;
  }
}
