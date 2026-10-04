Freelancing DApp

A decentralized freelancing platform built with Solidity.
The project is designed to demonstrate how a blockchain-based platform can connect clients and freelancers through a smart contract, without relying on a centralized intermediary.

🚀 Project Overview

The Freelancing DApp allows users to create and manage freelance jobs on-chain.

The smart contract keeps track of:

Job details

Client and freelancer addresses

Job bounty

Job status

Freelancer reputation

Platform listing fee

The contract uses Ethereum-compatible blockchain functionality and is intended as a learning project while exploring Web3, Solidity, and smart contract development.

🏗️ Smart Contract

Main contract:

FreelancingPlatform

Main source file:

Contracts/FreelancingPlatform.sol

Job Lifecycle

Each job can move through the following statuses:

Open → Taken → Completed

A job can also be:

Open → Canceled

The contract defines these states using the JobStatus enum:

enum JobStatus {
    Open,
    Taken,
    Completed,
    Canceled
}

📦 Job Structure

Each job stores important information such as:

struct Job {
    string title;
    string description;
    uint256 bounty;
    address client;
    address freelancer;
    JobStatus status;
}

This allows the smart contract to associate a job with its client, freelancer, payment, description, and current state.

🔐 Access Control

The project uses Solidity access-control patterns to restrict sensitive operations.

For example, administrative functionality can be restricted to the contract owner using:

onlyOwner

This helps prevent unauthorized users from changing platform-level settings.

💰 Platform Fees

The contract includes a configurable listing fee for creating jobs.

The owner can update the listing fee through:

setListingFee()

The contract also provides a function to check the platform's current balance:

getPlatformBalance()

⭐ Reputation System

The platform includes a freelancer reputation mechanism.

When a client successfully completes a job, the freelancer receives a reputation reward:

freelancerReputation[freelancer] += reputationReward;

This creates an on-chain reputation record that can be used to represent a freelancer's completed work.

📢 Events

The smart contract emits events when important actions happen.

Events make it possible for a frontend DApp to listen for blockchain activity and update the user interface accordingly.

🛠️ Technologies

Solidity

Ethereum / EVM

Remix IDE

Git & GitHub

Smart Contracts

Blockchain / Web3

📁 Project Structure

Freelancing-Dapp/
│
├── Contracts/
│   └── FreelancingPlatform.sol
│
├── README.md
├── remix.config.json
└── .prettierrc.json

Generated Remix folders such as .states, .deps, and artifacts may be environment-specific and do not necessarily need to be committed to the repository.

▶️ How to Run

1. Open the project

Open the project in Remix IDE.

2. Open the contract

Navigate to:

Contracts/FreelancingPlatform.sol

3. Compile

Use the Solidity Compiler in Remix and select a compatible Solidity 0.8.x compiler version.

4. Deploy

Open Deploy & Run Transactions and deploy:

FreelancingPlatform

You can initially test the contract using Remix's local JavaScript VM environment.

For public testnet deployment, connect Remix to a compatible wallet and select the desired test network.

🧪 Testing

The contract can be tested directly through Remix by:

Deploying the contract.

Creating a job.

Interacting with the job functions.

Testing different users/accounts.

Taking and completing jobs.

Checking job status and freelancer reputation.

Testing administrative functions such as changing the listing fee.

⚠️ Disclaimer

This project is built for educational purposes and should not be considered production-ready financial software.

Before deploying to a real network, the smart contract should undergo thorough testing, security review, and professional auditing.

📚 Learning Goals

This project was created to practice and understand:

Solidity smart contract development

Structs and enums

Functions and modifiers

Access control

Events

Ether and contract balances

On-chain state management

Smart contract interactions

Git and GitHub workflow

Building the foundation of a decentralized application

👨‍💻 Author

Built as part of my Web3 & Blockchain learning journey.

⭐ If you find this project useful, feel free to explore the code and follow the development of the project.
