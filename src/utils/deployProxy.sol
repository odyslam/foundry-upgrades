// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

// Import OZ Proxy contracts
import {ERC1967Proxy} from "openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";
import {TransparentUpgradeableProxy} from "openzeppelin/proxy/transparent/TransparentUpgradeableProxy.sol";
import {BeaconProxy} from "openzeppelin/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "openzeppelin/proxy/beacon/Upgradeablebeacon.sol";
import {Vm} from "forge-std/Vm.sol";

contract DeployProxy {

    /// Proxy
    ERC1967Proxy[] public erc1967Proxy;
    UpgradeableBeacon[] public upgradeableBeacon;
    BeaconProxy[] public beaconProxy;
    TransparentUpgradeableProxy[] public uupsProxy;

    enum proxyType {
        UUPS,
        Beacon,
        Transparent
    }

    /// Cheatcodes address
    Vm constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    /// Return an array of addresses (address, address[]) --> (UpgradeableBeacon, BeaconProxies[])
    function deployProxy(proxyType proxy, address implementation, bytes memory data) public returns (address){
        if (proxy == proxyType.Transparent) {
            return deployErc1967Proxy(implementation, data);
        }
        else if (proxy == proxyType.UUPS) {
            revert("UUPS proxies require an admin address");
        }
        else if (proxy == proxyType.Beacon) {
           revert("Beacon returns a tuple of addresses: (upgradeableBeacon, beaconProxy)");
        }
    }

    function deployProxy(proxyType proxy, address implementation, bytes memory data) public returns (address[]){
        if (proxy == proxyType.Transparent) {
            revert("Transparent proxy returns a single address");
        }
        else if (proxy == proxyType.UUPS) {
            revert("UUPS proxies require an admin address");
        }
        else if (proxy == proxyType.Beacon) {
            return deployBeaconProxy(implementation, data);
        }
    }

    function deployProxy(proxyType proxy, address implementation, address admin, bytes memory data) public
    returns(address){
        if (proxy == proxyType.Transparent) {
            revert("proxy implementation does't include admin address");
        }
        else if (proxy == proxyType.UUPS) {
            return deployUupsProxy(implementation, admin, data);
        }
        else if (proxy == proxyType.Beacon) {
            revert("proxy implementation does't include admin address");
        }
    }

    function deployBeaconProxy(address implementation, bytes memory data) public returns (address, address){
        upgradeableBeacon = new UpgradeableBeacon(implementation);
        beaconProxy = new BeaconProxy(address(upgradeableBeacon), data);
        vm.label(address(upgradeableBeacon), "UpgradeableBeacon");
        vm.label(address(beaconProxy), "Beacon Proxy");
        return (address(upgradeableBeacon), address(beaconProxy));
    }

    function deployErc1967Proxy(address implementation, bytes memory data) public returns(address){
        erc1967Proxy = new ERC1967Proxy(implementation, data);
        vm.label(address(erc1967Proxy), "ERC1967 Proxy");
        return address(erc1967Proxy);
    }

    function deployUupsProxy(address implementation, address admin, bytes memory data) public returns(address){
        uupsProxy = new TransparentUpgradeableProxy(implementation, admin, data);
        vm.label(address(uupsProxy), "UUPS Proxy");
        return address(uupsProxy);

    }
}
