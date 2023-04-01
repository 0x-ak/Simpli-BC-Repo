pragma solidity ^0.6.0;

contract globalVariables {
    uint256 public data;
    bytes32 public hash;
    bytes32 public hash256;
    bytes32 public block_hash;
    uint256 public data2;
    uint256 public data3;
    uint256 public data4;

    function chkhash() public {
        hash = keccak256("Blockchain");
        hash256 = sha256("Block 2");
        block_hash = blockhash(0);
        data = block.difficulty;
        data3 = block.number;
        data4 = block.gaslimit;
    }
}
