pragma solidity >=0.6.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./zklrVerifier.sol";
//import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract is Verifier {

  event SetPurpose(address sender, string purpose);

  string public purpose = "Building Unstoppable Apps";

  uint256 public verifiedHash;

  constructor() public payable {
    // what should we do on deploy?
  }

  function setPurpose(string memory newPurpose) public {
    purpose = newPurpose;
    console.log(msg.sender,"set purpose to",purpose);
    emit SetPurpose(msg.sender, purpose);
  }

  function collectBounty(
          address payable to,
          uint[2] memory a,
          uint[2][2] memory b,
          uint[2] memory c,
          uint[59] memory input
      ) public {
      require(verifyProof(a, b, c, input), "Invalid Proof");
      to.transfer(10**18);
  }

}
