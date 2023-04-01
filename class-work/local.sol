pragma solidity ^0.6.0; 

contract local{ 
    uint amount; //state variable (permanently) 

//local variable 
//pure and view 
//view: get the details from the blockchain //pure: not be getting any details from the blockchain (Not connected) 

    function getValue() public pure returns(uint)
    { 
        uint value =1; 
        return value; 
    } 
    
    function hello() public pure returns(string memory){
         return "hello";
    } 
}