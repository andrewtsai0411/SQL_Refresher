CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000

-- 列出現有SP
SHOW PROCEDURE STATUS
WHERE Db = 'Parks_and_Recreation'

-- 呼叫SP
CALL large_salaries()

-- 指定執行範圍
CREATE PROCEDURE large_salaries2()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;

    SELECT *
    FROM employee_salary
    WHERE salary >= 100000;
END;

-- 換DELIMITER的寫法只有client有效，API, driver都不行
DELIMITER $$ -- 換分隔符號表示SP起點
CREATE PROCEDURE large_salaries2()
BEGIN

END $$
DELIMITER ; -- 換回;

-- SP傳入參數，需指定資料類型
CREATE PROCEDURE large_salaries3(p_employee_id INT)
BEGIN
    SELECT salary
    FROM employee_salary
    WHERE employee_id = p_employee_id;
END;

CALL large_salaries3(1)