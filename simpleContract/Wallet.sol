pragma solidity ^0.8.11;

// SPDX-License-Identifier: MIT

import './Owner.sol';

contract Wallet is Owner{

  struct balance {
      uint totalAmount;
      uint numPayments;
      uint[] payments;
  }

  mapping (address => balance) wallets;

  function getContractBalance() view external isOwner returns(uint) {
    return address(this).balance;
  }

  function getBalance () view public returns(uint) {
      return wallets[msg.sender].totalAmount;
  }

  function getNumPayments () view public returns(uint) {
      return wallets[msg.sender].numPayments;
  }

  function withdrawAllMoney (address _to) public payable {
      uint amountToTransfer = wallets[msg.sender].totalAmount;
      wallets[msg.sender].totalAmount = 0;
      payable(address(_to)).transfer(amountToTransfer);
  }

  function withdrawMoney (uint amount, address _to) public payable {
      require(amount <= wallets[msg.sender].totalAmount, "Not enough funds");
      wallets[msg.sender].totalAmount -= amount;
      payable(address(_to)).transfer(amount);
  }

  receive() external payable {
      wallets[msg.sender].totalAmount += msg.value;
      wallets[msg.sender].numPayments += 1;
      wallets[msg.sender].payments.push(msg.value);
  }
}