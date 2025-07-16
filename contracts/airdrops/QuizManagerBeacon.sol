// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract QuizManagerBeacon is UpgradeableBeacon {
    /// @custom:storage-location erc7201:creatorsdao-protocol.QuizManagerBeacon
    struct QuizManagerBeaconStorage {
        uint256 totalQuizManagers;
    }

    // keccak256(abi.encode(uint256(keccak256("creatorsdao-protocol.QuizManagerBeacon")) - 1)) & ~bytes32(uint256(0xff));
    // TODO: Calculate this value
    bytes32 private constant QuizManagerBeaconStorageLocation = 0x0000000000000000000000000000000000000000000000000000000000000000;

    event QuizManagerCreated(address indexed quizManager);
    
    constructor(address _impl, address _owner) UpgradeableBeacon(_impl, _owner){}
    
    function deployVault(bytes memory data) external returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        _getQuizManagerBeaconStorage().totalQuizManagers++;
        emit QuizManagerCreated(address(proxy));
        
        return address(proxy);
    }

    /// @dev Returns the storage struct of QuizManagerStorage.
    function _getQuizManagerBeaconStorage() private pure returns (QuizManagerBeaconStorage storage $) {
        assembly {
            $.slot := QuizManagerBeaconStorageLocation
        }
    }
}
