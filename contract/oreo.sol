// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title Oreo - Verifiable Result Record System for Schools/Universities
/// @author
/// @notice Minimal contract for storing/verifying student results using hashes (e.g., IPFS or SHA)
/// @dev Keys are created from (studentId, course) to avoid revealing raw studentId on-chain
contract Oreo {
    address public owner;

    struct Result {
        string resultHash;   // e.g., IPFS CID or SHA256 of the result file/data
        string course;       // course name or code
        uint256 timestamp;   // when the result was recorded/updated
        bool exists;         // whether this result exists (not revoked)
    }

    // mapping from keccak256(studentId, course) => Result
    mapping(bytes32 => Result) private results;

    // Events
    event ResultAdded(bytes32 indexed key, string indexed course, uint256 timestamp);
    event ResultUpdated(bytes32 indexed key, string indexed course, uint256 timestamp);
    event ResultRevoked(bytes32 indexed key, string indexed course, uint256 timestamp);
    event OwnerTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Generate the storage key for a student+course pair
    /// @param studentId A non-sensitive identifier (could be hashed off-chain before passing)
    /// @param course Course name or code
    /// @return key keccak256(studentId, course)
    function _key(string memory studentId, string memory course) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(studentId, "|", course));
    }

    /// @notice Add a result record for a student and course
    /// @dev Only owner (school/university) can call
    function addResult(
        string calldata studentId,
        string calldata course,
        string calldata resultHash
    ) external onlyOwner {
        bytes32 k = _key(studentId, course);
        require(!results[k].exists, "Result already exists");

        results[k] = Result({
            resultHash: resultHash,
            course: course,
            timestamp: block.timestamp,
            exists: true
        });

        emit ResultAdded(k, course, block.timestamp);
    }

    /// @notice Update an existing result record (for corrections)
    /// @dev Only owner
    function updateResult(
        string calldata studentId,
        string calldata course,
        string calldata newResultHash
    ) external onlyOwner {
        bytes32 k = _key(studentId, course);
        require(results[k].exists, "No result to update");

        results[k].resultHash = newResultHash;
        results[k].timestamp = block.timestamp;

        emit ResultUpdated(k, course, block.timestamp);
    }

    /// @notice Revoke a result (mark as non-existent)
    /// @dev Only owner — keeps historical key but sets exists = false
    function revokeResult(string calldata studentId, string calldata course) external onlyOwner {
        bytes32 k = _key(studentId, course);
        require(results[k].exists, "No result to revoke");

        results[k].exists = false;
        results[k].timestamp = block.timestamp;

        emit ResultRevoked(k, course, block.timestamp);
    }

    /// @notice Verify whether a given student+course has the provided resultHash
    /// @param studentId student identifier (use the same form used when adding)
    /// @param course course name/code
    /// @param expectedHash hash/CID expected
    /// @return ok true if the stored hash matches expectedHash and record exists
    function verifyResult(
        string calldata studentId,
        string calldata course,
        string calldata expectedHash
    ) external view returns (bool ok) {
        bytes32 k = _key(studentId, course);
        if (!results[k].exists) return false;
        // string equality via keccak256
        return keccak256(bytes(results[k].resultHash)) == keccak256(bytes(expectedHash));
    }

    /// @notice Fetch stored metadata for a student+course (resultHash may be sensitive)
    /// @dev Returns resultHash, course, timestamp, exists
    function getResult(string calldata studentId, string calldata course)
        external
        view
        returns (string memory resultHash, string memory courseOut, uint256 timestamp, bool existsOut)
    {
        bytes32 k = _key(studentId, course);
        Result storage r = results[k];
        return (r.resultHash, r.course, r.timestamp, r.exists);
    }

    /// @notice Transfer contract ownership (e.g., to another admin/address)
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address");
        address prev = owner;
        owner = newOwner;
        emit OwnerTransferred(prev, newOwner);
    }
}

