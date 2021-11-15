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

    //fellow ID to kid's address
    mapping(uint => address) kidAddresses;
    
    mapping(bytes32 => string) requestToCharacterName;
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;
    mapping(uint256 => string) tokenIdtoTokenUri;

    bytes32 internal _keyhash;
    address public vrfCoordinator;
    uint internal randomResult;
    uint internal _fee;

    address internal gameAddress;

    struct RoyaltyInfo {
        address recipient;
        uint24 amount;
    }

    struct Fellow {
        uint level;
        uint strength;
        uint math;
        uint literacy;
        uint science;
        uint wisdom;
    }
    

    Fellow[] public fellows;

    RoyaltyInfo private _royalties;

    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _kh) VRFConsumerBase(_VRFCoordinator, _LinkToken) ERC721("Fellow", "FC"){
        _royalties = RoyaltyInfo(address(this), uint24(2500));
        vrfCoordinator = _VRFCoordinator;
        _keyhash = _kh;
        _fee = 0.1 * 10**18;
    }

    function setGameAddress(address _gameAddress) external onlyOwner {
        gameAddress = _gameAddress;
    }

    function evolve(uint _tokenId) external {
        Fellow storage fellow = fellows[_tokenId];
        fellow.math += 10;
        fellow.literacy += 10;
        fellow.science += 10;
    }

    function getMaturity(uint _tokenId) external view returns (uint){
        return fellows[_tokenId].level;
    }

    function learn(uint _subject, uint _tokenId, uint _amount) external {
        require(msg.sender == gameAddress);
        Fellow storage fellow = fellows[_tokenId];
        if(_subject == 0){
            fellow.math += _amount;
        }
        if(_subject == 1){
            fellow.literacy += _amount;
        }
        if(_subject == 2){
            fellow.science += _amount;
        }
        if(_subject == 3){
            fellow.wisdom += _amount;
        }
        if(_subject == 4){
            fellow.strength += _amount;
        }
    }

    function getNewFellow(string memory name) public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= _fee, "Not enough LINK - fill contract with faucet");
        bytes32 _requestId = requestRandomness(_keyhash, _fee);
        requestToCharacterName[_requestId] = name;
        requestToSender[_requestId] = msg.sender;
        requestToTokenId[_requestId] = fellows.length;
        return _requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        uint _strength = (randomNumber % 100);
        fellows.push(
            Fellow(0,_strength, 0,0,0,0)
        );
        tokenIdtoTokenUri[requestToTokenId[requestId]] = _baseURI();
        _safeMint(requestToSender[requestId], requestToTokenId[requestId]);
    }

    function checkOwnership(uint256 _tokenId, address _owner) public view returns (bool){
        address owner = ownerOf(_tokenId);
        if(owner == _owner){
            return true;
        }
        else {
            return false;
        }
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        return tokenIdtoTokenUri[tokenId];
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "";
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