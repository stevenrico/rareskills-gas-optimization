// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Memory {
  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * txdatazero    x2 +       8         21_008
   * txdatanonzero x2 +      32         21_040
   * CALLDATASIZE  x1 +       2         21_042
   * CALLDATALOAD  x2 +       6         21_048
   * MLOAD         x1 +       3         21_051
   * MSTORE        x3 +       9         21_060
   * CALLDATACOPY  x1 +       3         21_063 <-
   */

  /**
   * [INPUTS]
   * data       0x00ff00ff
   *
   * [GAS COST] 22_008
   */
  function callWithMemory(bytes memory data) external { }

  /**
   * [DESCRIPTION]    [GAS COST]     [SUBTOTAL]
   * transaction      +  21_000         21_000
   * txdatazero    x2 +       8         21_008
   * txdatanonzero x2 +      32         21_040
   * CALLDATASIZE  x1 +       2         21_042
   * CALLDATALOAD  x2 +       6         21_048 <-
   */

  /**
   * [INPUTS]
   * data       0x00ff00ff
   *
   * [GAS COST] 21_887
   */
  function callWithCalldata(bytes calldata data) external { }

  /**
   * [INPUTS]
   * data       0x00ff00ff
   *
   * [GAS COST] 22_391
   */
  function useMemoryForMutation(bytes memory data)
    external
    pure
    returns (bytes memory)
  {
    data[0] = 0xaa;

    return data;
  }

  /**
   * [INPUTS]
   * data       0x00ff00ff
   *
   * [GAS COST] 22_483
   */
  function useCalldataForMutation(bytes calldata data)
    external
    pure
    returns (bytes memory)
  {
    bytes memory localData = data;

    localData[0] = 0xaa;

    return localData;
  }
}
