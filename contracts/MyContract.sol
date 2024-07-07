// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title My Contract
 */

contract Ownable {
    address owner;

    constructor()  {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }
}
contract SecretVault {
    string secret;
    
    constructor(string memory _secret)  {
        secret = _secret;
    }

    function getSecret() public view returns(string memory){
        return secret;
    }
}
contract MyContract is Ownable{
    //string secret;
    // address owner;
    address secretVault;


    constructor(string memory _secret) public {
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
        // owner = msg.sender;
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "must be owner");
    //     _;
    // }

    function getSecret() public view onlyOwner returns(string memory){
         SecretVault _secretVault = SecretVault(secretVault);
         return _secretVault.getSecret();
        //return secret;
    }
    
}
