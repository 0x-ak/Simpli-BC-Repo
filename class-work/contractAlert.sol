//SPDX-License-Identifier:MIT
pragma solidity ^0.5.12;
 
contract ValueAlert{
 
    uint price = 100;
 
    //define the event 
    event priceEvent(bool retunvalue);
 
    function bid (uint _amount) public returns(bool){
 
        if(_amount>price){
            //fire the event
            emit priceEvent(true);
 
        }
        return true;
    }
      
    }