# NFT Deployment Examples with Truffle, Hardhat, and Foundry

This repository demonstrates how to deploy the same NFT smart contract using three popular Ethereum development frameworks:
- **Truffle**
- **Hardhat**
- **Foundry**

Each folder (`/truffle`, `/hardhat`, `/foundry`) contains an independent setup that deploys the contract to the **Sepolia test network**.

---

## 🔐 Environment Setup

To securely manage sensitive keys and configuration values, each framework expects certain secret files or environment variables:

### 1. `.secret`
This file contains the **12- or 24-word mnemonic** (seed phrase) of the Ethereum wallet you’ll deploy from — typically the same one used in MetaMask.

**Example** (`.secret`):
```

candy maple cake sugar pudding cream honey rich smooth crumble sweet treat

```

> ⚠️ Never share this phrase publicly or commit it to GitHub!

---

### 2. `.infura`
This file should contain your **Infura project endpoint** URL for the Sepolia network, used to send transactions.

**Example** (`.infura`):
```

YOUR\_INFURA\_PROJECT\_ID

```

You can get this from [infura.io](https://infura.io).

---

### 3. `.etherscan`
This file holds your **Etherscan API key**, used for contract verification after deployment.

**Example** (`.etherscan`):
```

YOUR\_ETHERSCAN\_API\_KEY

```

You can get this from [etherscan.io](https://etherscan.io/myapikey).

---

### Optional: Use a `.env` file instead

Instead of using `.secret`, `.infura`, and `.etherscan` as separate files, you can create a `.env` file and store all values there:

**Example** (`.env`):
```

MNEMONIC="candy maple cake sugar pudding cream honey rich smooth crumble sweet treat"
INFURA\_URL="[https://sepolia.infura.io/v3/YOUR\_INFURA\_PROJECT\_ID](https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID)"
ETHERSCAN\_API\_KEY="YOUR\_ETHERSCAN\_API\_KEY"

```

Then use a package like `dotenv` (for Truffle/Hardhat) to load these values into your scripts.

---

## 🚀 Network Used

All deployments in this project target the **Sepolia Testnet**, a widely used Ethereum test network that supports contract deployment, verification, and token transfers — using free test ETH.

Use a [Sepolia faucet](https://sepoliafaucet.com) to get ETH for your wallet.

---

## 📁 Folder Structure

```

.
├── truffle/      # Truffle project
├── hardhat/      # Hardhat project
├── foundry/      # Foundry project
├── .secret       # Mnemonic phrase (excluded via .gitignore)
├── .infura       # Infura URL for Sepolia (excluded via .gitignore)
├── .etherscan    # Etherscan API key (excluded via .gitignore)

```

---

## 🧪 Testing & Deployment

Each project folder contains:
- The NFT contract (`SpaceBear`, for example)
- Deployment scripts specific to the framework
- Optional verification commands for Etherscan

---

## ⚠️ Git Ignore

Make sure your `.gitignore` includes:

```

.secret
.infura
.etherscan
.env
node\_modules/
out/
artifacts/

```

---

## 🧠 Notes

- This setup is for learning and experimentation. Don’t use real wallet seed phrases.
- You can extend each framework’s folder with minting logic, metadata uploads, and frontend integration.

---

Happy hacking 🧸🚀!


Let me know if you want to auto-generate those project folders with minimal working deployment scripts inside, or want a section comparing Truffle vs Hardhat vs Foundry.
