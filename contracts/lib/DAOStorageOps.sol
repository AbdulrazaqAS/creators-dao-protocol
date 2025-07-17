// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { IDAOStorage } from "../interfaces/IDAOStorage.sol";

library DAOStorageOps {
    function setString(IDAOStorage daoStorage, bytes32 key, string memory value) internal {
        daoStorage.setBytes(key, bytes(value));
    }

    function getString(IDAOStorage daoStorage, bytes32 key) internal view returns (string memory) {
        return string(daoStorage.getBytes(key));
    }

    function setAddress(IDAOStorage daoStorage, bytes32 key, address value) internal {
        daoStorage.setBytes32(key, bytes32(uint256(uint160(value))));
    }

    function getAddress(IDAOStorage daoStorage, bytes32 key) internal view returns (address) {
        return address(uint160(uint256(daoStorage.getBytes32(key))));
    }

    function setUint256(IDAOStorage daoStorage, bytes32 key, uint256 value) internal {
        daoStorage.setBytes32(key, bytes32(value));
    }

    function getUint256(IDAOStorage daoStorage, bytes32 key) internal view returns (uint256) {
        return uint256(daoStorage.getBytes32(key));
    }

    // TODO: Why bytes32(uint256(1)) and not bytes32(1)
    // TODO: What would bytes(1) return
    function setBool(IDAOStorage daoStorage, bytes32 key, bool value) internal {
        daoStorage.setBytes32(key, value ? bytes32(uint256(1)) : bytes32(0));
    }

    function getBool(IDAOStorage daoStorage, bytes32 key) internal view returns (bool) {
        return daoStorage.getBytes32(key) != 0;
    }
}