/*
CREATE TABLE indexTBL (first_name VARCHAR(14), last_name VARCHAR(16), hire_date DATE);
INSERT INTO indexTBL
	SELECT FIRST_name, last_name, hire_date
	FROM employees.employees
	LIMIT 500;
SELECT * FROM indexTBL; */

explain SELECT * FROM INDEXtbl WHERE FIRST_name = 'mary';

-- Index --
CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);

explain SELECT * FROM indexTBL WHERE first_name = 'Mary';

-- View --
CREATE VIEW uv_memberTBL AS SELECT memberName, memberAddress FROM membertbl;

SELECT * FROM uv_memberTBL;

-- Stored Procedure --
-- SELECT * FROM membertbl WHERE memberName = '당탕이';
-- SELECT * FROM producttbl WHERE productName = '냉장고';

/*
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM membertbl WHERE memberName = '당탕이';
	SELECT * FROM producttbl WHERE productName = '냉장고';
END //
DELIMITER ; */

CALL myProc();