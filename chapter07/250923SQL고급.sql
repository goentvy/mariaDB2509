-- 날짜와 시간 데이터 형식
SELECT CAST('2020-10-19 12:35:29.123' AS DATE) AS 'date'; -- 2020-10-19
SELECT CAST('2020-10-19 12:35:29.123' AS time) AS 'time'; -- 12:35:29
SELECT CAST('2020-10-19 12:35:29.123' AS DATEtime) AS 'datetime'; -- 2020-10-19 12:35:29

-- LONGTEXT, LONGBLOB

-- 변수의 사용
-- SET @변수이름 = 변수의 값	-- 변수의 선언 및 값 대입
-- SELECT @변수이름; 		 	 -- 변수의 값 출력

USE sqlDB;

SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름==> ';
SELECT @myVar1;
SELECT @myVar2 + @myVar3;
SELECT @myVar4, NAME FROM usertbl WHERE height > 180;

SET @myVar1 = 3;
PREPARE myQuery
	FROM 'select name, height from usertbl order by height limit ?';
	EXECUTE myQuery USING @myVar1;

/*
PREPARE 쿼리이름 FROM '쿼리문' << 준비
EXECUTE 쿼리 이름을 만나는 순간 실행
EXECUTE는 USING @변수를 이용해서 '쿼리문'에서 ?으로 처리해 놓은 부분에 대입하여 실행
*/

-- 데이터 형식과 형 변환
-- CAST(), CONVERT() 함수 사용
-- CAST ( expression AS 데이터형식 [ (길이) ] )
-- CONVERT ( expreesion, 데이터형식 [ (길이) ] )

USE sqlDB;
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl; -- 2.9167

SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl; -- 3

SELECT CONVERT(AVG(amount) , SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl; -- 3

SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

-- 쿼리 실행 결과(4개 모두 동일)

-- 단가Price와 수량amount를 곱한 실제 입금액 표시하는 쿼리
SELECT num, CONCAT(CAST(price AS CHAR(10)), 'x', CAST(amount AS CHAR(4)), '=' ) AS '단가x수량', price*amount AS '구매액' FROM buytbl;

-- 암시적인 형 변환
SELECT '100'+'200'; -- 문자와 문자를 더함(정수로 변환되서 연산됨)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수가 문자로 변환되서 처리)
SELECT 1 > '2mega'; -- 정수 2로 변환되어서 비교
SELECT 3 > '2mega'; -- 정수 2로 변환되어서 비교
SELECT 0 = 'mega2'; -- 문자는 0으로 변환됨

-- MariaDB 내장 함수와 윈도 함수

-- 제어 흐름 함수
-- if(수식, 참, 거짓)
SELECT if (100 > 200, '참이다', '거짓이다');
-- ifnull(수식1, 수식2) 수식1이 null이 아니면 수식1이 반환, 수식1이 null이면 수식2 반환
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요');
-- nullif(수식1, 수식2) 수식1과 2가 같으면 null, 다르면 수식1 반환
SELECT NULLIF(100, 100), NULLIF(200, 100);
-- case~when~else~end
SELECT case 10
when 1 then '일'
when 5 then '오'
when 10 then '십'
ELSE '모름'
END;

-- 문자열 함수
-- ASCII(아스키코드), CHAR(숫자)
SELECT ASCII('A'), CHAR(65);

-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc'); -- 24, 3, 3
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다'); -- 72, 3, 9
-- 기본적으로 UTF-8 코드를 사용하기에 영문은 3Byte를, 한글은 3x3=9Byte를 할당한다.

-- CONCAT(문자열1, 문자열2, ...), CONCAT_WS(구분자, 문자열1, 문자열2, ...)
-- 문자열을 이어주는CONCAT(). CONCAT_WS()는 구분자와 함께 문자열을 이어준다.
SELECT CONCAT_WS('/', '2022', '01', '01'); -- 2022/01/01

/*
ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...), FIND_IN_SET(찾을 문자열, 문자열 리스트),
INSTR(기준 문자열, 부분 문자열), LOCATE(부분 문자열, 기준 문자열)
*/

SELECT ELT(2, '하나', '둘', '셋'), FIELD('둘', '하나', '둘', '셋'), FIND_IN_SET('둘', '하나,둘,셋'), 
INSTR('하나둘셋', '둘'), LOCATE('둘', '하나둘셋');

-- FORMAT(숫자, 소수점 자릿수)
SELECT FORMAT(123456.123456, 4); -- 123,456.1235
-- BIN(숫자), HEX(숫자), OCT(숫자)
SELECT BIN(31), HEX(31), OCT(31); -- 11111(2진수), 1F(16진수), 37(8진수)
-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
SELECT INSERT('abcdefghi', 3, 4, '@@@@@'), INSERT('abcdefghi', 3, 2, '@@@@@'); -- ab@@@@@ghi , ab@@@@@efghi
-- LEFT(문자열, 길이), right(문자열, 길이)
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3); -- abc , ghi
-- UPPER(문자열), LOWER(문자열)
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH'); -- abcdefgh, ABCDEFGH
-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
SELECT LPAD('이것이', 5, '##'), RPAD('이것이', 5, '##'); -- ##이것이 , 이것이##
-- LTRIM(문자열), RTRIM(문자열)
SELECT LTRIM('   이것이'), RTRIM('이것이   '); -- 이것이(좌측공백 제거), 이것이(우측공백 제거)
-- TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열) LEADING(앞), BOTH(양쪽), TRAILING(뒤)
SELECT TRIM('   이것이   '), TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재밌어요. ㅋㅋㅋ'); -- 이것이(양측 공백 제거), 재밌어요.(ㅋ 양측제거)
-- REPEAT(문자열, 횟수) 문자열 횟수만큼 반복
SELECT repeat('이것이', 3); -- 이것이이것이이것이
-- REPLACE(문자열, 원래 문자열, 바꿀 문자열)
SELECT REPLACE('이것이 MariaDB다', '이것이', 'This is');
-- REVERSE(문자열) 문자 반전
SELECT REVERSE('MariaDB'); -- BDairaM
-- SPACE(길이) 공백 길이만큼 추가
SELECT CONCAT('이것이', SPACE(10), 'MariaDB다'); -- 이것이          MariaDB다
-- SUBSTRING(문자열, 시작위치, 길이) 또는 SUBSTRING(문자열 FROM 시작위치 FOR 길이) 길이 생략시 끝까지 반환
SELECT SUBSTRING('대한민국만세', 3, 2); -- 민국
SELECT SUBSTRING('대한민국만세', 3); -- 민국만세
-- SUBSTRING_INDEX(문자열, 구분자, 횟수)
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', 2), SUBSTRING_INDEX('cafe.naver.com', '.', -2); -- cafe.naver , naver.com

-- 수학함수
-- ABS(숫자)
SELECT ABS(-100);

-- 삼각함수 관련 함수
-- ACOS(숫자), ASIN(숫자, ATAN(숫자), ATAN2(숫자1, 숫자2), SIN(숫자), COS(숫자), TAN(숫자)
-- CEILING(숫자), FLOOR(숫자), ROUND(숫자)
-- 올림, 내림, 반올림
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7); -- 5 , 4 , 5

-- CONV(숫자, 원래 진수, 변환할 진수)
SELECT CONV('AA', 16, 2), CONV(100, 10, 8); -- 10101010 , 144

-- DEGREES(숫자), RADIANS(숫자), PI()
-- 라디안 값을 각도값으로, 각도값을 라디안 값으로 변환, PI()는 파이값 3.141592 반환
SELECT DEGREES(PI()), RADIANS(180); -- 180 , 3.141592653589793

-- EXP(X), LN(숫자), LOG(숫자), LOG(밑수, 숫자), LOG2(숫자), LOG10(숫자)
-- 지수, 로그와 관련된 함수를 제공

-- MOD(숫자1, 숫자2) 또는 숫자1 % 숫자2 또는 숫자1 MOD 숫자2
-- 숫자1을 숫자2로 나눈 나머지 값을 구함.
SELECT MOD(157, 10), 157 % 10, 157 MOD 10; -- 7, 7, 7

-- POW(숫자, 숫자2), SQRT(숫자)
-- 거듭제곱값 및 제곱근을 구한다.
SELECT POW(2,3), SQRT(9); -- 8 , 3

-- RAND()
-- RAND()는 0이상 1미만의 실수를 구한다.
-- m <= 임의의 정수 < n 를구하고 싶다면 FLOOR(m + (RAND() * (n-m))을 사용하면 된다.
SELECT RAND(), FLOOR(1 + (RAND() * (7-1)) ); -- 랜덤값

-- SIGN(숫자)
-- 숫자가 양수, 0 , 음수인지 구한다.
SELECT SIGN(100), SIGN(0), SIGN(-100.123); -- 1 , 0 , -1

-- TRUNCATE(숫자, 정수)
-- 숫자를 소수점을 기준으로 정수위치까지 구하고 나머지는 버림.
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2); -- 12,345.12 , 12,300

-- 날짜 및 시간 함수

-- ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
SELECT ADDDATE('2022-01-01', INTERVAL 31 DAY), ADDDATE('2022-01-01', INTERVAL 1 MONTH);
SELECT SUBDATE('2022-01-01', INTERVAL 31 DAY), SUBDATE('2022-01-01', INTERVAL 1 MONTH);

-- ADDTIME(날씨/시간, 시간), SUBTIME(날짜/시간, 시간)
SELECT ADDTIME('2022-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10');
SELECT SUBTIME('2022-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');

-- CURDATE(), CURTIME(), NOW(), SYSDATE()
-- CURDATE() 현재 연-월-일
-- CURTIME() 현재 시:분:초
-- NOW(), SYSDATE() 현재 연-월-일 시:분:초

-- YEAR(날짜), MONTH(날짜), DAY(날짜), 
-- HOUR(시간), MINUTE(시간), SECOND(시간), MICROSECOND(시간)
SELECT YEAR(CURDATE()), MONTH(CURRENT_DATE()), DAYOFMONTH(CURRENT_DATE); -- 2025, 9, 24
SELECT HOUR(CURTIME()), MINUTE(CURRENT_TIME()), SECOND(CURRENT_TIME), MICROSECOND(CURRENT_TIME); -- 9, 9, 52, 0

-- DATE(), TIME()
SELECT DATE(NOW()), TIME(NOW()); -- 2025-09-24, 09:10:52

-- DATEDIFF(날짜1, 날짜2), TIMEDIFF(날짜1 또는 시간1, 날짜2 또는 시간2)
SELECT DATEDIFF('2022-01-01', NOW()), TIMEDIFF('23:23:59', '12:11:10'); -- -1362 , 11:12:49

-- DAYOFWEEK(날짜), MONTHNAME(), DAYOFYEAR(날짜)
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE()); -- 4, September, 267

-- LAST_DAY(날짜)
-- 주어진 날짜의 마지막 날짜를 구함
SELECT LAST_DAY('2022-02-01'); -- 2022-02-28

-- MAKEDATE(연도, 정수)
-- 연도에서 정수만큼 지난 날짜를 구함.
SELECT MAKEDATE(2022, 32); -- 2022-02-01

-- MAKETIME(시, 분, 초)
SELECT MAKETIME(12, 11, 10); -- 12:11:10

-- PERIOD_ADD(연월, 개월수), PERIOD_DIFF(연월1, 연월2)
SELECT PERIOD_ADD(202201, 11), PERIOD_DIFF(202201, 201812); -- 202212 , 37

-- QUARTER(날짜)
SELECT QUARTER('2022-07-07'); -- 3(분기)

-- TIME_TO_SEC(시간)
-- 시간을 초 단위로 구함
SELECT TIME_TO_SEC('12:11:10'); -- 43,870

-- 시스템 정보 함수

-- USER(), DATABASE()
SELECT CURRENT_USER(), DATABASE(); -- root@localhost , sqldb

-- FOUND_ROWS()
-- 바로 앞의 select 문에서 조회된 행의 개수를 구함
USE sqlDB;
SELECT * FROM usertbl;
SELECT FOUND_ROWS(); -- 10

-- ROW_COUNT()
-- 바로 앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 개수를 구함
USE sqlDB;
UPDATE buytbl SET price=price*2;
SELECT ROW_COUNT();

-- VERSION()
-- 현재 MariaDB의 버전을 구함

-- SLEEP(초)
-- 쿼리의 실행을 잠깐 멈춤
SELECT SLEEP(5);
SELECT '5초후에 이게 보여요';

-- TEXT 데이터 형식을 이용해서 데이터를 입력
USE sqlDB;
CREATE TABLE maxTbl (col1 LONGTEXT, col2 LONGTEXT);

-- repeat() 함수 활용해서 백만개 씩 입력.
INSERT INTO maxTbl VALUES (repeat('A', 1000000), repeat('가', 1000000));

-- 입력된 값의 크기를 확인
SELECT LENGTH(col1), LENGTH(col2) FROM maxtbl;

-- 좀더 큰 값을 입력
INSERT INTO maxtbl VALUES(repeat('A', 10000000), repeat('가', 10000000));
-- max_allowed_packet의 최대값이 약 1천6백만 바이트(=16M)로 오류발생

-- 250page