USE hrdtest;

-- 1. 모든 회원 정보 조회
SELECT * FROM member;

-- 2. 특정 회원 이름으로 조회
SELECT * FROM member WHERE NAME = '이정재';

-- 3. 도서 가격이 10,000원 이상인 책 조회
SELECT * FROM book WHERE price >= 10000;

-- 조건 + 정렬
-- 4. 출판 연도가 2010년 이후인 책을 가격순으로 정렬
SELECT * FROM book WHERE pubyear >= 2010 order by price DESC;

-- 5. 전화번호가 '010-1'으로 시작하는 회원 조회
SELECT * FROM member WHERE phone LIKE '010-1%';

-- 집계 함수
-- 6. 전체 도서 평균 가격
SELECT avg(price) AS avg_price FROM book; 

-- 7. 회원 수
SELECT COUNT(*) as total_members FROM member;

-- JOIN 활용
-- 8. 대출 기록과 회원 이름, 도서 제목 함께 조회
SELECT r.rentalid AS '대출기록', m.NAME AS '회원이름', b.title AS '도서 제목'
FROM rental r
JOIN member m ON r.memberid = m.memberid
JOIN book b ON r.BookID = b.BookID;

-- 9. 특정 회원의 대출 내역 조회
SELECT b.title, r.rentalid, r.rentdate
FROM member m
JOIN rental r ON m.MemberID = r.MemberID
JOIN book b ON r.BookID = b.BookID
WHERE m.name = '수지' ORDER BY r.rentdate DESC;

-- 서브쿼리
-- 10. 가장 비싼 책을 대출한 회원 정보
SELECT m.`Name`, b.Title, b.Price
FROM member m
JOIN rental r ON m.MemberID = r.MemberID
JOIN book b ON r.BookID = b.BookID
WHERE b.price = (select max(price) FROM book);

-- 기타 고급 예제
-- 11. 대출 횟수가 많은 회원 순으로 정렬
SELECT m.name, COUNT(*) AS rental_count
FROM rental r
JOIN member m ON r.MemberID = m.MemberID
GROUP BY m.name
ORDER BY rental_count desc;

-- 12. 대출하지 않은 회원 조회
SELECT * FROM member
WHERE memberid NOT IN (SELECT DISTINCT memberid FROM rental);
-- LEFT JOIN + IS NULL
SELECT m.*
FROM member m
LEFT JOIN rental r ON m.MemberID = r.MemberID
WHERE r.MemberID IS NULL;

-- 13. 도서별 대출 횟수 조회
SELECT b.title, COUNT(*) AS rental_count
FROM rental r
JOIN book b ON r.BookID = b.BookID
GROUP BY b.title
ORDER BY rental_count DESC;