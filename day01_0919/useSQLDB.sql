USE sqlDB;
SELECT * FROM userTbl;

SELECT * FROM userTbl WHERE NAME = '김경호';

SELECT userId, NAME FROM userTbl WHERE birthYear >= 1970 AND height >= 182;

SELECT userid, NAME FROM usertbl WHERE birthYear >= 1970 OR height >= 182;

SELECT NAME, height FROM usertbl WHERE height >= 180 AND height <=183;

SELECT NAME, addr FROM usertbl WHERE addr='경남' OR addr='전남' OR addr='경북';

SELECT NAME, addr FROM usertbl WHERE addr IN ('경남', '전남', '경북');

SELECT NAME, height FROM usertbl WHERE NAME LIKE '김%';

SELECT NAME, height FROM usertbl WHERE NAME LIKE '_종신';

SELECT NAME, height FROM usertbl WHERE height > 177;

SELECT NAME, height FROM usertbl WHERE height > (SELECT height FROM usertbl WHERE NAME = '김경호');

-- SELECT Name, height FROM userTbl WHERE height >= (SELECT height FROM userTbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl WHERE height >=ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, mdate FROM usertbl ORDER BY mdate;

SELECT NAME, mdate FROM usertbl ORDER BY mdate DESC;

SELECT NAME, height FROM usertbl ORDER BY height DESC, NAME ASC;

SELECT addr FROM usertbl;

SELECT addr FROM usertbl ORDER BY addr;

SELECT DISTINCT addr FROM usertbl;

USE sqlDB;

CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

CREATE TABLE buytbl3 (SELECT userid, prodName FROM buytbl);
SELECT * FROM buytbl3;

SELECT userid, amount FROM buytbl ORDER BY userid;

SELECT userid, SUM(amount) FROM buytbl GROUP BY userid;

SELECT userid AS '사용자 아이디', SUM(amount) AS '총 구매 개수' FROM buytbl GROUP BY userid;

SELECT userid AS '사용자 아이디', SUM(price*amount) AS '총 구매액' FROM buytbl GROUP BY userid;

SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl;

SELECT userid, AVG(amount) AS '평균 구매 개수' FROM buytbl GROUP BY userid;

-- 이상한 결과값
SELECT NAME, MAX(height), MIN(height) FROM usertbl;

SELECT NAME, MAX(height), MIN(height) FROM usertbl GROUP BY NAME;

-- 가장 큰 키와 가장 작은키를 가진 사람 조회 ( 내림차순 )
SELECT NAME, height FROM usertbl WHERE height = (SELECT MAX(height) FROM usertbl) OR height = (SELECT MIN(height) FROM usertbl) order by NAME DESC;

-- 데이터 개수 확인 (count *)
SELECT COUNT(*) FROM usertbl;

SELECT COUNT(mobile1) AS '휴대폰이 있는 사용자' FROM usertbl;

-- 사용자별 총 구매액 집계
SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buytbl GROUP BY userid;

-- where 절에서 집계(SUM) 함수 사용 불가. having 사용
-- SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buytbl WHERE SUM(price*amount) > 1000 GROUP BY userid;

SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buytbl GROUP BY userid HAVING SUM(price*amount) > 1000;

SELECT userid AS '사용자', SUM(price*amount) AS '총구매액' FROM buytbl GROUP BY userid HAVING SUM(price*amount) > 1000 ORDER BY SUM(price*amount);

SELECT num, groupName, SUM(price*amount) AS '비용' FROM buytbl GROUP BY groupName,num WITH ROLLUP;

CREATE TABLE testTBL1 (id INT, userName CHAR(3), age INT);

INSERT INTO testTBL1 VALUES(1, '홍길동', 25);

INSERT INTO testtbl1(id, userName) VALUES(2, '설현');

INSERT INTO testtbl1(username, age, id) VALUES('초아', 26, 3);

USE sqlDB;
CREATE TABLE testTBL2
	(id INT AUTO_INCREMENT PRIMARY KEY,
	username CHAR(3),
	age INT);
	
INSERT INTO testtbl2 VALUES (NULL, '지민', 25);
INSERT INTO testtbl2 VALUES (NULL, '유나', 22);