-- < MariaDB 설계 과정평가형 > --

-- < 도서관리 Book >
-- 1. 테이블을 생성하시오. (제약조건 포함)
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




-- < 사원관리 Employee >

-- 1. 테이블을 생성하시오. (제약조건 포함)
/*
Employee(사원관리) 테이블
Column :
EmpNo (사번, INT, PRIMARY KEY, AUTO_INCREMENT)
EmpName (사원명, VARCHAR(30), NOT NULL)
Dept ( 부서명, VARCHAR(20), NOT NULL)
HireDate (입사일, DATE, NOT NULL)
Salary ( 급여, INT, CHECK(Salary >= 2000000 ))

제약조건
EmpName은 중복될 수 없다.
급여(Salary)는 2,000,000원 이상만 입력 가능하다.
*/

-- db 생성
CREATE DATABASE employeedb;

-- db 선택
USE employeedb;

-- Employee 테이블 삭제
DROP TABLE employee;

-- Employee 테이블 생성
CREATE TABLE Employee(
	EmpNo INT PRIMARY KEY AUTO_INCREMENT,
	EmpName VARCHAR(30) NOT NULL UNIQUE,
	Dept VARCHAR(20) NOT NULL,
	HireDate DATE NOT NULL,
	Salary INT,
	CONSTRAINT CHECK_SALARY CHECK (Salary>= 2000000)
);

-- Employee 테이블 조회
SELECT * FROM Employee;
SHOW CREATE TABLE Employee;
DESC Employee;

-- 2. SQL 문을 작성하시오.

-- (1) 사원등록: Employee 테이블에 다음 데이터를 삽입하시오.
--	(홍길동, 영업부, 2020-03-01, 2500000)
--	(이순신, 인사부, 2019-07-15, 3200000)
--	(강감찬, 개발부, 2021-01-10, 2800000)
	INSERT INTO Employee(EmpName, Dept, HireDate, Salary) VALUES('홍길동', '영업부', '2020-03-01', 2500000);
	INSERT INTO Employee(EmpName, Dept, HireDate, Salary) VALUES('이순신', '인사부', '2019-07-15', 3200000);
	INSERT INTO Employee(EmpName, Dept, HireDate, Salary) VALUES('강감찬', '개발부', '2021-01-10', 2800000);
-- (2) 조회 :
--	부서가 '개발부'인 사원의 사번, 이름, 급여를 조회하시오.
	SELECT EmpNo, EmpName, Salary FROM Employee e WHERE e.Dept = '개발부';
-- 급여가 3,000,000원 이상인 사원의 이름과 부서를 조회하시오.
	SELECT EmpName, Dept FROM Employee e WHERE e.Salary >= 3000000;
-- (3) 수정 :
-- 이순신의 급여를 3,500,000원으로 수정하시오.
	UPDATE Employee SET Salary = 3500000 WHERE EmpName='이순신';
-- (4) 삭제 :
-- - 사번이 1번인 사원의 정보를 삭제하시오.
	DELETE from Employee WHERE EmpNo=1;
	


-- < 홈쇼핑 회원 관리 ShopMember >

-- 1. 테이블을 생성하시오. (제약조건 포함)
/*
-- ShopMember (회원관리) 테이블 --
컬럼명과 제약조건:
CustNo (회원번호, INT, PRIMARY KEY, AUTO_INCREMENT)
CustName (회원성명, VARCHAR(30), NOT NULL)
Phone (전화번호, VARCHAR(13), UNIQUE)
Address (주소, VARCHAR(50))
JoinDate (가입일자, DATE, NOT NULL)
Grade (고객등급, CHAR(1), CHECK(Grade IN ('A','B','C')))
City (도시코드, CHAR(2))

-- Sale (판매) 테이블
컬럼명과 제약조건:
SaleNo (판매번호, INT, PRIMARY KEY, AUTO_INCREMENT)
CustNo (회원번호, INT, FK: ShopMember.CustNo 참조)
PCost (단가, INT)
Amount (수량, INT)
Price (금액, INT)
PCode (상품코드, CHAR(3))
*/

CREATE TABLE ShopMember(
	CustNo INT PRIMARY KEY AUTO_INCREMENT,
	CustName VARCHAR(30) NOT NULL,
	Phone VARCHAR(13) UNIQUE,
	Address VARCHAR(50),
	JoinDate DATE NOT NULL,
	Grade CHAR(1),
	City CHAR(2),
	CONSTRAINT CHECK_GRADE CHECK(Grade IN ('A','B','C'))
);

CREATE TABLE Sale(
	SaleNo INT PRIMARY KEY AUTO_INCREMENT,
	CustNo INT,
	PCost INT,
	Amount INT,
	Price INT,
	PCode CHAR(3),
	FOREIGN KEY (CustNo) REFERENCES shopmember(CustNo)
);

SELECT * FROM shopmember;
SELECT * FROM Sale;

-- 2. SQL문을 작성하시오.

-- (1) 회원 등록: ShopMember 테이블에 다음 데이터를 삽입하시오.
	INSERT INTO shopmember(CustName, Phone, Address, JoinDate, Grade, City) VALUES('홍길동', '010-1234-5678', '서울시 강남구', '2020-01-01', 'A', '01');
	INSERT INTO ShopMember(CustName, Phone, Address, JoinDate, Grade, City) VALUES('이순신', '010-2222-3333', '부산시 해운대구', '2021-03-15', 'B', '02');
	INSERT INTO ShopMember(CustName, Phone, Address, JoinDate, Grade, City) VALUES('강감찬', '010-7777-8888', '대구시 달서구', '2019-05-20', 'C', '03');
	
-- (2) 회원 조회
-- 고객등급이 A등급인 회원의 이름, 전화번호, 가입일자를 조회
	SELECT CustName, Phone, JoinDate FROM shopmember s WHERE Grade='A';
	
--	가입일자가 2020년 이후인 회원을 조회
	SELECT * FROM shopmember s WHERE s.JoinDate >= 2020;

-- (3) 판매 등록: Sale 테이블에 삽입하시오.
	INSERT INTO Sale(CustNo, PCost, Amount, Price, PCode) VALUES(1, 1000, 10, 10000, 'P01');
	INSERT INTO Sale(CustNo, PCost, Amount, Price, PCode) VALUES(2, 2000, 5, 10000, 'P02');
	INSERT INTO Sale(CustNo, PCost, Amount, Price, PCode) VALUES(3, 1500, 7, 10500, 'P03');

-- (4) 판매 조회
-- 회원별 총 구매금액을 구하시오(출력: 회원번호, 회원성명, 총금액)
	SELECT sm.CustNo, sm.CustName, s.Price FROM shopmember sm JOIN Sale s ON sm.CustNo = s.CustNo;

-- 가장 구매금액이 높은 회원의 이름과 금액을 조회하시오
	SELECT sm.CustName, s.Price FROM shopmember sm JOIN sale s ON sm.CustNo = s.CustNo WHERE s.Price = (SELECT MAX(price) from sale);
	
-- (5) 데이터 수정 / 삭제
-- '이순신' 회원의 등급을 A로 수정하시오
	UPDATE shopmember SET grade='A' WHERE CustName='이순신';
	
-- CustNo = 3 인 회원을 삭제하시오
-- Sale 테이블에서 해당 회원의 판매 기록 먼저 삭제(FOREIGN KEY로 인한 문제점)
	DELETE FROM Sale WHERE CustNo = 3;

-- ShopMember 테이블에서 회원 삭제
	DELETE FROM ShopMember WHERE CustNo = 3;



