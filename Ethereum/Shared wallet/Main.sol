// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

import "./Allowance.sol";



contract MainWallet is Allowance{

// Contract with main functionality.

    event balanceChange(address indexed _who, uint _amount);
    // logs any changes in the contract with the address and amount involved.


    function withdrawMoney(address payable _to, uint _amount) public ownerOtAllowed(_amount){
        // withdraw funds with balance update.

        require(_amount <= address(this).balance, "Not enough funds in the account.");
        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit balanceChange(_to, _amount);
        _to.transfer(_amount);
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    receive() external payable {
        emit balanceChange(msg.sender, msg.value);

    }

    function renounceOwnership() public  onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
}
