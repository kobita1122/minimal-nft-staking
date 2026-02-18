// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title NFTStaking
 * @dev High-quality staking contract for ERC721 rewards.
 */
contract NFTStaking is Ownable {
    IERC721 public nftCollection;
    IERC20 public rewardsToken;

    uint256 public rewardRatePerHour = 10 * 10**18; // 10 tokens per hour

    struct Stake {
        address owner;
        uint256 timestamp;
    }

    mapping(uint256 => Stake) public vault;

    constructor(address _nft, address _rewardToken) Ownable(msg.sender) {
        nftCollection = IERC721(_nft);
        rewardsToken = IERC20(_rewardToken);
    }

    function stake(uint256 tokenId) external {
        nftCollection.transferFrom(msg.sender, address(this), tokenId);
        vault[tokenId] = Stake(msg.sender, block.timestamp);
    }

    function calculateRewards(uint256 tokenId) public view returns (uint256) {
        Stake memory deposited = vault[tokenId];
        uint256 stakedDuration = block.timestamp - deposited.timestamp;
        return (stakedDuration * rewardRatePerHour) / 3600;
    }

    function unstake(uint256 tokenId) external {
        require(vault[tokenId].owner == msg.sender, "Not the owner");
        
        uint256 reward = calculateRewards(tokenId);
        delete vault[tokenId];

        rewardsToken.transfer(msg.sender, reward);
        nftCollection.transferFrom(address(this), msg.sender, tokenId);
    }
}
