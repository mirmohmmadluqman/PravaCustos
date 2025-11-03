// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.20;

contract PravaCustos {
    struct Entity {
        address owner;           // Owner wallet address
        bytes32 passwordHash;    // keccak256(password)
        string ipfsCid;          // Encrypted IPFS CID
        bool exists;             // Entity existence flag
    }

    mapping(bytes32 => Entity) private entities;

    event EntityCreated(bytes32 indexed entityId, address indexed owner, string ipfsCid);
    event OwnershipTransferred(bytes32 indexed entityId, address indexed newOwner, string newIpfsCid);

    modifier onlyEntityOwner(bytes32 entityId) {
        require(entities[entityId].exists, "Entity not found");
        require(entities[entityId].owner == msg.sender, "Not entity owner");
        _;
    }

    function createEntity(
        bytes32 entityId,
        bytes32 passwordHash,
        string calldata ipfsCid
    ) external {
        require(entityId != bytes32(0), "Invalid ID");
        require(passwordHash != bytes32(0), "Invalid password hash");
        require(!entities[entityId].exists, "Entity already exists");

        entities[entityId] = Entity({
            owner: msg.sender,
            passwordHash: passwordHash,
            ipfsCid: ipfsCid,
            exists: true
        });

        emit EntityCreated(entityId, msg.sender, ipfsCid);
    }

    function verifyOwnership(
        bytes32 entityId,
        bytes32 passwordHash
    ) external view returns (bool valid) {
        Entity memory e = entities[entityId];
        if (!e.exists) return false;
        return (e.owner == msg.sender && e.passwordHash == passwordHash);
    }

    function transferOwnership(
        bytes32 entityId,
        bytes32 newPasswordHash,
        string calldata newIpfsCid,
        address newOwner
    ) external onlyEntityOwner(entityId) {
        require(newOwner != address(0), "Invalid new owner");
        require(newPasswordHash != bytes32(0), "Invalid new password hash");

        entities[entityId].owner = newOwner;
        entities[entityId].passwordHash = newPasswordHash;
        entities[entityId].ipfsCid = newIpfsCid;

        emit OwnershipTransferred(entityId, newOwner, newIpfsCid);
    }

    function getEntity(bytes32 entityId)
        external
        view
        onlyEntityOwner(entityId)
        returns (address owner, string memory ipfsCid)
    {
        Entity memory e = entities[entityId];
        return (e.owner, e.ipfsCid);
    }
}
