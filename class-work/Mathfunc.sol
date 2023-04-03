//SPDX-License-Identifier:MIT
pragma solidity ^0.5.12;
 
//define library
library Mathfunc{
 
    function myName (int a, int b) public pure returns(int){
        require(b!=0, "Denominator can't be 0");
        return a/b;
    }
}
 
contract LibrarySample{
     using Mathfunc for int;
 
     function div (int a, int b) public pure returns(int){
         return a.myName(b);
     }
}