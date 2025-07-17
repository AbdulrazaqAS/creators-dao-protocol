// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { EnumerableSet } from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import { IDAOStorage } from "./interfaces/IDAOStorage.sol";
import { Errors } from "./lib/Errors.sol";

abstract contract DAOStorage is IDAOStorage, Initializable {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet writers;
    mapping(bytes32 key => bytes value) bytesData;
    mapping(bytes32 key => bytes32 value) bytes32Data;

    modifier onlyWriters() {
        if (!writers.contains(msg.sender))
            revert Errors.IDAOStorage_Unauthorized();
        _;
    }

    function __DAOStorage_init(address[] memory _writers) public onlyInitializing {
        uint256 len = _writers.length;
        require(len > 0, "No writer added");

        for (uint256 i=0; i<len; i++)
            addWriter(_writers[i]);
    }

    function addWriter(address addr) public onlyWriters {
        if (addr == address(0))
            revert Errors.ZeroAddressNotAllowed();
        if (!writers.add(addr))
            revert Errors.IDAOStorage_WriterAlreadyAdded();

        emit WriterAdded(addr);
    }

    function removeWriter(address addr) external onlyWriters {
        if (!writers.remove(addr))
            revert Errors.IDAOStorage_WriterNotFound();

        emit WriterRemoved(addr);
    }

    function getWriters() external view returns (address[] memory) {
        return writers.values();
    }

    function setBytes(bytes32 key, bytes calldata value) external onlyWriters {
        bytesData[key] = value;
    }

    function setBytes32(bytes32 key, bytes32 value) external onlyWriters {
        bytes32Data[key] = value;
    }

    function getBytes(bytes32 key) external view returns (bytes memory) {
        return bytesData[key];
    }

    function getBytes32(bytes32 key) external view returns (bytes32) {
        return bytes32Data[key];
    }
}