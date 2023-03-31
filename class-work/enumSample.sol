pragma solidity ^0.5.12;
 
contract enumSample{
 
    enum Status {orderReceived, packaged, shipped, trackorder}
    Status status;
 
    function setStatus() public {
        status=Status.orderReceived;
    }
 
}