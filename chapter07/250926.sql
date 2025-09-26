USE exdb;

SELECT * FROM customers;

SELECT * FROM suppliers;

INSERT INTO customers 
	(CustomerName, ContactName, Address, City, PostalCode, Country)
SELECT 
	SupplierName, ContactName, Address, City, PostalCode, Country
FROM Suppliers;

SELECT * FROM customers;

SELECT * FROM suppliers;

INSERT INTO customers 
	(CustomerName, City, Country)
SELECT 
	SupplierName, City, Country
FROM Suppliers
WHERE Country='Germany';

SELECT * FROM customers;

-- order_summary_view view를 생성하여 orderdetails 테이블의 데이터에서
-- orderid를 그룹화하여 quantity를 더한 값을 조건에 맞게 quantityText라는
-- colum을 추가함
CREATE VIEW order_summary_view AS 
SELECT orderid, sum(quantity) AS total_quantity,
case
	when MAX(quantity) > 30 then 'The quantity is greater than 30'
	when MAX(quantity) = 30 then 'The quantity is 30'
	ELSE 'The quantity is under 30'
END AS QuantityText
FROM orderdetails
GROUP by orderid
HAVING SUM(quantity) > 100;

SELECT * FROM ORDER_summary_view;

SELECT * FROM products;

CREATE TABLE person(
	PersonID INT,
	LastName VARCHAR(255),
	FirstName VARCHAR(255),
	Address VARCHAR(255),
	City VARCHAR(255)
);

DESC person;

ALTER TABLE person
ADD DateOfBirth DATE;

ALTER TABLE person
MODIFY COLUMN DateOfBirth YEAR;

ALTER TABLE person
DROP COLUMN DateOfBirth;

DESC person;