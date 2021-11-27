//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "hardhat/console.sol";
import '@openzeppelin/contracts/utils/introspection/ERC165.sol';
import './interfaces/IERC2981.sol';

contract FellowNFT is ERC721, Ownable, IERC2981, VRFConsumerBase{
    using Strings for uint256;

    address constant internal _LinkToken = 0x01BE23585060835E02B77ef475b0Cc51aA1e0709;
    address constant internal _VRFCoordinator = 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B;
    bytes32 constant internal _KeyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
    
    mapping(bytes32 => address) requestToSender;
    mapping(bytes32 => uint256) requestToTokenId;
    mapping(uint256 => string) tokenIdtoTokenUri;

    uint internal randomResult;
    uint internal _fee;
    uint internal _mintFee;

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

    RoyaltyInfo public _royalties;

    constructor() VRFConsumerBase(_VRFCoordinator, _LinkToken) ERC721("Fellow", "FC"){
        _royalties = RoyaltyInfo(address(this), uint24(10000));
        _fee = 0.1 * 10**18;
    }

    function setGameAddress(address _gameAddress) external onlyOwner {
        gameAddress = _gameAddress;
    }

    function evolve(uint _tokenId) external {
        require(msg.sender == gameAddress, "you don't have access to call this function");
        Fellow storage fellow = fellows[_tokenId];
        if(fellow.level >= 5){
            tokenIdtoTokenUri[_tokenId] = append(_childURI(), _tokenId.toString(), ".json");
            fellow.math += 10;
            fellow.literacy += 10;
            fellow.science += 10;
        }
        if(fellow.level >= 10){
            tokenIdtoTokenUri[_tokenId] = append(_adultURI(), _tokenId.toString(), ".json");
            fellow.math += 10;
            fellow.literacy += 10;
            fellow.science += 10;
            fellow.wisdom += 20;
        }
    }

     function getMaturity(uint _tokenId) external view returns (uint){
        Fellow memory f = fellows[_tokenId];
        return (f.level);
    }

    function getLevel(uint _tokenId) external view returns (uint, uint, uint, uint, uint, uint){
        Fellow memory f = fellows[_tokenId];
        return (f.level, f.strength, f.literacy,f.math, f.science, f.wisdom);
    }

    function getAllMintedFellows() external view returns (string[] memory){
        string[] memory f = new string[](fellows.length);
        for(uint i = 0; i < fellows.length; i ++) {
            f[i] = tokenURI(i);
        }
        return f;
    }

    function learn(uint _subject, uint _tokenId, uint _amount) external {
        require(msg.sender == gameAddress);
        Fellow storage fellow = fellows[_tokenId];
        if(_subject == 0){
            fellow.level += _amount * 2;
            fellow.math += _amount;
        }
        if(_subject == 1){
            fellow.level += _amount * 2;
            fellow.literacy += _amount;
        }
        if(_subject == 2){
            fellow.level += _amount * 2;
            fellow.science += _amount;
        }
        if(_subject == 3){
            fellow.level += _amount * 2;
            fellow.wisdom += _amount;
        }
        if(_subject == 4){
            fellow.level += _amount * 2;
            fellow.strength += _amount;
        }
    }

    function getNewFellow(address sender) public returns (bytes32 requestId) {
        // require(IERC20(currency).approve(address(this), _mintFee));  
        require(LINK.balanceOf(address(this)) >= _fee, "Not enough LINK - fill contract with faucet");
        bytes32 _requestId = requestRandomness(_KeyHash, _fee);
        requestToSender[_requestId] = sender;
        requestToTokenId[_requestId] = fellows.length;
        return _requestId;
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        uint _strength = randomNumber % 10;
        fellows.push(
            Fellow(0,_strength, 0,0,0,0)
        );
        tokenIdtoTokenUri[requestToTokenId[requestId]] = append(_baseURI(), fellows.length.toString(), ".json");
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

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
         require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return tokenIdtoTokenUri[tokenId];
    }

    function append(string memory a, string memory b, string memory c) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b, c));
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "ipfs://Qmdz6qQ1gkHsBuxiwmLYyM8PeeiBq9JyjbGUVN3WyQeGcW/";
    }

    function _childURI() internal view virtual  returns (string memory) {
        return "ipfs://QmReHaDRwnkczkyUR53yPP3rAxvyPNK11zfa2CfnD4oito/";
    }

    function _adultURI() internal view virtual  returns (string memory) {
        return "ipfs://QmYT2qYCYTNgVxoHDgUC6fUBJsPCvmSGuz1Aw8jVyhW6YE/";
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