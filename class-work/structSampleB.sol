pragma solidity ^0.5.12;

contract structSample {
    address public Simplilearn;

    constructor() public {
        //Simplilearn=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        Simplilearn = msg.sender;
    }

    modifier onlySimplilearn() {
        require(msg.sender == Simplilearn);
        _;
    }
    //struct sample
    //datatype variable name
    struct learner {
        //state variables --> Permanently stored in blockchain
        string name;
        uint8 age;
    }
    //mapping (key => value) mapping name;
    // 1 => ("Alice", 40) // 2 => ("Tom", 45) // 3 => ("Jerry", 35)
    mapping(uint8 => learner) public learners;

    function setlearnerDetails(
        uint8 _key,
        string memory _name,
        uint8 _age
    ) public onlySimplilearn {
        //learners[1].name="Alice"
        //learners[1].age=40
        learners[_key].name = _name;
        learners[_key].age = _age;
    }

    function getLearnerDetails(uint8 _key)
        public
        view
        returns (string memory, uint8)
    {
        return (learners[_key].name, learners[_key].age);
    }
}
