// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { EnumerableSet } from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import { Errors } from "./lib/Errors.sol";

contract IDAOStorage {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet allowList;
    mapping(bytes32 key => bytes value) bytesData;
    mapping(bytes32 key => bytes32 value) bytes32Data;

    modifier onlyAllowed() {
        if (!allowList.contains(msg.sender))
            revert Errors.IDAOStorage_Unauthorized();
        _;
    }

    event AllowedAdded(address indexed addr);
    event AllowedRemoved(address indexed addr);

    function addAllowed(address addr) external onlyAllowed {
        if (addr == address(0))
            revert Errors.ZeroAddressNotAllowed();
        if (!allowList.add(addr))
            revert Errors.IDAOStorage_AddrAlreadyAdded();

        emit AllowedAdded(addr);
    }

    function removeAllowed(address addr) external onlyAllowed {
        if (!allowList.remove(addr))
            revert Errors.IDAOStorage_AddrNotFound();

        emit AllowedRemoved(addr);
    }

    function getAllowedList() external view returns (address[] memory) {
        return allowList.values();
    }

    function setBytes(bytes32 key, bytes calldata value) external onlyAllowed {
        bytesData[key] = value;
    }

    function setBytes32(bytes32 key, bytes32 value) external onlyAllowed {
        bytes32Data[key] = value;
    }

    function getBytes(bytes32 key) external view returns (bytes memory) {
        return bytesData[key];
    }

    function getBytes32(bytes32 key) external view returns (bytes32) {
        return bytes32Data[key];
    }
}