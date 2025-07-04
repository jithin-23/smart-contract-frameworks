# Foundry

**Foundry** is a blazing fast, portable, and modular toolkit for Ethereum application development, written in Rust.

It provides a comprehensive suite of tools to build, test, deploy, and interact with smart contracts efficiently.

---

## Components

* **Forge**
  Ethereum testing and deployment framework — similar to Truffle, Hardhat, and DappTools.

* **Cast**
  Swiss army knife CLI tool for interacting with EVM smart contracts, sending transactions, querying chain data, and more.

* **Anvil**
  A local Ethereum node, similar to Ganache or Hardhat Network, for fast local development and testing.

* **Chisel**
  A fast, utilitarian, and verbose Solidity REPL (Read-Eval-Print Loop) for interactive contract experimentation.

---

## Sepolia Deployment Note

To deploy contracts to the **Sepolia testnet** using Foundry:

* Ensure you set the correct Sepolia RPC URL, typically from Infura or Alchemy, in your environment variables, for example:

  ```bash
  SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/<your-infura-api-key>
  ```

* Use this RPC URL in your deploy commands to connect to Sepolia.

---

## Documentation

* Official Foundry Book: [https://book.getfoundry.sh/](https://book.getfoundry.sh/)

* Course Note Link:
  [https://www.ethereum-blockchain-developer.com/courses/ethereum-course-2024/project-erc721-nft-with-remix-truffle-hardhat-and-foundry/deploy-smart-contracts-using-foundry](https://www.ethereum-blockchain-developer.com/courses/ethereum-course-2024/project-erc721-nft-with-remix-truffle-hardhat-and-foundry/deploy-smart-contracts-using-foundry)

---

## Common Commands

### Build contracts

```bash
forge build
```

### Run tests

```bash
forge test
```

### Format Solidity code

```bash
forge fmt
```

### Take gas snapshots

```bash
forge snapshot
```

### Run local Ethereum node (Anvil)

```bash
anvil
```

---

## Deployment Examples

Deploy a contract script with RPC URL and private key:

```bash
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

Deploy and broadcast to Sepolia with verification:

```bash
forge script script/Deploy.sol:SpacebearScript --broadcast --verify --rpc-url ${SEPOLIA_RPC_URL}
```

---

## Interact with contracts using Cast

```bash
cast <subcommand>
```

---

## Help Commands

```bash
forge --help
anvil --help
cast --help
```

---

If you want, I can also help prepare similar docs for Hardhat or Truffle!
