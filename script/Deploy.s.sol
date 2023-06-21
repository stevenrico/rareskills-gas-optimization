// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Script } from "forge-std/Script.sol";
import { Storage } from "../src/Storage.sol";
import { Add } from "../src/Add.sol";
import { DoNothing } from "../src/DoNothing.sol";
import { StorageOperations } from "../src/StorageOperations.sol";
import { SameValue } from "../src/SameValue.sol";

contract DeployScript is Script {
  function run() public {
    uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

    vm.startBroadcast(deployerPrivateKey);

    new Storage();
    new Add();
    new DoNothing();
    new StorageOperations();
    new SameValue();

    vm.stopBroadcast();
  }
}
