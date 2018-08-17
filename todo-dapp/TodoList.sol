pragma solidity 0.4.20; // declaring the compiler version
contract TodoList { // declaring the contract
    struct Todo{
        bytes32 content; // contents of the list
        address owner; //owner's address
        bool isCompleted;// marking if the owner has completed the list or not
        uint256 timestamp;//timestamp of the document
    }
    
}
