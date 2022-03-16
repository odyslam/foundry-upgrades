// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {Vm} from "forge-std/Vm.sol";
import {DSTest} from "ds-test/test.sol";
import {ProxyTester} from "../ProxyTester.sol";
import {console} from "forge-std/console.sol";

contract UpgradeTest is DStest, ProxyTester{
    ProxyTester proxy ;
    ProxyTester[] proxies;
    address impl = vm.addr(1);
    function setUp() public {
    }
    function testDeploy() public {
        proxy = new ProxyTester(ProxyTester.proxyType.UUPS, impl);
        console.log("Address of proxy is %s", address(proxy.uupsProxy));
    }

    function testDeployBeacons(uint256 numberOfProxies) public {
        address beacon;
        address[] beaconProxies;
        proxy = new ProxyTester(ProxyTester.proxyType.Beacon, impl);
    }
}
