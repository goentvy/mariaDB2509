USE employees;

-- 생성(Create)
/*
CREATE TABLE customuser(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(100) NOT NULL unique,
	email VARCHAR(100) unique,
	hireDate DATE
);
*/

-- 읽기(Read)
SELECT * from users;

-- 변경(Update)
UPDATE users set NAME="이주환경변수", email="entvy@naver.com" WHERE NAME="이주환" AND email="steal97@naver.com";
UPDATE users SET NAME="팍큰철", email="parks@naver.com" WHERE NAME="박근철" AND email="park@naver.com";

-- 삭제(Delete)
DELETE from users WHERE NAME="이주환" and email="steal97@naver.com";

-- 추가(Insert)
INSERT INTO users (NAME, email, hireDate) VALUES ("이주환", "steal97@naver.com", CURDATE());


-- 테이블 구조 확인
DESC customuser;

-- Field: 컬럼이름
-- Type: 데이터 타입
-- Null: Null 허용 여부( Yes 또는 No )
-- Key: 인덱스 종류(PRI = Primary Key, UNI = Unique, MUL = Multiple)
-- Default: 기본값
-- Extra 추가정보(예: auto_increment)

-- 컬럼이름(Field) 변경
ALTER TABLE customuser
RENAME COLUMN hireDate TO hire_date;

-- 컬럼 데이터 타입(Type) 변경
ALTER TABLE customuser
MODIFY NAME VARCHAR(50);

-- 컬럼 제약조건(Key) 중복불가(unique) 추가
ALTER TABLE customuser
ADD UNIQUE (name);

-- 컬럼 제약조건 제거
ALTER TABLE customuser
DROP INDEX NAME;

