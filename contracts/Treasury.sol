//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Treasury is Ownable{
    mapping(address => uint) stake;

    function calculateStake(uint amount) public {
        
    }
}