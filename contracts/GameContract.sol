//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "./FellowNFT.sol";
import "./FellowBentoBox.sol";

contract GameContract is Ownable , VRFConsumerBase {
    event StartedLearning(string _subject, uint _amount);

    address constant internal _LinkToken = 0x01BE23585060835E02B77ef475b0Cc51aA1e0709;
    address constant internal _VRFCoordinator = 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B;
    bytes32 constant internal _KeyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;

    address public immutable currency;

    //VRF
    uint internal _randomResult;
    uint internal _fee;
    
    //BentoBox
    uint public fundRaised;
    uint learningFee;
    FellowNFT public immutable fellow;

    function changeLearningFee(uint newFee) external onlyOwner {
        learningFee = newFee;
    }

    constructor(FellowNFT _fellow) VRFConsumerBase(_VRFCoordinator, _LinkToken) {
        fellow = _fellow;
        currency = 0x8ad3aA5d5ff084307d28C8f514D7a193B2Bfe725;
        _fee = 0.1 * 10**9;
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
        getNewRandom();
        fundRaised += learningFee;
        fellow.learn(4, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Strength", (_randomResult % 10) + 1);
    }

    function learnMath(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(0, tokenId,  (_randomResult % 10) + 1);
        emit StartedLearning("Math", (_randomResult % 10) + 1);
    }

    function learnLiteracy(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 5);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(1, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Literacy", (_randomResult % 10) + 1);
    }

    function learnScience(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(2, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Science", (_randomResult % 10) + 1);        
    }

    function learnWisdom(uint tokenId) public {
        require(fellow.checkOwnership(tokenId, msg.sender));
        require(fellow.getMaturity(tokenId) >= 10);
         getNewRandom();
         fundRaised += learningFee;
        fellow.learn(3, tokenId, (_randomResult % 10) + 1);
        emit StartedLearning("Wisdom", (_randomResult % 10) + 1);
    }
}