pragma solidity ^0.6.0;

contract parent {
    string internal name = "Alice";
    uint8 age = 40;

    function getAge() public view returns (uint8) {
        return age;
    }
}

contract child is parent {
    function getName() public view returns (string memory) {
        return name;
    }
}

contract functionVisibility {
    string private name;

    function getName() private view returns (string memory) {
        return name;
    }
}
