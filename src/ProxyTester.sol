// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {UpgradeProxy} from "./utils/UpgradeProxy.sol";

contract ProxyTester is UpgradeProxy {
    bool public typeSet;

    constructor() {}

    function setType(string memory _proxyType) public {
        require(typeSet == false, "ProxyTester has a proxy type already");
        if (keccak256(bytes(_proxyType)) == keccak256(bytes("uups"))) {
            proxyType = ProxyType.UUPS;
        }
    }
}
