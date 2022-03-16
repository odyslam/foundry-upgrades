// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {ProxyTester} from "../ProxyTester.sol";
import {console} from "forge-std/console.sol";

contract UpgradeTest is DStest, ProxyTester{
    address impl = vm.addr(1);
    UpgradeProxy proxyTester = new UpgradeProxy();
    function setUp() public {}
    function testDeployUUPS() public {
        proxy = proxyTester.deploy(ProxyTester.proxyType.UUPS, impl);
        console.log("Address of proxy is %s", address(proxy.uupsProxy));
    }

    function testDeployBeacons(uint256 numberOfProxies) public {
        address beacon;
        address[] beaconProxies = address[](4);
        (beaconProxies, beacon) = proxyTester.deploy(Proxytester.proxyType.Beacon, impl, 4);
    }
}
