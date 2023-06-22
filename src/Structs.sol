// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Structs {
  struct VisitCount {
    address id;
    uint256 count;
  }

  VisitCount private _visitCount;

  /**
   * [FIRST TX]
   *
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100
   * coldsload        +   2_100         45_200
   * sset             +  20_000         65_200 <-
   */

  /**
   * [GAS COST] 65_550
   */

  /**
   * [SECOND TX]
   *
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sreset           +   2_900         26_000 <-
   */

  /**
   * [GAS COST] 26_459
   */
  function countVisit() external {
    if (_visitCount.count == 0) {
      _visitCount = VisitCount({ id: msg.sender, count: 1 });
    } else {
      _visitCount.count += 1;
    }
  }

  function getVisitCount() external view returns (VisitCount memory) {
    return _visitCount;
  }

  struct Profile {
    address id;
    string bio;
  }

  Profile private _shortBio;
  Profile private _longBio;

  /**
   * [STRING = 30 BYTES]
   *
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100
   * coldsload        +   2_100         45_200
   * sset             +  20_000         65_200 <-
   */

  /**
   * [GAS COST] 66_019
   */
  function createUserWithShortBio() external {
    _shortBio =
      Profile({ id: msg.sender, bio: "Lorem ipsum dolor sit aliquam." });
  }

  /**
   * [STRING = 120 BYTES]
   *
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * [msg.sender]
   * coldsload        +   2_100         23_100
   * sset             +  20_000         43_100
   * [string]
   * coldsload        +   2_100         45_200
   * sset             +  20_000         65_200
   * coldsload        +   2_100         67_300
   * sset             +  20_000         87_300
   * coldsload        +   2_100         89_400
   * sset             +  20_000        109_400
   * coldsload        +   2_100        111_500
   * sset             +  20_000        131_500
   * [string.length]
   * coldsload        +   2_100        133_600
   * sset             +  20_000        153_600 <-
   */

  /**
   * [GAS COST] 154_768
   */
  function createUserWithLongBio() external {
    _longBio = Profile({
      id: msg.sender,
      bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in eros sit amet dolor mollis placerat. Ut vel neque ac."
    });
  }

  function getBios() external view returns (Profile memory, Profile memory) {
    return (_shortBio, _longBio);
  }

  function getStringFromBioByOffset() external view returns (bytes32 value) {
    assembly {
      value := sload(add(_shortBio.slot, 1))
    }
  }
}
