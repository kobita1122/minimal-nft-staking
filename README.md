# Decentralized NFT Staking Protocol

This repository implements a high-quality staking mechanism for NFT collections. It enables holders to "lock" their assets in a secure vault to accumulate yield in a secondary utility token.

## Technical Architecture
- **Vault System**: Securely holds ERC-721 tokens while tracking ownership.
- **Reward Engine**: Calculates rewards per block based on a fixed emission rate.
- **Claiming Logic**: Allows users to harvest earned tokens without unstaking.

## Workflow
1. **Approve**: User approves the Staking contract to move their NFT.
2. **Stake**: User transfers the NFT to the contract.
3. **Yield**: Rewards accrue based on the time elapsed.
4. **Unstake/Claim**: User withdraws the NFT and receives the accumulated reward tokens.

## License
MIT
