//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "hardhat/console.sol";
import '@openzeppelin/contracts/utils/introspection/ERC165.sol';
import './interfaces/IERC2981.sol';

contract FellowContract is ERC721, Ownable, IERC2981, VRFConsumerBase{

    //const KOVAN_LINK_TOKEN = 0xa36085F69e2889c224210F603D836748e7dC0088;
    //const KOVAN_VRF_COORDINATOR = 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9;
    //const KOVAN_KEY_HASH = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;

    mapping(address => address) fellowAddresses;
    mapping(address => uint) donors;
    mapping(address => Traits) attributes;

    struct RoyaltyInfo {
        address recipient;
        uint24 amount;
    }

    struct Traits {
        uint8 strength;
        uint8 math;
        uint8 literacy;
        uint8 science;
        uint8 wisdom;
    }

    RoyaltyInfo private _royalties;

    constructor() VRFConsumerBase(_VRFCoordinator, _LinkToken) ERC721("FellowAvatar", "FA"){

    }

    function requestNewRandom(uint userProvidedSeed, string memory name) public {

    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function burn(uint tokenId) external {
        require(msg.sender == ownerOf(tokenId));
        _burn(tokenId);
    }

    /// @dev Sets token royalties
    /// @param recipient recipient of the royalties
    /// @param value percentage (using 2 decimals - 10000 = 100, 0 = 0)
    function _setRoyalties(address recipient, uint256 value) internal {
        require(value <= 20000, 'ERC2981Royalties: Too high');
        _royalties = RoyaltyInfo(recipient, uint24(value));
    }

    /// @inheritdoc	IERC2981
    function royaltyInfo(uint256, uint256 value)
        external
        view
        override
        returns (address receiver, uint256 royaltyAmount)
    {
        RoyaltyInfo memory royalties = _royalties;
        receiver = royalties.recipient;
        royaltyAmount = (value * royalties.amount) / 10000;
    }

    /// @inheritdoc	ERC165
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC2981).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}