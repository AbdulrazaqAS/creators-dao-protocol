// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract DAOAssetsVaultBeacon is UpgradeableBeacon {
    /// @custom:storage-location erc7201:creatorsdao-protocol.DAOAssetsVaultBeacon
    struct DAOAssetsVaultBeaconStorage {
        uint256 totalVaults;
    }

    // keccak256(abi.encode(uint256(keccak256("creatorsdao-protocol.DAOAssetsVaultBeacon")) - 1)) & ~bytes32(uint256(0xff));
    // TODO: Calculate this value
    bytes32 private constant DAOAssetsVaultBeaconStorageLocation = 0x0000000000000000000000000000000000000000000000000000000000000000;

    event VaultCreated(address indexed vault);
    
    constructor(address _impl, address _owner) UpgradeableBeacon(_impl, _owner){}
    
    function deployVault(bytes memory data) external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        _getDAOAssetsVaultBeaconStorage().totalVaults++;
        emit VaultCreated(address(proxy));
        
        return address(proxy);
    }

    /// @dev Returns the storage struct of DAOAssetsVaultBeacon.
    function _getDAOAssetsVaultBeaconStorage() private pure returns (DAOAssetsVaultBeaconStorage storage $) {
        assembly {
            $.slot := DAOAssetsVaultBeaconStorageLocation
        }
    }
}
