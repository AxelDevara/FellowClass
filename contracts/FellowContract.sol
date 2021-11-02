//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import '@openzeppelin/contracts/utils/introspection/ERC165.sol';
import './interfaces/IERC2981.sol';

contract FellowContract is ERC721, Ownable, IERC2981{

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

    constructor() ERC721("FellowAvatar", "FA"){

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
        require(value <= 10000, 'ERC2981Royalties: Too high');
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