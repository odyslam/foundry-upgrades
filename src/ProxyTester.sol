// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {UpgradeProxy} from "./utils/UpgradeProxy.sol";

contract ProxyTester is UpgradeProxy {
    bool public typeSet;

    constructor() {}

    function setType(ProxyType _proxyType) public {
        require(typeSet == false, "ProxyTester has a proxy type already");
        proxyType = _proxyType;
    }
}
