use sqlproject;

CREATE TABLE TLB_Publisher (
    PublisherName VARCHAR(255) PRIMARY KEY,
    PublisherAddress VARCHAR(255),
    PublisherPhone VARCHAR(20)
);

CREATE TABLE TLB_Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    PublisherName VARCHAR(255),
    FOREIGN KEY (PublisherName) REFERENCES TLB_Publisher(PublisherName) ON DELETE CASCADE
);

CREATE TABLE TLB_BookAuthors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    AuthorName VARCHAR(255),
    FOREIGN KEY (BookID) REFERENCES TLB_Book(BookID) ON DELETE CASCADE
);

CREATE TABLE TLB_LibraryBranch (
    BranchID INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(255),
    BranchAddress VARCHAR(255)
);

CREATE TABLE TLB_BookCopies (
    CopiesID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BranchID INT,
    NoOfCopies INT CHECK (NoOfCopies >= 0),
    FOREIGN KEY (BookID) REFERENCES TLB_Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (BranchID) REFERENCES TLB_LibraryBranch(BranchID) ON DELETE CASCADE
);

CREATE TABLE TLB_Borrower (
    CardNo INT AUTO_INCREMENT PRIMARY KEY,
    BorrowerName VARCHAR(255),
    BorrowerAddress VARCHAR(255),
    BorrowerPhone VARCHAR(20)
);
CREATE TABLE TLB_BookLoans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BranchID INT,
    CardNo INT,
    DateOut DATE DEFAULT (CURRENT_DATE),
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES TLB_Book(BookID) ON DELETE CASCADE,
    FOREIGN KEY (BranchID) REFERENCES TLB_LibraryBranch(BranchID) ON DELETE CASCADE,
    FOREIGN KEY (CardNo) REFERENCES TLB_Borrower(CardNo) ON DELETE CASCADE
);

SELECT * FROM tlb_publisher;
SELECT * FROM tlb_book;
SELECT * FROM tlb_bookauthors;
SELECT * FROM tlb_librarybranch;
SELECT * FROM tlb_bookcopies;
SELECT * FROM tlb_borrower;
SELECT * FROM tlb_bookloans;


SELECT * FROM Publisher;
SELECT * FROM Books;
SELECT * FROM Authors;
SELECT * FROM `library branch`;
SELECT * FROM BookCopies;
SELECT * FROM Borrower;
SELECT * FROM BookLoans;


#####1
SELECT SUM(NoOfCopies) AS TotalCopies
FROM TLB_BookCopies BC
JOIN TLB_LibraryBranch LB ON BC.BranchID = LB.BranchID
JOIN TLB_Book B ON BC.BookID = B.BookID
WHERE B.Title = 'The Lost Tribe' AND LB.BranchName = 'Sharpstown';

#####2
SELECT LB.BranchName, SUM(BC.NoOfCopies) AS TotalCopies
FROM TLB_BookCopies BC
JOIN TLB_LibraryBranch LB ON BC.BranchID = LB.BranchID
JOIN TLB_Book B ON BC.BookID = B.BookID
WHERE B.Title = 'The Lost Tribe'
GROUP BY LB.BranchName;

#####3
SELECT B.BorrowerName
FROM TLB_Borrower B
LEFT JOIN TLB_BookLoans BL ON B.CardNo = BL.CardNo
WHERE BL.LoanID IS NULL;

#####4
SELECT B.Title, BR.BorrowerName, BR.BorrowerAddress
FROM TLB_BookLoans BL
JOIN TLB_Book B ON BL.BookID = B.BookID
JOIN TLB_Borrower BR ON BL.CardNo = BR.CardNo
JOIN TLB_LibraryBranch LB ON BL.BranchID = LB.BranchID
WHERE LB.BranchName = 'Sharpstown' AND BL.DueDate = '2018-02-03';

#####5
SELECT LB.BranchName, COUNT(BL.LoanID) AS TotalBooksLoaned
FROM TLB_BookLoans BL
JOIN TLB_LibraryBranch LB ON BL.BranchID = LB.BranchID
GROUP BY LB.BranchName;

#####6
SELECT B.BorrowerName, B.BorrowerAddress, COUNT(BL.LoanID) AS BooksCheckedOut
FROM TLB_Borrower B
JOIN TLB_BookLoans BL ON B.CardNo = BL.CardNo
GROUP BY B.BorrowerName, B.BorrowerAddress
HAVING COUNT(BL.LoanID) > 5;

#####7
SELECT B.Title, SUM(BC.NoOfCopies) AS TotalCopies
FROM TLB_Book B
JOIN TLB_BookAuthors BA ON B.BookID = BA.BookID
JOIN TLB_BookCopies BC ON B.BookID = BC.BookID
JOIN TLB_LibraryBranch LB ON BC.BranchID = LB.BranchID
WHERE BA.AuthorName = 'Stephen King' AND LB.BranchName = 'Central'
GROUP BY B.Title;





