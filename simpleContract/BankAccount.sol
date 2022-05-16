pragma solidity^0.8.11;

// SPDX-License-Identifier: MIT

contract BankAccount {

    struct Account {
        uint money;
        uint numOp;
    }

    mapping (address => Account) accounts;

    function getContractBalance() view external returns (uint) {
        return address(this).balance;
    }

    function getBalance() view external returns (uint) {
        return accounts[msg.sender].money;
    }

    function getNumOp() view external returns (uint) {
        return accounts[msg.sender].numOp;
    }

    function withdraw(address payable _to) external {
        uint allMoney = accounts[msg.sender].money;
        accounts[msg.sender].money = 0;
        accounts[msg.sender].numOp += 1;        
        _to.transfer(allMoney);
    }

    receive() external payable {
        // console.log(msg);
        accounts[msg.sender].money += msg.value;
        accounts[msg.sender].numOp += 1;
    }
}
