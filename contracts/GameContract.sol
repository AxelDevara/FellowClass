//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./FellowContract.sol";
import "./FellowBentoBox.sol";

contract GameContract is Ownable {
    event StartedLearning(string _subject, uint _amount);
    address public currency;
    
    uint public fundRaised;
    uint learningFee;
    FellowBentoBox public immutable fellowBentoBox;
    FellowContract public immutable fellow;

    function changeLearningFee(uint newFee) external onlyOwner {
        learningFee = newFee;
    }

    constructor(uint _learningFee, FellowBentoBox _bentobox, address _currency, FellowContract _fellow) {
        fellow = _fellow;
        currency = _currency;
        fellowBentoBox = _bentobox;
        learningFee = _learningFee;
    }

    function learnStrength(uint tokenId) external {
        require(fellow.checkOwnership(tokenId, msg.sender));
        fellowBentoBox.depositToFellowBentoBox(currency, learningFee, false);
        fundRaised += learningFee;
        fellow.learn(4, tokenId, 4);
        emit StartedLearning("Strength", 4);
    }

    function learnMath(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, false);
         fundRaised += learningFee;
        fellow.learn(0, tokenId, 4);
        
    }
    function learnLiteracy(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, false);
         fundRaised += learningFee;
        fellow.learn(1, tokenId, 4);
    }
    function learnScience(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, false);
         fundRaised += learningFee;
        fellow.learn(2, tokenId, 4);        
    }
    function learnWisdom(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, false);
         fundRaised += learningFee;
        fellow.learn(3, tokenId, 4);
    }

}