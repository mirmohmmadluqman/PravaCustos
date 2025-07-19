// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
pragma solidity ^0.8.20;

contract PravaCustos {
    // Structure to store entity ownership details
    struct Entity {
        address owner; // Wallet address of the owner
        bytes32 passwordHash; // keccak256 hash of the password
        string ipfsCid; // IPFS CID for encrypted data
        bool exists; // Flag to check if entity exists
    }

    // Mapping to store entities by unique ID
    mapping(bytes32 => Entity) public entities;

    // Events for logging
    event EntityCreated(bytes32 indexed entityId, address indexed owner, string ipfsCid);
    event OwnershipVerified(bytes32 indexed entityId, bool success);
    event OwnershipTransferred(bytes32 indexed entityId, address indexed newOwner, string newIpfsCid);

    // Create a new entity
    function createEntity(bytes32 entityId, bytes32 passwordHash, string memory ipfsCid) external {
        require(!entities[entityId].exists, "Entity already exists");
        
        entities[entityId] = Entity({
            owner: msg.sender,
            passwordHash: passwordHash,
            ipfsCid: ipfsCid,
            exists: true
        });
        
        emit EntityCreated(entityId, msg.sender, ipfsCid);
    }

    // Verify ownership with password hash
    function verifyOwnership(bytes32 entityId, bytes32 passwordHash) external view returns (bool) {
        require(entities[entityId].exists, "Entity does not exist");
        return entities[entityId].passwordHash == passwordHash && entities[entityId].owner == msg.sender;
    }

    // Transfer ownership with new password and IPFS CID
    function transferOwnership(bytes32 entityId, bytes32 newPasswordHash, string memory newIpfsCid) external {
        require(entities[entityId].exists, "Entity does not exist");
        require(entities[entityId].owner == msg.sender, "Not the owner");
        
        entities[entityId].passwordHash = newPasswordHash;
        entities[entityId].ipfsCid = newIpfsCid;
        
        emit OwnershipTransferred(entityId, msg.sender, newIpfsCid);
    }

    // Get entity details constituencies
    function getEntity(bytes32 entityId) external view returns (address owner, string memory ipfsCid) {
        require(entities[entityId].exists, "Entity does not exist");
        return (entities[entityId].owner, entities[entityId].ipfsCid);
    }
}
