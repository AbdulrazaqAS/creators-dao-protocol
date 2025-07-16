// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract DAOGovernorBeacon is UpgradeableBeacon {
    /// @custom:storage-location erc7201:creatorsdao-protocol.DAOGovernorBeacon
    struct DAOGovernorBeaconStorage {
        uint256 totalDaos;
    }

    // keccak256(abi.encode(uint256(keccak256("creatorsdao-protocol.DAOGovernorBeacon")) - 1)) & ~bytes32(uint256(0xff));
    // TODO: Calculate this value
    bytes32 private constant DAOGovernorBeaconStorageLocation = 0x0000000000000000000000000000000000000000000000000000000000000000;

    event DAOCreated(address indexed dao);

    constructor(address _impl, address _owner) UpgradeableBeacon(_impl, _owner) {}

    function deployDAO(bytes memory data) external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        _getDAOGovernorBeaconStorage().totalDaos++;
        emit DAOCreated(address(proxy));
        
        return address(proxy);
    }
    
    /// @dev Returns the storage struct of DAOGovernorBeacon.
    function _getDAOGovernorBeaconStorage() private pure returns (DAOGovernorBeaconStorage storage $) {
        assembly {
            $.slot := DAOGovernorBeaconStorageLocation
        }
    }
}
