/ SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    // contract to register ownership, modifiers.
    // allows the owner to se and modify allowances to an account.
    

    event AllowanceChanged (address indexed _forWho, uint _newAmount);

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    mapping(address => uint) public allowance;


    function addAllowance (address _who, uint _amount) public onlyOwner{
        emit AllowanceChanged(msg.sender, _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance (address _who, uint _amount) internal ownerOtAllowed (_amount){
        emit AllowanceChanged(msg.sender, _amount);
        allowance[_who] -= _amount;
    }

    modifier ownerOtAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }

    
}