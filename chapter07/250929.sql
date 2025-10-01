SHOW DATABASES;
USE exdb;

SHOW TABLES;
SELECT * FROM person;

-- 테이블 생성
CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	Age INT
);

-- 테이블 삭제
-- DROP TABLE persons;

DESCRIBE persons;

-- 테이블 필드구조 수정
ALTER TABLE persons MODIFY Age INT NOT NULL;

ALTER TABLE persons
MODIFY Age INT;

ALTER TABLE persons MODIFY ID INT PRIMARY KEY;

-- 필드 구조 확인
DESCRIBE persons; 

ALTER TABLE persons DROP PRIMARY KEY; -- Primary key 제거
ALTER TABLE persons MODIFY id INT NULL; -- not null -> null로 변경

DESCRIBE persons;

-- 테이블 생성시 유니크값 명시
CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	UNIQUE (ID) -- Primary key 생성
);

DESCRIBE persons;

DROP TABLE persons;
SELECT * FROM persons;

-- UNIQUE(ID) : 1,2,3,... ID 값이 중복안됨.
-- UNIQUE(ID, LastName) : ID + LastName 조합 중복 불가
-- 예 : (1, 'Kim'), (1, 'Lee'), (1, 'Kim')이 두번들어가면 오류발생
-- 이름 UC_Person은 UNIQUE 제약의 식별자
CREATE TABLE Persons (
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	CONSTRAINT UC_Person UNIQUE (ID, LastName)
);

DESCRIBE persons;

-- persons 테이블에 설정된 인덱스 정보 확인
-- 어떤 컬럼에 인덱스가 걸려있는지
-- PRIMARY KEY, UNIQUE, 일반 인덱스 여부
-- 복합 인덱스 구성 순서
SHOW INDEX FROM persons;

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);
DESC persons;

ALTER TABLE persons ADD UNIQUE (ID);

DESC persons;

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE persons(
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);
DESC persons;

-- 제약조건 추가
ALTER TABLE persons
ADD CONSTRAINT UC_Person UNIQUE(ID, LastName);

-- 제약조건 삭제
ALTER TABLE persons
DROP INDEX UC_Person;

SHOW INDEX from persons;
DESC persons;

SELECT * 
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'persons';

SELECT CONSTRAINT_NAME, constraint_type, TABLE_NAME
FROM information_schema.table_constraints
WHERE TABLE_NAME = 'persons';

SELECT CONSTRAINT_NAME, COLUMN_NAME, ordinal_position
FROM information_schema.key_column_usage
WHERE TABLE_NAME = 'persons'
AND CONSTRAINT_NAME = 'uc_person';

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE Persons (
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	PRIMARY KEY (ID)
);

DESCRIBE persons;

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE Persons (
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT,
	CONSTRAINT PK_Person PRIMARY KEY (ID, LastName)
);

DESC persons;
SHOW INDEX FROM persons;

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE Persons (
	ID INT NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	FirstName VARCHAR(255),
	Age INT
);

DESC persons;

ALTER TABLE persons
ADD PRIMARY KEY (ID);

DESC persons;

ALTER TABLE persons
DROP PRIMARY KEY;

DESC persons;

ALTER TABLE persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID, LastName);

DESC persons;
SHOW INDEX FROM persons;

ALTER TABLE persons
DROP PRIMARY KEY;

DESC persons;
SHOW INDEX FROM persons;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

CREATE TABLE orders_f (
	OrderID INT NOT NULL,
	ORDERNumber INT NOT NULL,
	PersonID INT,
	PRIMARY KEY (OrderID),
	FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

SELECT * FROM persons;
DESC persons;

-- 필드명(컬럼명) 수정
ALTER TABLE persons
CHANGE personsid personid INT;

ALTER TABLE persons
ADD PRIMARY KEY (personid);

DESC persons;

USE exdb;

SELECT * FROM orders_f;
SELECT * FROM persons;

DESC orders_f;
DESC persons;

SHOW CREATE TABLE orders_f;

ALTER TABLE orders_f DROP FOREIGN KEY orders_f_ibfk_1;

ALTER TABLE orders_f
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES persons(personid);

SHOW index from orders_f;

-- 제약조건 제거
ALTER TABLE Orders_f
DROP FOREIGN KEY FK_PersonOrder;

SHOW CREATE table orders_f;

DESC orders_f;

-- 제약조건 제거 후 남은 index 제거
ALTER TABLE orders_f DROP INDEX FK_PersonOrder;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

DROP TABLE persons;

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City VARCHAR(255)
);

DESC persons;

ALTER TABLE persons
ADD CONSTRAINT PRIMARY KEY (id);

DESC persons;

SHOW CREATE table persons;

-- Check 제약조건 제거
ALTER TABLE persons DROP CONSTRAINT CONSTRAINT_1;

ALTER TABLE persons ADD CHECK (age>=18);

SHOW CREATE TABLE persons;

ALTER TABLE persons DROP CONSTRAINT CONSTRAINT_1;

SHOW CREATE TABLE persons;

ALTER TABLE persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18);

SHOW CREATE TABLE persons;

ALTER TABLE persons
DROP constraint CHK_PersonAge;

SHOW CREATE TABLE persons;

DESC persons;

ALTER TABLE persons
ADD PRIMARY KEY (id);

ALTER TABLE persons
ADD CONSTRAINT CHECK (Age>=18 AND City='Sandnes');

DESC persons;
SHOW CREATE TABLE persons;

ALTER TABLE persons
DROP CONSTRAINT CONSTRAINT_1;

SHOW CREATE TABLE persons;

ALTER TABLE persons
ADD CONSTRAINT CHK_PersonAgeCity CHECK (Age>=18 AND City='FuckingCity');

SHOW CREATE TABLE persons;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

DROP TABLE persons;
SELECT * FROM persons;

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'fuckingCity'
);

DROP TABLE orders_f;
SELECT * FROM orders_f;

CREATE TABLE orders_f (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT CURRENT_DATE()
);

DESC orders_f;

ALTER TABLE persons
ALTER city SET DEFAULT 'sandnes';

DESC persons;

ALTER TABLE persons
ALTER city DROP DEFAULT;

DESC persons;

ALTER TABLE orders_f
ALTER orderdate DROP DEFAULT;

DESC orders_f;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
-- < Create Index > --

-- 테스트 테이블 생성
CREATE TABLE customers_test (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  email VARCHAR(255),
  city VARCHAR(100)
);

-- 데이터 대량 삽입

-- 삽입 전 중복 프로시저 확인 후 삭제
DROP PROCEDURE IF EXISTS insert_customers_test;

DELIMITER $$

CREATE PROCEDURE insert_customers_test()
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE city_name VARCHAR(100);

  WHILE i <= 100000 DO
    SET city_name = ELT(FLOOR(1 + RAND() * 10), 
      'Seoul', 'Busan', 'Daegu', 'Incheon', 'Gwangju', 
      'Daejeon', 'Ulsan', 'Suwon', 'Changwon', 'Jeju');

    INSERT INTO customers_test (name, email, city)
    VALUES (
      CONCAT('Customer_', i),
      CONCAT('customer_', i, '@example.com'),
      city_name
    );

    SET i = i + 1;
  END WHILE;
END$$

DELIMITER ;

-- 프로시저 실행
CALL insert_customers_test();

-- 프로시저 확인
SHOW PROCEDURE STATUS WHERE Name = 'insert_customers_test';

-- 데이터 확인
SELECT COUNT(*) FROM customers_test;

-- 인덱스 없이 검색
EXPLAIN SELECT * FROM customers_test WHERE city = 'jeju';

-- 인덱스 생성
CREATE INDEX idx_city ON customers_test(city);

-- 인덱스 적용 후 검색
EXPLAIN SELECT * FROM customers_test WHERE city = 'jeju';

-- 인덱스 제거
ALTER TABLE customers_test DROP INDEX idx_city;

-- 인덱스 생성 직후 통계 미반영 해결방법 1
ANALYZE TABLE customers_test;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
-- < Create View > --

/*
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
*/

-- View 생성
CREATE VIEW `Brazil Customers` AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';

-- View 사용
SELECT * FROM `Brazil Customers`;

-- Products 테이블에서 평균 가격보다 가격이 높은 모든 제품을 선택하는 뷰 생성
CREATE VIEW `Products Above Average Price` AS
SELECT ProductName, Price
FROM products
WHERE Price > (SELECT AVG(Price) FROM products);

SELECT * FROM `products above average price`;

-- View 업데이트

/*
CREATE OR REPLACE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
*/

CREATE OR REPLACE VIEW `brazil customers` AS
SELECT customername, contactname, city
FROM customers
WHERE country = 'brazil';

SELECT * FROM `brazil customers`;

-- View 삭제
DROP VIEW `brazil customers`;

-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

-- < 도서관리 MariaDB 설계 과정평가형 > --
CREATE DATABASE bookDB;
USE bookDB;

CREATE TABLE Book (
	BookID INT AUTO_INCREMENT PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Author VARCHAR(255),
	Publisher VARCHAR(255),
	Price INT,
	PubYear YEAR
);

INSERT INTO book(BookID, Title, Author, Publisher, Price, PubYear) 
VALUES(1, '도서1', '저자1', '출판사1', 1000, '2019');
INSERT INTO book(BookID, Title, Author, Publisher, Price, PubYear) 
VALUES(2, '도서2', '저자2', '출판사2', 1000, '2020');
INSERT INTO book(BookID, Title, Author, Publisher, Price, PubYear) 
VALUES(3, '도서3', '저자3', '출판사3', 1000, '2021');
INSERT INTO book(BookID, Title, Author, Publisher, Price, PubYear) 
VALUES(4, '도서4', '저자4', '출판사4', 1000, '2022');
INSERT INTO book(BookID, Title, Author, Publisher, Price, PubYear) 
VALUES(5, '도서5', '저자5', '출판사5', 2000, '2023');

-- price 제약조건
ALTER TABLE book
ADD CONSTRAINT CHECK_PRICE CHECK (price>= 0);

SELECT * FROM book;
DESCRIBE book;
SHOW CREATE TABLE book;

CREATE TABLE Member(
	MemberID INT PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Phone VARCHAR(255),
	Address VARCHAR(255)
);

INSERT INTO member(MemberID, NAME, phone, address)
VALUES(1, '홍길동', '010-1234-5678', 'hong@naver.com');
INSERT INTO member(MemberID, NAME, phone, address)
VALUES(2, '이주환', '010-2345-6789', 'lee@naver.com');
INSERT INTO member(MemberID, NAME, phone, address)
VALUES(3, '박근철', '010-3456-7890', 'park@naver.com');

SELECT * FROM member;
DESCRIBE member;

CREATE TABLE Rental(
	RentalID INT,
	MemberID INT,
	BookID INT,
	RentDate YEAR,
	ReturnDate YEAR,
	PRIMARY KEY(RentalID),
	FOREIGN KEY(MemberID) REFERENCES member(MemberID),
	FOREIGN KEY(BookID) REFERENCES book(BookID)
);

INSERT INTO rental(RentalID, MemberID, BookID, RentDate, ReturnDate)
VALUES(100, 1, 1, '2019', '2019');
INSERT INTO rental(RentalID, MemberID, BookID, RentDate, ReturnDate)
VALUES(101, 2, 2, '2020', '2020');
INSERT INTO rental(RentalID, MemberID, BookID, RentDate, ReturnDate)
VALUES(102, 3, 3, '2021', '2021');
INSERT INTO rental(RentalID, MemberID, BookID, RentDate, ReturnDate)
VALUES(103, 1, 4, '2022', null);

SELECT * FROM Rental;
DESCRIBE Rental;
SHOW CREATE TABLE Rental;


-- 2. SQL 문을 작성하시오.

-- (1) 2020년 이후 출판된 도서를 검색하시오.
SELECT * FROM book WHERE pubyear >= 2020

-- (2) '홍길동' 회원이 대출한 도서 목록을 출력하시오.
SELECT b.title, b.author, r.rentdate, r.returndate
FROM rental r
JOIN member m ON r.memberid = m.memberid
JOIN book b ON r.bookid = b.bookid
WHERE m.name = '홍길동';

-- (3) 반납하지 않은 도서를 검색하시오.
SELECT r.rentalid, m.name, b.title, r.rentdate
FROM rental r
JOIN member m ON r.memberid = m.memberid
JOIN book b ON r.bookid = b.bookid
WHERE r.returndate IS NULL;

-- (4) 도서별 대출 횟수를 출력하시오.
SELECT b.title, COUNT(*) AS rent_count
FROM rental r
JOIN book b ON r.bookid = b.bookid
GROUP BY b.title
ORDER BY rent_count DESC;book

-- (5) 가격이 가장 비싼 도서를 출력하시오.
SELECT * FROM book
WHERE price = (SELECT MAX(price) FROM book);


-- 전체 테이블 조회
SELECT * FROM book;
SELECT * FROM member;
SELECT * FROM rental;






