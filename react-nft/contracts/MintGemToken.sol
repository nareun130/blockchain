// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MintGemToken is ERC721Enumerable{
    //메타 data 주소를 가질 URI
    string public metadataURI;

    constructor(string memory _name, string memory _symbol, string memory _metadataURI) ERC(_name,_symbol){
        metadataURI = _metadataURI;
    }

    struct GemTokenData{
        uint gemTokenRank;
        uint gemTokenType;
    }
    // 토큰 id => 랭크,타입
    mapping(uint => GemTokenData) public gemTokenData;

    //* ERC721에 구현되어있는 메서드를 override
    //tokenURI -> metadata가 저장되어있는 json의 주소를 던져줌.
    function tokenURI(uint _tokenId)override public view returns(string memory){
        string memory gemTokenRank = Strings.toString(gemTokenData[_tokenId].gemTokenRank);
        string memory gemTokenType = Strings.toString(gemTokenData[_tokenId].gemTokenType);

        //argument들을 하나로 합쳐줘서 문자열 리턴
        return string(abi.encodePacked(metadataURI,'/',gemTokenRank,'/',gemTokenType,'.json'));
    }

    function mintGemToken() public {
        uint tokenId = totalSupply()+1;
        
        // 발행자에게 tokenId의 토큰 발행
        gemTokenData[tokenId] = GemTokenData(1,1);

        _mint(msg.sender,tokenId);
    }
}