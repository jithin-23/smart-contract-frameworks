// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/SmartWallet.sol";

contract InteractWalletScript is Script {
    SmartWallet wallet;

    address walletAddress = 0x5FbDB2315678afecb367f032d93F642f64180aa3; // deployed contract address

    //3 Default accounts in foundry
    // 🔑 Account 1: Owner
    address account1Public = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 account1Private = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    // 🔑 Account 2: Spender
    address account2Public = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    uint256 account2Private = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;

    // 🔑 Account 3: Receiver
    address account3Public = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
    uint256 account3Private = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;

    function setUp() public {
        wallet = SmartWallet(payable(walletAddress));
    }

    function run() public {
        // 1. View owner
        address contractOwner = wallet.owner();
        console.log("Wallet owner is:", contractOwner);

        // 2. Send 1 ETH to wallet (from account 1)
        vm.startBroadcast(account1Private);
        (bool sent, ) = payable(walletAddress).call{value: 1 ether}("");
        require(sent, "ETH transfer to wallet failed");
        vm.stopBroadcast();

        // 3. View balance (as account 1)
        vm.startBroadcast(account1Private);
        uint balance = wallet.viewBalance();
        console.log("Wallet balance:", balance);
        vm.stopBroadcast();

        // 4. Set 4 ETH allowance for account 2 (spender)
        vm.startBroadcast(account1Private);
        wallet.setAllowance(account2Public, 4 ether);
        vm.stopBroadcast();

        // 5. View allowance (as account 2)
        vm.startBroadcast(account2Private);
        uint myAllowance = wallet.viewMyAllowance();
        console.log("Account 2 allowance:", myAllowance);

        // 6. Account 2 transfers 0.012 ETH to account 3
        wallet.transferFunds(payable(account3Public), 0.012 ether);
        vm.stopBroadcast();

        // 7. Log final balance of account 3
        uint newBal = account3Public.balance;
        console.log("Account 3 balance after transfer:", newBal);
    }
}
