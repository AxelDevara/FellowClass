//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "hardhat/console.sol";
import '@openzeppelin/contracts/utils/introspection/ERC165.sol';
import './interfaces/IERC2981.sol';

contract FellowContract is ERC721Enumerable, Ownable, IERC2981, VRFConsumerBase{

    //const KOVAN_LINK_TOKEN = 0xa36085F69e2889c224210F603D836748e7dC0088;
    //const KOVAN_VRF_COORDINATOR = 0xdD3782915140c8f3b190B5D67eAc6dc5760C46E9;
    //const KOVAN_KEY_HASH = 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4;

    //fellow ID to kid's address
    mapping(uint => address) kidAddresses;
    //amount donated by an address for leaderboard
    mapping(address => uint) donatedAmount;
    //attribute mapping
    mapping(address => Fellow) attributes;

    bytes32 internal _keyhash;
    address public vrfCoordinator;
    uint public randomResult;
    uint internal _fee;

    struct RoyaltyInfo {
        address recipient;
        uint24 amount;
    }

    struct Fellow {
        uint id;
        bytes32 name;
        uint8 strength;
        uint8 math;
        uint8 literacy;
        uint8 science;
        uint8 wisdom;
    }

    Fellow[] public fellows;

    RoyaltyInfo private _royalties;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _kh) VRFConsumerBase(_VRFCoordinator, _LinkToken) ERC721("Fellow", "FC"){
        vrfCoordinator = _VRFCoordinator;
        _keyhash = _kh;
        _fee = 0.1 * 10**18;
    }

    function requestNewRandom(string memory name) public returns (bytes32){
        bytes32 requestId = requestRandomness(_keyhash, _fee);
        return requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        uint256 id = fellows.length;
        uint strength = (randomNumber / 100000 % 10);

    }

    function checkOwnership(uint256 tokenId) public view returns (bool){
        address owner = ownerOf(tokenId);
        if(owner == msg.sender){
            return true;
        }
        else {
            return false;
        }
        
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
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