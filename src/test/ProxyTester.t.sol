// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {console} from "forge-std/console.sol";
import {ProxyTester} from "../ProxyTester.sol";

/*
TODO:
- Create a test to showcase the library
- Go over the cheatcodes + OZ docs and think of tests you can add into the code
- Add cheatcodes for added functionality (e.g storage slot) into the tester
*/

contract UpgradeTest is DSTest {
    ProxyTester proxy;

    address[] public implementations;

    address proxyAddress;

    Vm constant vm =
        Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function setUp() public {
        proxy = new ProxyTester();
        implementations = vm.addr(5);
    }

    function testDeployUUPS() public {
        proxy.setType(ProxyTester.ProxyType.UUPS);
        proxyAddress = proxy.deploy(implementations[0], "");
        assertEq(proxyAddress, proxy.proxyAddress);
        console.log("Address of proxy is %s", proxyAddress);
    }

    function testDeployBeacons(uint256 numberOfProxies) public {
        address beacon;
    }
}
