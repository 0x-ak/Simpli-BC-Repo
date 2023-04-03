pragma solidity ^0.8.0;

contract Library {
    address public owner;
    // the owner of the library
    struct Book {
        string title;
        string author;
        bool checkedOut;
        address borrower;
    }
    mapping(uint256 => Book) public books;
    // mapping of book ids to book structs
    uint256 public bookCount;

    // total number of books in the library
    constructor() {
        owner = msg.sender;
        // set the owner of the library to the contract deployer
    }

    // function to add a new book to the library
    function addBook(string memory _title, string memory _author) public {
        books[bookCount] = Book(_title, _author, false, address(0));
        bookCount++;
    }

    // function to check out a book from the library
    function checkOut(uint256 _id) public {
        require(!books[_id].checkedOut, "Book is already checked out.");
        books[_id].checkedOut = true;
        books[_id].borrower = msg.sender;
    }

    // function to return a book to the library
    function returnBook(uint256 _id) public {
        require(books[_id].checkedOut, "Book is not checked out.");
        require(
            msg.sender == books[_id].borrower,
            "Only the borrower can return the book."
        );
        books[_id].checkedOut = false;
        books[_id].borrower = address(0);
    }

    // function to transfer ownership of the library
    function transferOwnership(address _newOwner) public {
        require(
            msg.sender == owner,
            "Only the current owner can transfer ownership."
        );
        owner = _newOwner;
    }
}
