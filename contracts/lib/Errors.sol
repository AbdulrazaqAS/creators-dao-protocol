// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library Errors {
    error ZeroAddressNotAllowed();

    /////////////// IDAOStorage ///////////////

    /// @notice Caller not allowed for the operation
    error IDAOStorage_Unauthorized();

    error IDAOStorage_WriterAlreadyAdded();
    error IDAOStorage_WriterNotFound();
}