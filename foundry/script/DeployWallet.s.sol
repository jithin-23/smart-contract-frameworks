//SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/SmartWallet.sol";

contract SmartWalletScript is Script {
    function setUp() public {}

    function run() public {

        // string memory seedPhrase = vm.readFile(".secret"); // If you are using saeed phrase, do like this
        // uint256 privateKey = vm.deriveKey(seedPhrase, 0); // get private key for account 0 of the wallet
        uint privateKey = vm.envUint("ANVIL_PRIVATE_KEY"); //give private key of the account on the chain

        vm.startBroadcast(privateKey);
        SmartWallet wallet = new SmartWallet();

        vm.stopBroadcast();
    }
}