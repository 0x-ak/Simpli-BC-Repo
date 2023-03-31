pragma solidity ^0.5.12;
 
contract structSample{
 
   //struct sample
   //datatype variable name
   struct learner{
       //state variables --> Permanently stored in blockchain
    string name;
    uint8 age;
   }
   //mapping (key => value) mapping name;
   // 1 => ("Alice", 40)
   // 2 => ("Tom", 45)
   // 3 => ("Jerry", 35)
 
mapping (uint8 => learner) learners;
 
function setlearnerDetails(uint8 _key, string memory _name, uint8 _age)public{
     
     //learners[1].name="Alice"
     //learners[1].age=40
     learners[_key].name=_name;
     learners[_key].age=_age;
}
 
function getLearnerDetails(uint8 _key) public view returns(string memory, uint8) {
    return(learners[_key].name,learners[_key].age);
}
}