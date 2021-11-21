//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./FellowNFT.sol";
import "./FellowBentoBox.sol";

contract Marketplace {
    FellowNFT immutable internal _fellowNFT;
    FellowBentoBox immutable internal _bentoBox;
    address internal currency;

    mapping(uint => uint) tokenIdToPrice;
    uint public listedNFTCount;
    
    constructor(FellowNFT _fellow, FellowBentoBox _bento){
        _fellowNFT = _fellow;
        currency = 0x8ad3aA5d5ff084307d28C8f514D7a193B2Bfe725;
        _bentoBox = _bento;
    }

    function listForSale(uint tokenId, uint price) external {
        require(msg.sender == _fellowNFT.ownerOf(tokenId));
        tokenIdToPrice[tokenId] = price * (10 ** 18);
        listedNFTCount++;
    }

    function buyNFT(uint tokenId) external {      
        require(IERC20(currency).approve(address(this), tokenIdToPrice[tokenId] * (10 ** 18)));  
        IERC20(currency).transferFrom(msg.sender, _fellowNFT.ownerOf(tokenId), tokenIdToPrice[tokenId]  - (tokenIdToPrice[tokenId]  * 10 / 100));
        _bentoBox.depositToFellowBentoBox(currency, tokenIdToPrice[tokenId] *  10 / 100, msg.sender, false);
        _fellowNFT.safeTransferFrom(_fellowNFT.ownerOf(tokenId), msg.sender, tokenId);
    }
}