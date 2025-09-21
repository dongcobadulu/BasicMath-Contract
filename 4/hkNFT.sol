// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

// Importing OpenZeppelin ERC721 contract
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// Interface for interacting with a submission contract
interface ISubmission {
    // Struct representing a coprolite
    struct Coprolite {
        address author; // Address of the coprolite author
        string line1; // First line of the coprolite
        string line2; // Second line of the coprolite
        string line3; // Third line of the coprolite
    }

    // Function to mint a new coprolite
    function mintCoprolite(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external;

    // Function to get the total number of coprolites
    function counter() external view returns (uint256);

    // Function to share a coprolite with another address
    function shareCoprolite(uint256 _id, address _to) external;

    // Function to get coprolites shared with the caller
    function getMySharedCoprolites() external view returns (Coprolite[] memory);
}

// Contract for managing Coprolite NFTs
contract CoproliteNFT is ERC721, ISubmission {
    Coprolite[] public coprolites; // Array to store coprolites
    mapping(address => mapping(uint256 => bool)) public sharedCoprolites; // Mapping to track shared coprolites
    uint256 public coproliteCounter; // Counter for total coprolites minted

    // Constructor to initialize the ERC721 contract
    constructor() ERC721("CoproliteNFT", "COPRO") {
        coproliteCounter = 1; // Initialize coprolite counter
    }

    string salt = "value"; // A private string variable

    // Function to get the total number of coprolites
    function counter() external view override returns (uint256) {
        return coproliteCounter;
    }

    // Function to mint a new coprolite
    function mintCoprolite(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external override {
        // Check if the coprolite is unique
        string[3] memory coprolitesStrings = [_line1, _line2, _line3];
        for (uint256 li = 0; li < coprolitesStrings.length; li++) {
            string memory newLine = coprolitesStrings[li];
            for (uint256 i = 0; i < coprolites.length; i++) {
                Coprolite memory existingCoprolite = coprolites[i];
                string[3] memory existingCoproliteStrings = [
                    existingCoprolite.line1,
                    existingCoprolite.line2,
                    existingCoprolite.line3
                ];
                for (uint256 eHsi = 0; eHsi < 3; eHsi++) {
                    string memory existingCoproliteString = existingCoproliteStrings[
                        eHsi
                    ];
                    if (
                        keccak256(abi.encodePacked(existingCoproliteString)) ==
                        keccak256(abi.encodePacked(newLine))
                    ) {
                        revert HaikuNotUnique();
                    }
                }
            }
        }

        // Mint the coprolite NFT
        _safeMint(msg.sender, coproliteCounter);
        coprolites.push(Coprolite(msg.sender, _line1, _line2, _line3));
        coproliteCounter++;
    }

    // Function to share a coprolite with another address
    function shareCoprolite(uint256 _id, address _to) external override {
        require(_id > 0 && _id <= coproliteCounter, "Invalid coprolite ID");

        Coprolite memory coproliteToShare = coprolites[_id - 1];
        require(coproliteToShare.author == msg.sender, "NotYourHaiku");

        sharedCoprolites[_to][_id] = true;
    }

    // Function to get coprolites shared with the caller
    function getMySharedCoprolites()
        external
        view
        override
        returns (Coprolite[] memory)
    {
        uint256 sharedCoproliteCount;
        for (uint256 i = 0; i < coprolites.length; i++) {
            if (sharedCoprolites[msg.sender][i + 1]) {
                sharedCoproliteCount++;
            }
        }

        Coprolite[] memory result = new Coprolite[](sharedCoproliteCount);
        uint256 currentIndex;
        for (uint256 i = 0; i < coprolites.length; i++) {
            if (sharedCoprolites[msg.sender][i + 1]) {
                result[currentIndex] = coprolites[i];
                currentIndex++;
            }
        }

        if (sharedCoproliteCount == 0) {
            revert NoHaikusShared();
        }

        return result;
    }

    // Custom errors
    error HaikuNotUnique(); // Error for attempting to mint a non-unique coprolite
    error NotYourHaiku(); // Error for attempting to share a coprolite not owned by the caller
    error NoHaikusShared(); // Error for no coprolites shared with the caller
}
