// SPDX-FileCopyrightText: 2021 ShardLabs
// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.7;

/// @title INodeOperatorRegistry
/// @author 2021 ShardLabs
/// @notice Node operator registry interface
interface INodeOperatorRegistry {
    /// @notice Node Operator Registry Statuses
    /// StakeManager statuses: https://github.com/maticnetwork/contracts/blob/v0.3.0-backport/contracts/staking/stakeManager/StakeManagerStorage.sol#L13
    /// ACTIVE: (validator.status == status.Active && validator.deactivationEpoch == 0)
    /// JAILED: (validator.status == status.Locked && validator.deactivationEpoch == 0)
    /// EJECTED: ((validator.status == status.Active || validator.status == status.Locked) && validator.deactivationEpoch != 0)
    /// UNSTAKED: (validator.status == status.Unstaked)
    enum NodeOperatorRegistryStatus {
        ACTIVE,
        JAILED,
        EJECTED,
        UNSTAKED
    }

    /// @notice The full node operator struct.
    /// @param validatorId the validator id on stakeManager.
    /// @param validatorShare the validator share address of the validator.
    /// @param rewardAddress the reward address.
    /// @param status the status of the node operator in the stake manager.
    struct FullNodeOperatorRegistry {
        uint256 validatorId;
        address validatorShare;
        address rewardAddress;
        NodeOperatorRegistryStatus status;
    }

    /// @notice The node operator struct
    /// @param validatorShare the validator share address of the validator.
    /// @param rewardAddress the reward address.
    struct NodeOperatorRegistry {
        address validatorShare;
        address rewardAddress;
    }

    /// @notice Add a new node operator registry to the system.
    /// ONLY DAO can execute this function.
    /// @param _validatorId the validator id on stakeManager.
    /// @param _rewardAddress the reward address.
    function addNodeOperatorRegistry(
        uint256 _validatorId,
        address _rewardAddress
    ) external;

    /// @notice Remove a new node operator registry from the system and
    /// ONLY DAO can execute this function.
    /// withdraw delegated tokens from it.
    /// @param _validatorId the validator id on stakeManager.
    function removeNodeOperatorRegistry(uint256 _validatorId) external;

    /// @notice Set StMatic address.
    /// ONLY DAO can call this function
    /// @param _newStMatic new stMatic address.
    function setStMaticAddress(address _newStMatic) external;

    /// @notice Update reward address of a Node Operator Registry.
    /// ONLY Operator owner can call this function
    /// @param _newRewardAddress the new reward address.
    function setRewardAddress(address _newRewardAddress) external;

    /// @notice List all node operator registry available in the system.
    /// @return Returns a list of Active node operator registry.
    function listAllNodeOperatorRegistry()
        external
        view
        returns (NodeOperatorRegistry[] memory);

    /// @notice List all the ACTIVE operators on the stakeManager.
    /// @return Returns a list of ACTIVE node operator registry.
    function listActiveNodeOperatorRegistry()
        external
        view
        returns (NodeOperatorRegistry[] memory);

    /// @notice List all the ACTIVE, JAILED and EJECTED operators on the stakeManager.
    /// @return Returns a list of ACTIVE, JAILED and EJECTED node operator registry.
    function listDelegatedNodeOperatorRegistry()
        external
        view
        returns (NodeOperatorRegistry[] memory);

    /// @notice Returns a node operator registry.
    /// @param _validatorId the validator id on stakeManager.
    /// @return Returns a node operator registry.
    function getNodeOperatorRegistry(uint256 _validatorId)
        external
        view
        returns (FullNodeOperatorRegistry memory);

    /// @notice Returns a node operator registry.
    /// @param _rewardAddress the reward address.
    /// @return Returns a node operator registry.
    function getNodeOperatorRegistry(address _rewardAddress)
        external
        view
        returns (FullNodeOperatorRegistry memory);

    /// @notice List all the node operator registry in the system.
    /// @return activeNodeOperator the number of active operators.
    /// @return jailedNodeOperator the number of jailed operators.
    /// @return ejectedNodeOperator the number of ejected operators.
    /// @return unstakedNodeOperator the number of unstaked operators.
    function getStats()
        external
        view
        returns (
            uint256 activeNodeOperator,
            uint256 jailedNodeOperator,
            uint256 ejectedNodeOperator,
            uint256 unstakedNodeOperator
        );

    // ***********************************EVENTS***********************************
    /// @notice Add Node Operator Registry event
    /// @param validatorId validator id.
    /// @param rewardAddress reward address.
    event AddNodeOperatorRegistry(uint256 validatorId, address rewardAddress);

    /// @notice Remove Node Operator Registry event.
    /// @param validatorId validator id.
    /// @param rewardAddress reward address.
    event RemoveNodeOperatorRegistry(
        uint256 validatorId,
        address rewardAddress
    );

    /// @notice Set StMatic address event.
    /// @param oldStMatic old stMatic address.
    /// @param newStMatic new stMatic address.
    event SetStMaticAddress(address oldStMatic, address newStMatic);

    /// @notice Set reward address event.
    /// @param oldRewardAddress old reward address.
    /// @param newRewardAddress new reward address.
    event SetRewardAddress(address oldRewardAddress, address newRewardAddress);
}
