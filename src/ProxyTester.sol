// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {UpgradeProxy} from "./utils/UpgradeProxy.sol";

contract ProxyTester is UpgradeProxy{

    constructor(ProxyType proxy, address implementation, bytes memory data){
        deployProxy(proxy, implementation, data);
    }
    constructor(ProxyType proxy, address implementation){
        deployProxy(proxy, implementation);
    }
}
