
CREATE DATABASE LibraryManagementSystem;
USE LibraryManagementSystem;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(255),
    AuthorBirthDate DATE
    -- Other Author details
);
-- DROP TABLE AUTHORS;
-- DROP TABLE BOOKS;

ALTER TABLE books
ADD CONSTRAINT FK_AUTHORS_AUTHORID
FOREIGN KEY (AUTHORID) REFERENCES authors(AUTHORID);


SELECT*FROM BOOKS;
SELECT*FROM AUTHORS;

INSERT INTO Authors (AuthorID, AuthorName, AuthorBirthDate) VALUES
    (1, 'Author1', '1990-01-01'),
    (2, 'Author2', '1985-03-15');


CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    ISBN VARCHAR(20),
    AuthorID INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- Other Book details
);
 
CREATE TABLE Library (
    LibraryID INT PRIMARY KEY,
    LibraryName VARCHAR(255),
    Location VARCHAR(255)
    -- Other Library details
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    BookID INT,
    LibraryID INT,
    Quantity INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (LibraryID) REFERENCES Library(LibraryID)
);

-- Insert authors

    
    update authors
	set authorname ="jk"
     where authorID =1;

-- Insert books
INSERT INTO Books (BookID, Title, ISBN, AuthorID, PublishedYear) VALUES
    (101, 'Book1', '123456789', 1, 2010),
    (102, 'Book2', '987654321', 2, 2015),
    (103,'book3','12345678','1',2014);


-- Insert libraries
INSERT INTO Library (LibraryID, LibraryName, Location) VALUES
    (10001, 'Library A', 'City1'),
    (10002, 'Library B', 'City2');

-- Insert inventory
INSERT INTO Inventory (InventoryID, BookID, LibraryID, Quantity) VALUES
    (10001, 101, 1001, 5),
    (10002, 102, 1002, 3);
    select * from  authors;
    select * from books ;			
    select * from  inventory;
    select * from  library;
    select* from borrowedbooks;
    select* from borrowers;
    
    ALTER TABLE Inventory
ADD COLUMN AvailableQuantity INT DEFAULT 0;

CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY,
    BorrowerName VARCHAR(255)
    -- Other Borrower details
);

CREATE TABLE BorrowedBooks (
    BorrowedID INT PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);
alter table borrowedbooks
add column returned  boolean;
ALTER TABLE Inventory
ADD COLUMN ReturnDate DATE;

-- Insert borrowers
insert borrowers( BorrowerID,BorrowerName)
values('1','ajesh'),
        ('2','athul');
-- Insert borrowed books
INSERT INTO BorrowedBooks (BorrowedID, BookID, BorrowerID, BorrowDate, ReturnDate)
 VALUES(100001, 101, 1, '2024-01-17', '2024-01-24'),
		(100002, 102, 2, '2024-01-18', '2024-01-26');
     
        
        drop table BorrowedBooks;

update borrowedbooks 
set returndate=false
where BorrowedID= 100003;
 
 -- Update available quantity in Inventory
UPDATE Inventory
SET AvailableQuantity = Quantity - (SELECT COUNT(*) FROM BorrowedBooks WHERE Inventory.BookID = BorrowedBooks.BookID);
use librarymanagementsystem;






-- --bookid and bookname,authorname-- 
select bookID,Title,authorname
from books
inner join authors ON books.authorID= authors.AuthorID;



-- borrowerid and borrowed date,return date--
select   BorrowedID,BorrowDate,returnDate
from  borrowedbooks
inner join borrowers ON borrowedbooks.BorrowerID= borrowers.BorrowerID;
 
CREATE TRIGGER _insert_data
BEFORE INSERT ON borrowedbooks
FOR EACH ROW
UPDATE inventory
SET AvailableQuantity = AvailableQuantity - 1
WHERE bookID = NEW.BookID;

create trigger update_data
after update  on borrowedbooks
for each row
update inventory
SET AvailableQuantity = AvailableQuantity +1
WHERE bookID = BookID;


drop table bookcategory;

create table publisher(
publisher_id int not null,
publishername varchar(100),
bookID INT,
primary key (publisher_id),
foreign key (bookId)REFERENCES books(bookID)
);

insert into publisher( publisher_id, publishername,bookID)
values('5','blessy','102'),('6','ayyappan','101');


create table author_book(
AuthorID int not null,
bookID int not null,
foreign key (AuthorID) references authors(AuthorID),
foreign key (BOOKID)references BOOKS(BOOKID)
)

SELECT B.Title, AUTHORS.AuthorName
FROM books B
INNER JOIN AUTHOR_BOOK AB ON B.BOOKID = AB.BOOKID
INNER JOIN AUTHORS ON AUTHORS.authorID = AB.AuthorID
 where B.BOOKID =101;

select books.bookname,authors.authorname
from authorsauthor_book
inner join books on authors.authorID=books.authorID

insert author_book(BOOKID,AuthorID)
values('101','1'),
('102','2'),
('103','2');

alter table books
add bookfees int ;

update books
set bookfees="30"
where bookID='103';


CREATE TABLE RentRegister (
RENTID INT PRIMARY KEY,
   BORROWEDID INT,
    BORROWERID INT,
      amount int,
    PaymentDate DATE,
    duerent  int,
    FOREIGN KEY (BORROWEDID ) REFERENCES BORROWEDBOOKS(BORROWEDID),
    FOREIGN KEY ( BORROWERID) REFERENCES BORROWERS( BORROWERID)
);

insert into rentregister(RENTID,BORROWEDID,BORROWERID,amount,PaymentDate,duerent)
values('1','100001','1','20','2025-2-16','0'),
        ('2','100002','2','20','2025-3-13','20');
 









