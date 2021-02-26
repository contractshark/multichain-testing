# Time Dependency Simulator 

## Overview

- `results`: Results of the simulations
- `scripts`: Helper scripts to start `geth`
- `solidity`: Solidity smart contracts
- `src`: Off-chain components and Node.js framework
  - `/keys`: Private keys of all pre-funded accounts in the genesis block
  - `/providers`: Off-chain oracle provider code
  - `/simulation`: Simulation logic

## Oracle Naming

The oracles and deferred choice smart contracts follow a common naming scheme:

- `Future` refers to publish-subscribe oracles, the prefix `Present` refers to storage and request-response oracles.

- `Past` refers to history oracles.

- `Sync` and `Async` refer to synchronous on-chain and asynchronous off-chain oracles, respectively.

- `Cond` designates conditional variants of oracles.

## Running the Simulations

### Installation
To run the simulations, you will need to have the following packages installed:

- [Node.js](https://nodejs.org/en/download/), tested with version `v12.18.3` and npm `6.14.6`
- [Go Ethereum](https://geth.ethereum.org/downloads/) (`geth`), tested with version `1.9.21-stable`

Everything else is then installed via npm:

```bash
npm install
```

### Starting `geth`
The simulations require certain accounts to be pre-funded.
A custom genesis block and a helpful cleanup/startup script are located in the `scripts` folder:

```bash
cd scripts
./geth.sh
```

### Simulations
There are two simulations:

- `npm run correctness`: Starts the correctness simulation
- `npm run cost`: Starts the cost simulation

Both simulations will output information to the console and a CSV file.


