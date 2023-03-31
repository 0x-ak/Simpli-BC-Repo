// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
 
contract Money{
    address akremix=0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    //balance --> give you the balance of the address
    //transfer --> used to transfer to the address
 
    function getMoney() public payable{}
 
    function TransferMoney() public {
 
        payable(akremix).transfer(address(this).balance);
    }
}