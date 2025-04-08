# ERC20 Hub – Create Your Own Token in One Call

**ERC20 Hub** is an on-chain ERC20 factory contract that enables anyone to create their own standard ERC20 tokens with a single function call.

Whether you're launching a DAO, building a Web3 project, or experimenting with tokenomics, ERC20 Hub provides a simple and trustless way to deploy ERC20 tokens instantly and efficiently.

---

## Deployed Contract

This contract is already deployed on **Base Sepolia** testnet:

> **Contract Address:** `0x0af2E347f2F609c08b6F261b1c14ebEF886fE482`  
> **Network:** Base Sepolia  
> **Explorer:** [BaseScan (testnet)](https://sepolia.basescan.org/address/0x0af2E347f2F609c08b6F261b1c14ebEF886fE482)

You can directly call the `createToken` function on this contract to deploy your own token.

---

## Motivation

To address the growing demand for ERC20 token creation, and to avoid the redundancy of having countless copies of identical ERC20 code deployed on-chain, this project separates and standardizes the ERC20 logic into a reusable and centralized factory contract.

By doing so, developers and users can efficiently launch their own tokens without duplicating code, reducing gas costs and promoting cleaner smart contract architecture.

---

## Features

- One-call token creation
- ERC20 logic is shared and efficient via EIP-1167 proxy clones
- Uses OpenZeppelin’s `Clones` for lightweight deployments
- Fixed 18 decimal precision for all tokens
- Fully on-chain and permissionless — no off-chain services required

---

## How to Use

The `createToken` function allows any wallet to deploy a new ERC20 token by specifying the name, symbol, and total supply.

---

### Function

```solidity
function createToken(
    string memory name,
    string memory symbol,
    uint256 totalSupply
) external returns (address token);
