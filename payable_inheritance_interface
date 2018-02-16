pragma solidity ^0.4.0;

contract Concert {
    
    address owner;
    uint public tickets;
    uint constant public price = 10 ether;
    
    mapping (address => uint) public purchasers;
    
    function Concert(uint t) public payable {
        owner = msg.sender;
        tickets = t;
    }
    
    function() public payable{
        buyTickets(1);
    }
    
    function buyTickets(uint amount) payable public{
        require(msg.value == (amount * price) && amount <= tickets);
        
        purchasers[msg.sender] += amount;
        tickets -= amount;
        
        if (tickets == 0) {
            selfdestruct(owner);
        }
        
    }
    
    function addTickets(uint amount) public {
        require(msg.sender == owner);
        tickets += amount;
    }
    
    function website() public returns (string);
    
}

interface Refundable {
    function refund(uint numOfTickets) public returns (bool);
}

contract AbstractAttack is Concert(10), Refundable {
    
    function refund(uint numOfTickets) public returns (bool) {
        require(purchasers[msg.sender] >= numOfTickets);
        
        msg.sender.transfer(numOfTickets * price);
        purchasers[msg.sender] -= numOfTickets;
        tickets += numOfTickets;
        return true;
    }
    
    function website() public returns (string) {
        return ('https://concertattack.com');
    }    
    
}
