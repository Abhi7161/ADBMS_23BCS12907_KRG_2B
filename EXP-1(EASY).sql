-- Create Author Table
CREATE TABLE Author_TBL (
  author_id INT PRIMARY KEY,
  name VARCHAR(100),
  country VARCHAR(100)
);

-- Create Book Table
CREATE TABLE Book_TBL (
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES Author_TBL(author_id)
);

-- Insert Authors
INSERT INTO Author_TBL (author_id, name, country) VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George R.R. Martin', 'United States'),
(3, 'Haruki Murakami', 'Japan');

-- Insert Books
INSERT INTO Book_TBL (book_id, title, author_id) VALUES
(101, 'Harry Potter and the Philosopher''s Stone', 1),
(102, 'A Game of Thrones', 2),
(103, 'Kafka on the Shore', 3);

-- Join and Select Data
SELECT
  Book_TBL.title AS Book_Title,
  Author_TBL.name AS Author_Name,
  Author_TBL.country AS Author_Country
FROM
  Book_TBL
INNER JOIN
  Author_TBL ON Book_TBL.author_id = Author_TBL.author_id;