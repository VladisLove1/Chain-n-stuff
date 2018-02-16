pragma solidity ^0.4.0;

contract StillHelloWorld {

    string word;
    uint number;
    address owner;
    
    function StillHelloWorld() public {
        word = 'Bird';
        number = 42;
        owner = msg.sender;
    }

    event Changed(address a);

    function getWord() constant public returns (string) {
        return word;
    }
    
    function setWord(string w) public {
        require(msg.sender == owner);
        word = w;
        Changed(msg.sender);
    }   
}
