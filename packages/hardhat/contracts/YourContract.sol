pragma solidity >=0.6.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./zklrVerifier.sol";
//import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract is Verifier {

  event SetPurpose(address sender, string purpose);

  mapping(bytes32 => uint256) public bounties;

  uint256 public queryResult;

  constructor() public payable {
  }

  function query(uint[59] memory input) public {
    queryResult = bounties[keccak256(abi.encodePacked(input))];
  }

  function addBounty(uint[59] memory input) public payable {
    bounties[keccak256(abi.encodePacked(input))] += msg.value;
  }

  function collectBounty(
          address payable to,
          uint[2] memory a,
          uint[2][2] memory b,
          uint[2] memory c,
          uint[59] memory input
      ) public {
      require(verifyProof(a, b, c, input), "Invalid Proof");
      uint256 topay = bounties[keccak256(abi.encodePacked(input))];
      bounties[keccak256(abi.encodePacked(input))] = 0;
      to.transfer(topay);
  }

  // Function to receive Ether. msg.data must be empty
  receive() external payable {}

  // Fallback function is called when msg.data is not empty
  fallback() external payable {}

}
