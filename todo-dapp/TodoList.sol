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
    mapping(address => Todo[maxAmountOfTodos]) public todos;/* address of one user is mapped 
                                                                to all the notes created by user.*/
    mapping(address => uint256) public lastIds;/* we store the last IDs of each user required to create new notes.
                             We do this since to add a new note we need to have track of the last used note id*/
    modifier onlyOwner(address _owner) { /* this is done so that only the real owner of the note can access 
                                        the note and moify its contents*/ 
        require(msg.sender == _owner); /*only if this condition is true then
                                        execute the function else throw an exception*/
        _;
    }
    // Add a todo to the list
    function addTodo(bytes32 _content) public { /* this is declared to create the 
                                                contents */

        Todo memory myNote = Todo(lastIds[msg.sender], // creating the note by adding the values in its constructor
            _content, msg.sender, false, now); /** “memory”,  is used to hold temporary values. */
        todos[msg.sender][lastIds[msg.sender]] = myNote; /** I am now adding the created note to the mapping. 
                                                            which means that we add the note to the already existing 
                                                            notes by the user  */
        if (lastIds[msg.sender] >= maxAmountOfTodos) //last ID is updated so that we have a track of the note numbers. 
                                                    // is restricted to 100
            lastIds[msg.sender] = 0; //if it overflows
                                        
        else 
            lastIds[msg.sender]++; //incrementing it by one
    }
    // Mark a todo as completed
    function markTodoAsCompleted(uint256 _todoId) public 
    onlyOwner(todos[msg.sender][_todoId].owner) { /**this is used to mark if the notes as completed*/
                                                // if you remember we declared a modifier. now we will access this function
                                                //only if that modifier gets executed. 
        require(_todoId < maxAmountOfTodos); /* _todoID is the id of the list  */
        require(!todos[msg.sender][_todoId].isCompleted); // if the note is not marked as true, then mark it as true
        todos[msg.sender][_todoId].isCompleted = true;
    }
}
