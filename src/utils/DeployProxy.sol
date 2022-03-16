// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

// Import OZ Proxy contracts
import {ERC1967Proxy} from "openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";
import {TransparentUpgradeableProxy} from "openzeppelin/proxy/transparent/TransparentUpgradeableProxy.sol";
import {BeaconProxy} from "openzeppelin/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "openzeppelin/proxy/beacon/Upgradeablebeacon.sol";
import {Vm} from "forge-std/Vm.sol";

contract DeployProxy {

    /// Cheatcodes address
    Vm constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    enum proxyType {
        UUPS,
        Beacon,
        Transparent
    }

    function deployBeacon(address impl) public returns(UpgradeableBeacon){
            UpgradeableBeacon ub = new UpgradeableBeacon(impl);
            vm.label(address(ub), "Upgradeable Beacon");
            return ub;
    }

    function deployBeaconProxy(UpgradeableBeacon ub,  bytes memory data) public returns (UpgradeableBeacon, BeaconProxy){
        BeaconProxy beaconProxy = new BeaconProxy(address(ub), data);
        vm.label(address(beaconProxy), "Beacon Proxy");
        return (upgradeableBeacon, beaconProxy);
    }

    function deployErc1967Proxy(address implementation, bytes memory data) public returns(ERC1967Proxy){
        ERC1967Proxy erc1967Proxy = new ERC1967Proxy(implementation, data);
        vm.label(address(erc1967Proxy), "ERC1967 Proxy");
        return erc1967Proxy;
    }

    function deployUupsProxy(address implementation, address admin, bytes memory data) public returns(TransparentUpgradeableProxy){
        TransparentUpgradeableProxy uupsProxy = new TransparentUpgradeableProxy(implementation, admin, data);
        vm.label(address(uupsProxy), "UUPS Proxy");
        return uupsProxy;

    }
}
