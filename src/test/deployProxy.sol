// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;


import {ERC1967Proxy} from "openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";
import {TransparentUpgradeableProxy} from "openzeppelin/proxy/transparent/TransparentUpgradeableProxy.sol";
import {BeaconProxy} from "openzeppelin/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "openzeppelin/proxy/beacon/Upgradeablebeacon.sol";
contract DeployProxy {

    /// Proxy
    ERC1967Proxy public erc1967Proxy;
    UpgradeableBeacon public upgradeableBeacon;
    BeaconProxy public beaconProxy;
    TransparentUpgradeableProxy public uupsProxy;


    enum proxyType {
        UUPS,
        Beacon,
        Transparent
    }

    function deployProxy(proxyType proxy, address implementation, address admin, bytes memory data) public {
        if (proxy == proxyType.Transparent) {
            deployErc1967Proxy(implementation, data);
        }
        else if (proxy == proxyType.UUPS) {
            deployUupsProxy(implementation, admin, data);
        }
        else if (proxy == proxyType.Beacon) {
            deployBeaconProxy(implementation, data);
        }
    }

    function deployBeaconProxy(address implementation, bytes memory data) public {
        upgradeableBeacon = new UpgradeableBeacon(implementation);
        beaconProxy = new BeaconProxy(address(upgradeableBeacon), data);
    }

    function deployErc1967Proxy(address implementation, bytes memory data) public {
        erc1967Proxy = new ERC1967Proxy(implementation, data);
    }

    function deployUupsProxy(address implementation, address admin, bytes memory data) public {
        uupsProxy = new TransparentUpgradeableProxy(implementation, admin, data);

}
}
