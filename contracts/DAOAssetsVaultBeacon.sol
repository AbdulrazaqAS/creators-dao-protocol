// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract DAOAssetsVaultBeacon is UpgradeableBeacon {
    uint256 public totalVaults;
    
    event VaultCreated(address indexed vault);
    
    constructor(address _impl, address _owner) UpgradeableBeacon(_impl, _owner){}
    
    function deployVault(bytes memory data) external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        totalVaults++;
        emit VaultCreated(address(proxy));
        
        return address(proxy);
    }
}
