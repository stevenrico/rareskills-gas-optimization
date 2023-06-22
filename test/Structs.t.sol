// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { Test, console } from "forge-std/Test.sol";
import { Structs } from "../src/Structs.sol";

contract StructsTest is Test, Structs {
  Structs private _structs;

  address private _user;

  function setUp() external {
    _structs = new Structs();

    _user = vm.addr(100);
    vm.label(_user, "USER");
    vm.deal(_user, 1 ether);
  }

  function testCountVisit() external {
    VisitCount memory noVisit = _structs.getVisitCount();

    assertEq(noVisit.id, address(0));
    assertEq(noVisit.count, 0);

    vm.startPrank(_user);

    vm.expectCall(address(_structs), abi.encodeCall(_structs.countVisit, ()));
    _structs.countVisit();

    VisitCount memory firstVisit = _structs.getVisitCount();

    assertEq(firstVisit.id, _user);
    assertEq(firstVisit.count, 1);

    vm.expectCall(address(_structs), abi.encodeCall(_structs.countVisit, ()));
    _structs.countVisit();

    vm.stopPrank();

    VisitCount memory secondVisit = _structs.getVisitCount();

    assertEq(secondVisit.id, _user);
    assertEq(secondVisit.count, 2);
  }

  function testGetVisitCount() external {
    VisitCount memory noVisit = _structs.getVisitCount();

    assertEq(noVisit.id, address(0));
    assertEq(noVisit.count, 0);
  }

  function testCreateUserWithShortBio() external {
    vm.startPrank(_user);

    vm.expectCall(
      address(_structs), abi.encodeCall(_structs.createUserWithShortBio, ())
    );
    _structs.createUserWithShortBio();

    vm.stopPrank();

    (Profile memory shortBio,) = _structs.getBios();

    assertEq(shortBio.id, _user);
    assertEq(shortBio.bio, "Lorem ipsum dolor sit aliquam.");
  }

  function testCreateUserWithLongBio() external {
    vm.startPrank(_user);

    vm.expectCall(
      address(_structs), abi.encodeCall(_structs.createUserWithLongBio, ())
    );
    _structs.createUserWithLongBio();

    vm.stopPrank();

    (, Profile memory longBio) = _structs.getBios();

    assertEq(longBio.id, _user);
    assertEq(
      longBio.bio,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in eros sit amet dolor mollis placerat. Ut vel neque ac."
    );
  }

  function testGetBios() external {
    (Profile memory shortBio, Profile memory longBio) = _structs.getBios();

    assertEq(shortBio.id, address(0));
    assertEq(shortBio.bio, "");

    assertEq(longBio.id, address(0));
    assertEq(longBio.bio, "");
  }
}
