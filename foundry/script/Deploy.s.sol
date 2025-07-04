//SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/Spacebear.sol";

contract SpacebearScript is Script {

    function setUp() public {}

    function run() public {
        string memory seedPhrase = vm.readFile(".secret");
        uint256 privateKey = vm.deriveKey(seedPhrase, 0);
        vm.startBroadcast(privateKey);
        SpaceBear spacebear = new SpaceBear();
        
        vm.stopBroadcast();
    }
}