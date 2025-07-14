// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol"
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import {DAOGovernorProxy} from "./DAOGovernorProxy.sol";

contract DAOGovernorBeacon is UpgradeableBeacon {
    uint256 public totalDaos;
    
    event DAOCreated(address indexed dao);
    
    constructor(address _impl) UpgradeableBeacon(_impl){}
    
    function deployDAO(bytes memory data) external return (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);

        totalDaos++;
        emit DAOCreated(proxy);
        
        return address(proxy);
    }
};
