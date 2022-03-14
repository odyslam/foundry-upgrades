// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import {DeployProxy} from "./deployProxy.sol";
import {ProxyAdmin} from "openzeppelin/proxy/transparent/ProxyAdmin.sol";


contract UpgradeProxy is DeployProxy {

    event Upgraded(address indexed implementation);

    /// @notice Upgrade a proxy smart contract without passing any calldata.
    function upgradeProxy(proxyType proxy, address newImplementation, address admin, address owner) public {
        // Load the expectEmit cheatcode for the Upgraded event. Since it's only a single argument, we only need
        // the first flag set to True.
        vm.expectEmit(true, false, false, false);
        emit Upgraded(newImplementation)
        // Check if the Admin address is a smart contract Admin or an EOA.
        // If it's an admin, the Upgrade will need to pass through the Admin, called by the owner EOA of the admin smart
        // contract.
        // Else, the upgrade function is called directly on the proxy, with the admin making the call.
        // vm.prank tells the Foundry VM to make the call from that particular address.
        if (isContract(admin)){
            vm.prank(owner);
            ProxyAdmin(admin).upgrade(uupsProxy, newImplementation);
        }
        else {
            vm.prank(admin);
            uupsProxy.upgradeTo(newImplementation);
        }
    }

    /// @notice Upgrade a proxy smart contract and also pass calldata to be called with the update.
    function upgradeProxy(proxyType proxy, address newImplementation, bytes memory data, address admin, address owner) public {
        vm.expectEmit(true, false, false, false);
        emit Upgraded(newImplementation)
        if (isContract(admin)){
            vm.prank(owner);
            ProxyAdmin(admin).upgradeAndCall(uupsProxy, newImplementation, data);
        }
        else {
            vm.prank(admin);
            uupsProxy.upgradeToAndCall(newImplementation, data);
    }

    function isContract(address addr) public view returns (bool) {
      uint size;
      assembly { size := extcodesize(addr) }
      return size > 0;
    }
}
