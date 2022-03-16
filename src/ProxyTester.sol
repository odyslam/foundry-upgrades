// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {UpgradeProxy} from "./utils/UpgradeProxy.sol";

contract ProxyTester is UpgradeProxy{

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




}
