// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Packing {
  uint128 private _numOne = 5;
  uint128 private _numTwo = 50;

  function getSlotNumOne() external pure returns (uint256 slot) {
    assembly {
      slot := _numOne.slot
    }
  }

  function getSlotNumTwo() external pure returns (uint256 slot) {
    assembly {
      slot := _numTwo.slot
    }
  }

  function loadSlotZero() external view returns (bytes32 value) {
    assembly {
      value := sload(0)
    }
  }

  function getNumOne() external view returns (uint256) {
    return _numOne;
  }

  function getNumTwo() external view returns (uint256) {
    return _numTwo;
  }

  function getOffsetNumOne() external pure returns (uint256 offset) {
    assembly {
      offset := _numOne.offset
    }
  }

  function getOffsetNumTwo() external pure returns (uint256 offset) {
    assembly {
      offset := _numTwo.offset
    }
  }

  struct Stake {
    uint128 amount;
    uint128 timestamp;
  }

  mapping(address => Stake) _stakedAccounts;

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100 <-
   */

  /**
   * [GAS COST] 43_542
   */
  function setStake() external {
    _stakedAccounts[msg.sender] =
      Stake({ amount: 500, timestamp: uint128(block.timestamp) });
  }

  function getStake() external view returns (Stake memory) {
    return _stakedAccounts[msg.sender];
  }
}
