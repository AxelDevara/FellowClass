//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./FellowContract.sol";

contract GameContract is Ownable, VRFConsumerBase {
     //const KOVAN_LINK_TOKEN = 0xa36085F69e2889c224210F603D836748e7dC0088;
    //const KOVAN_VRF_COORDINATOR = 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9;
    //const KOVAN_KEY_HASH = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;
    
    uint fee;

    function changeFee(uint newFee) external onlyOwner {
        fee = newFee;
    }

    constructor() VRFConsumerBase(_VRFCoordinator, _LinkToken){

    }

    function requestNewRandom(uint userProvidedSeed, string memory name) public {

    }
    
    function learnStrength(uint tokenId) public {
        require(FellowContract.checkOwnership(tokenId));
        FellowContract(nft).attributes.strength  += 3;
    }

    function learnMath(address nft) public {
        require(FellowContract.checkOwnership(tokenId));
        FellowContract(nft).attributes.strength  += 3;
        
    }
    function learnLiteracy(address nft) public {
        
    }
    function learnScience(address nft) public {
        
    }
    function learnWisdom(address nft) public {
        
    }
}