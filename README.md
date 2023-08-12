# FundMe Solidity Smart Contract

![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
![Ethereum](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)

This repository contains a Solidity smart contract called FundMe. The FundMe contract allows users to send Ether (ETH) to the contract and become funders. It enforces a minimum amount requirement in USD for the sent Ether. The contract owner can withdraw all the funds accumulated from the funders.

## Table of Contents

- [Introduction](#introduction)
- [Contract Details](#contract-details)
- [Usage](#usage)
- [License](#license)

## Introduction

The FundMe contract is designed to facilitate fundraising by allowing users to send Ether to the contract, becoming funders in the process. It utilizes the `PriceConverter` library to check whether the sent Ether amount is equivalent to or greater than a specified minimum amount in USD. If the minimum amount is not met, the transaction reverts to prevent the contract from being funded with insufficient funds.

The contract owner, who is set upon deployment, has the ability to withdraw all the accumulated funds. The contract also provides fallback and receive functions to automatically execute the funding process when ETH is sent to the contract address directly.

## Contract Details

The `FundMe` contract contains the following key components:

- `MINIMUM_USD`: A constant representing the minimum amount in USD that a funder must send to the contract.
- `funders`: An array containing the addresses of all funders who have contributed to the contract.
- `addressToAmountFunded`: A mapping that keeps track of the amount funded by each funder.
- `i_owner`: An immutable variable storing the address of the contract owner.

The contract features the following functions:

- `fund()`: Allows users to send Ether to the contract, becoming funders if the minimum amount requirement is met.
- `withdraw()`: Allows the contract owner to withdraw all accumulated funds from the contract and distribute them to the funders.
- `onlyOwner()`: A modifier that restricts access to certain functions to the contract owner.

## Usage

To use the FundMe contract, follow these steps:

1. Deploy the contract to the Ethereum network.
2. Set the contract owner's address during deployment.
3. Fund the contract by sending Ether to it using the `fund()` function.
4. The contract enforces a minimum amount in USD for funding. Ensure that the sent Ether meets this requirement.
5. The contract owner can withdraw all the accumulated funds using the `withdraw()` function.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
