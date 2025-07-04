// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

contract SmartWallet {
    address public owner; 
    mapping(address => uint) allowance; 

    constructor() {
        owner = msg.sender; 
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this wallet");
        _;
    }

    // Accept ETH deposits from anyone
    function deposit() public payable {}

    function viewBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    // Add to a spender's allowance (owner-only)
    function setAllowance(address _spender, uint _allowance) public onlyOwner {
        allowance[_spender] += _allowance; // Increase existing allowance
    }

    // View your personal allowance (not allowed for owner)
    function viewMyAllowance() public view returns (uint) {
        require(msg.sender != owner, "You are the owner of the wallet. You do not have allowance");
        return allowance[msg.sender];
    }

    // Transfer ETH from contract to any valid address
    function transferFunds(address payable _to, uint _amount) public {
        require(_to != address(0), "Invalid Address");
        require(_amount <= address(this).balance, "The Wallet doesn't have sufficient balance");

        bool success;
        if (msg.sender != owner) {
            // Check allowance if sender is not owner
            require(allowance[msg.sender] >= _amount, "You don't have sufficient allowance balance");
            allowance[msg.sender] -= _amount; // Deduct allowance
        }

        (success, ) = _to.call{value: _amount, gas: 300000}("");
        require(success, "Transfer Failed");
    }

    receive() external payable {} 
}
