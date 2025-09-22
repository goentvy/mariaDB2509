USE employees;

SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC;

SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 5;

SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 0, 5; -- 페이지네이션 구현방법