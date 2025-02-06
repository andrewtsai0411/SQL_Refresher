-- String Function

-- LENGTH('')
SELECT first_name, LENGTH(first_name) as length
FROM employee_demographics
ORDER BY length DESC

-- UPPER() / LOWER()
SELECT UPPER('upper') -- UPPER
SELECT LOWER('LOWER') -- lower

-- TRIM(""), 移除左/右側空白
SELECT TRIM('  TRIM  '),LTRIM('  TRIM  '),RTRIM('  TRIM  ')

-- LEFT() / RIGHT(), SUBSTRING(STR, 起點, 向右多少字元)
SELECT first_name, LEFT(first_name,3),  RIGHT(first_name,3), SUBSTRING(first_name,2,4)
FROM employee_demographics

-- REPLACE()
SELECT 'abc',REPLACE('abc','a','z') -- zbc

-- LOCATE()
SELECT LOCATE('O','LOCATE') -- 2

-- CONCAT()
SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics