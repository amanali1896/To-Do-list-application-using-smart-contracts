pragma solidity 0.4.20; // declaring the compiler version
contract TodoList { // declaring the contract
    struct Todo{
        uint256 id;
        bytes32 content; // contents of the list
        address owner; //owner's address
        bool isCompleted;// marking if the owner has completed the list or not
        uint256 timestamp;//timestamp of the document/note being created.
    }
    uint256 public constant maxAmountOfTodos = 100; /*This variable limits the amount of lists*/ 
    // Owner => todos
    mapping(address => Todo[maxAmountOfTodos]) public todos;// address of one user is mapped to all the notes created by user.
    // Owner => last todo id
    mapping(address => uint256) public lastIds;/* we store the last IDs of each user required to create new notes.
                                                We do this since to add a new note we need to have track of the last used note id*/
}
