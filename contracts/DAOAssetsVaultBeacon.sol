// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol"
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract DAOAssetsVaultBeacon is UpgradeableBeacon {
    uint256 public totalVaults;
    
    event VaultCreated(address indexed vault);
    
    constructor(address _impl) UpgradeableBeacon(_impl){}
    
    function deployVault(bytes memory data) external return (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        totalVaults++;
        emit VaultCreated(proxy);
        
        return address(proxy);
    }
};
