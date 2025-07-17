// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IDAOStorage {
    event WriterAdded(address indexed writer);
    event WriterRemoved(address indexed writer);

    function addWriter(address writer) external;
    function removeWriter(address writer) external;
    function getWriters() external view returns (address[] memory);
    function setBytes(bytes32 key, bytes calldata value) external;
    function setBytes32(bytes32 key, bytes32 value) external;
    function getBytes(bytes32 key) external view returns (bytes memory);
    function getBytes32(bytes32 key) external view returns (bytes32);
}