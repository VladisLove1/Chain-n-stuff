pragma solidity ^0.4.18;

contract Split {
    
    // variables
    address owner;
    uint totalReceived = 0;
    mapping (address => uint) withdrownAmount;
    
    //array of employees' addresses
    address[] employees = [0xD69ff0BE9984e3C4f81064b0E984426244D8E38c,  //employee 1
                           0xcd4457364ffA49F05506E39Abb7E715509E37E31,  //employee 2
                           0xECEB5ba851Bc74D6E99E346Ef60091282daF2D28,  //employee 3
                           0x4Fd01bebE6c1E8044390E79CCc42990468656010,  //employee 4
                           0x96641d822c3a2e5044cBe320790820A0DE16f6E6]; //employee 5
    
    //constructor
    function Split() public payable {
        owner = msg.sender;
        updateTotalReceived();
    }
    
    //modifier so that only Employees have access 
    modifier employeesOnly {
        bool contains = false;
        for(uint i = 0; i < employees.length; i++) {
            if(msg.sender == employees[i]){
                contains = true;
            }
        }
        require(contains);
        _;
    }
    
    //modifier so that only the Creator has an access
    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }
    
    //tracking received funds on contract
    function updateTotalReceived() internal ownerOnly {
        totalReceived += msg.value;    
    } 
    
    /*fallback function 
    *each call to contract that has value
    *will call this fallback function
    *which actually just updates received funds on contract
    */
    function() public payable {
        updateTotalReceived();
    }
    
    //function for withdrawing funds
    //if msg.sender is an employee
    //and there is allocated funds for this address
    function withdraw() public employeesOnly {
        uint totalAllocated = totalReceived / employees.length;
        uint amountWithdrown = withdrownAmount[msg.sender];
        uint amount = totalAllocated - amountWithdrown;
        withdrownAmount[msg.sender] = amountWithdrown + amount;
        
        if (amount > 0){
            msg.sender.transfer(amount);
        }
    }
}
