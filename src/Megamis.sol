// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Megamis is Initializable, ERC721Upgradeable, OwnableUpgradeable {
    string public baseTokenURI;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    

    function initialize(address initialOwner,string calldata name,string calldata symbol) initializer public {
        __ERC721_init(name, symbol);
        __Ownable_init(initialOwner);
        baseTokenURI = string.concat("https://contracts-develop.sandbox.game/" , symbol , "-unrevealed/");
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        require(bytes(baseURI).length != 0, "AvatarCollection: baseURI is not set");
        baseTokenURI = baseURI;
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
}