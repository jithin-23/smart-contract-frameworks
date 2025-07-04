# 🧠 Smart Wallet Contract Deployment & Interaction (Foundry + Anvil)

---

## ✅ Prerequisites

* [Foundry installed](https://book.getfoundry.sh/getting-started/installation)
* Project initialized with `forge init`
* Smart wallet contract ready (e.g. `SmartWallet.sol`)

---

## 🚀 Start Local Blockchain with Anvil

```bash
anvil
```

This launches a local Ethereum node with 10 funded test accounts.

### 🔐 Available Accounts

| Index | Address                                      | Balance   |
| ----- | -------------------------------------------- | --------- |
| 0     | `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266` | 10000 ETH |
| 1     | `0x70997970C51812dc3A010C7d01b50e0d17dc79C8` | 10000 ETH |
| 2     | `0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC` | 10000 ETH |
| ...   | ...                                          | ...       |

### 🔑 Private Keys

| Index | Private Key                                                          |
| ----- | -------------------------------------------------------------------- |
| 0     | `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` |
| 1     | `0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d` |
| 2     | `0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a` |
| ...   | ...                                                                  |

---

## 🛠️ Deploy Smart Wallet Contract

```bash
forge script script/DeployWallet.s.sol:SmartWalletScript \
  --rpc-url http://127.0.0.1:8545 \
  --broadcast
```

**Contract deployed at:**

```
0x5FbDB2315678afecb367f032d93F642f64180aa3
```

---

# ⚡ Interacting with the Smart Wallet Contract

---

## ✅ Option 1: Interact Using `cast` CLI

### 🔎 View Owner

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "owner()(address)" \
  --rpc-url http://127.0.0.1:8545
```

---

### 💰 View Wallet Balance

**Owner (must provide `--from`):**

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "viewBalance()(uint)" \
  --rpc-url http://127.0.0.1:8545 \
  --from 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
```

**Non-owner (will revert):**

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "viewBalance()(uint)" \
  --rpc-url http://127.0.0.1:8545 \
  --from 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
```

> ⚠️ `cast call` is unsigned; specifying `--from` simulates caller identity.

---

### 📨 Send ETH to Wallet

**From Owner:**

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  --value 1ether \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --rpc-url http://127.0.0.1:8545
```

**From Non-owner:**

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  --value 10ether \
  --private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d \
  --rpc-url http://127.0.0.1:8545
```

---

### 🔐 Set Allowance (Owner Only)

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "setAllowance(address,uint256)" \
  0x70997970C51812dc3A010C7d01b50e0d17dc79C8 4000000000000000000 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --rpc-url http://127.0.0.1:8545
```

---

### 👀 View Allowance

```bash
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "viewMyAllowance()(uint)" \
  --rpc-url http://127.0.0.1:8545 \
  --from 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
```

---

### 💸 Transfer Funds (Spender to Receiver)

```bash
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 \
  "transferFunds(address,uint256)" \
  0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC 12345678900000000 \
  --private-key 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d \
  --rpc-url http://127.0.0.1:8545
```

---

## 📊 Check Account Balance (Anvil)

```bash
cast balance 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC \
  --rpc-url http://127.0.0.1:8545
```

---

## ✅ Option 2: Interact with Script

Deploy and interact using a Foundry script:

```bash
forge script script/InteractWalletAnvil.s.sol:InteractWalletScript \
  --rpc-url http://127.0.0.1:8545 \
  --broadcast
```

### 📝 Example Script (InteractWalletAnvil.s.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/SmartWallet.sol";

contract InteractWalletScript is Script {
    SmartWallet wallet;

    address walletAddress = 0x5FbDB2315678afecb367f032d93F642f64180aa3;

    // Account 1: Owner
    address account1Public = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 account1Private = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    // Account 2: Spender
    address account2Public = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    uint256 account2Private = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;

    // Account 3: Receiver
    address account3Public = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
    uint256 account3Private = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;

    function setUp() public {
        wallet = SmartWallet(payable(walletAddress));
    }

    function run() public {
        // Log owner
        address contractOwner = wallet.owner();
        console.log("Wallet owner is:", contractOwner);

        // Deposit ETH to wallet (owner)
        vm.startBroadcast(account1Private);
        (bool sent, ) = payable(walletAddress).call{value: 1 ether}("");
        require(sent, "Transfer failed");
        vm.stopBroadcast();

        // View wallet balance
        vm.startBroadcast(account1Private);
        uint balance = wallet.viewBalance();
        console.log("Wallet balance:", balance);
        vm.stopBroadcast();

        // Set allowance (owner)
        vm.startBroadcast(account1Private);
        wallet.setAllowance(account2Public, 4 ether);
        vm.stopBroadcast();

        // View allowance (spender)
        vm.startBroadcast(account2Private);
        uint allowance = wallet.viewMyAllowance();
        console.log("Account 2 allowance:", allowance);

        // Transfer ETH from wallet (spender)
        wallet.transferFunds(payable(account3Public), 0.012 ether);
        vm.stopBroadcast();

        // Log new balance of account 3
        console.log("Account 3 new balance:", account3Public.balance);
    }
}
```

---

# 🧰 Foundry Script Execution: Phases & Options

When running scripts with `forge script`, Foundry executes in **two phases**:

### ⚙️ 1. Simulation Phase (Dry Run)

* Runs the full script logic locally
* Executes `console.log(...)` statements
* Estimates gas and checks for reverts
* No real transactions are sent
* Always runs first unless `--skip-simulation` is passed

### 🚀 2. Broadcast Phase (Live Execution)

* Runs only if `--broadcast` flag is given
* Executes real on-chain transactions inside `vm.startBroadcast(...)` blocks
* Signs and sends transactions to the specified network
* Prints transaction hashes, gas used, block number
* Does **not** execute `console.log(...)` during this phase

---

### 🔧 Key CLI Options

| Flag                | Description                                   |
| ------------------- | --------------------------------------------- |
| `--broadcast`       | Send real transactions on-chain               |
| `--rpc-url`         | Specify target network RPC endpoint           |
| `--sig-check`       | Simulate and verify signatures (no broadcast) |
| `--skip-simulation` | Skip local simulation; only send transactions |
| `--silent`          | Suppress console output                       |
| `--dry-run` (alias) | Just simulate without broadcasting            |

---

## ✅ Option 3: Interact via JavaScript (Frontend)

```js
import { ethers } from "ethers";
import abi from "./SmartWalletABI.json";

async function main() {
  const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");
  const signer = provider.getSigner(0); // First Anvil account

  const walletAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3"; // Your deployed contract address
  const wallet = new ethers.Contract(walletAddress, abi, signer);

  // Set allowance for a spender
  await wallet.setAllowance("0x70997970C51812dc3A010C7d01b50e0d17dc79C8", ethers.parseEther("1.0"));

  // View balance (owner only)
  const balance = await wallet.viewBalance();
  console.log("Wallet balance:", ethers.formatEther(balance));
}

main().catch(console.error);
```

---

## ✅ Option 4: Use Remix IDE with Anvil

1. Open [Remix IDE](https://remix.ethereum.org/)
2. Go to **Deploy & Run Transactions** tab
3. Select **Custom HTTP Provider** in Environment dropdown
4. Enter RPC URL: `http://127.0.0.1:8545`
5. Paste your contract ABI and address
6. Interact using Remix’s GUI

---

## ✅ Option 5: Interact Using Raw JSON-RPC with cURL (Advanced)

```bash
curl -X POST http://127.0.0.1:8545 \
  -H "Content-Type: application/json" \
  --data '{
    "jsonrpc": "2.0",
    "method": "eth_call",
    "params": [{
      "to": "0x5FbDB2315678afecb367f032d93F642f64180aa3",
      "data": "0x8da5cb5b"   // owner() function selector
    }, "latest"],
    "id": 1
  }'
```

> **Note:** The `data` is the function selector (first 4 bytes of keccak256 hash of the signature). Use `cast` or ethers.js to encode function calls.

