-- DROP TABLES if they already exist (for re-run safety)
DROP TABLE IF EXISTS IssuedBooks;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;

-- 1. Create Tables

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Quantity INT
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

CREATE TABLE IssuedBooks (
    IssueID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 2. Insert Sample Data

INSERT INTO Books VALUES 
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 5),
(2, 'Clean Code', 'Robert C. Martin', 'Programming', 3),
(3, 'Atomic Habits', 'James Clear', 'Self-help', 4);

INSERT INTO Members VALUES 
(101, 'Dishant Chaudhari', 'dishant@email.com', '2023-01-10'),
(102, 'Riya Patel', 'riya@email.com', '2023-02-15');

INSERT INTO IssuedBooks VALUES 
(1001, 1, 101, '2024-04-01', '2024-04-15'),
(1002, 2, 102, '2024-04-05', '2024-04-20');

-- 3. Queries

-- List all books
SELECT * FROM Books;

-- List all members
SELECT * FROM Members;

-- List all issued books with member and book names
SELECT IB.IssueID, B.Title, M.Name, IB.IssueDate, IB.ReturnDate
FROM IssuedBooks IB
JOIN Books B ON IB.BookID = B.BookID
JOIN Members M ON IB.MemberID = M.MemberID;

-- Show available copies of each book
SELECT Title, Quantity FROM Books;

-- Show overdue books (assuming today is '2024-04-16')
SELECT M.Name, B.Title, IB.ReturnDate
FROM IssuedBooks IB
JOIN Books B ON IB.BookID = B.BookID
JOIN Members M ON IB.MemberID = M.MemberID
WHERE IB.ReturnDate < '2024-04-16';
