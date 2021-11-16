//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./FellowNFT.sol";
import "./FellowBentoBox.sol";

contract GameContract is Ownable , VRFConsumerBase {
    event StartedLearning(string _subject, uint _amount);

    address constant internal _LinkToken = 0xa36085F69e2889c224210F603D836748e7dC0088;
    address constant internal _VRFCoordinator = 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9;
    bytes32 constant internal _KeyHash = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;

    address public immutable currency;

    //VRF
    uint internal _randomResult;
    uint internal _fee;
    
    //BentoBox
    uint public fundRaised;
    uint learningFee;
    FellowBentoBox public immutable fellowBentoBox;
    FellowNFT public immutable fellow;

    function changeLearningFee(uint newFee) external onlyOwner {
        learningFee = newFee;
    }

    constructor(FellowBentoBox _bentobox, FellowNFT _fellow) VRFConsumerBase(_VRFCoordinator, _LinkToken) {
        fellow = _fellow;
        currency = 0x33e24a1902620BeFB88D40714EF980Cd8653234e;
        fellowBentoBox = _bentobox;
        _fee = 0.1 * 10**18;
        learningFee = 5 * 10**18;
    }

    function getNewRandom() internal returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= _fee, "Not enough LINK - fill contract with faucet");
        bytes32 _requestId = requestRandomness(_KeyHash, _fee);
        return _requestId;
    }

    function fulfillRandomness(bytes32, uint256 randomNumber) internal override {
        _randomResult = randomNumber;
    }

    function learnStrength(uint tokenId) external {
        require(fellow.checkOwnership(tokenId, msg.sender));
        fellowBentoBox.depositToFellowBentoBox(currency, learningFee, msg.sender, false);
        getNewRandom();
        fundRaised += learningFee;
        fellow.learn(4, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Strength", (_randomResult % 10) + 1);
    }

    function learnMath(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, msg.sender, false);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(0, tokenId,  (_randomResult % 10) + 1);
        emit StartedLearning("Math", (_randomResult % 10) + 1);
    }

    function learnLiteracy(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, msg.sender, false);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(1, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Literacy", (_randomResult % 10) + 1);
    }

    function learnScience(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, msg.sender, false);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(2, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Science", (_randomResult % 10) + 1);        
    }

    function learnWisdom(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         fellowBentoBox.depositToFellowBentoBox(currency, learningFee, msg.sender, false);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(3, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Wisdom", (_randomResult % 10) + 1);
    }
}