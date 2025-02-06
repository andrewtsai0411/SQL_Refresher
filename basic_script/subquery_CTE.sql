-- subquery can be used in SELECT, FROM WHERE clauses.
SELECT first_name, salary,
    (SELECT AVG(salary)
    FROM employee_salary)
FROM employee_salary

SELECT AVG(avg_sal)
FROM
    (SELECT gender,
            AVG(salary) AS avg_sal,
            MAX(salary) AS max_sal,
            MIN(salary) AS min_sal,
            COUNT(salary) AS count_sal
    FROM employee_demographics d
    JOIN employee_salary s
        ON d.employee_id = s.employee_id
    GROUP BY gender) AS subquery_example

-- Common Table Expression(CTE) can reference within a INSERT,  UPDATE, SELECT or DELETE statement.
WITH CTE_example AS(
    SELECT gender,
           AVG(salary) AS avg_sal,
           MAX(salary) AS max_sal,
           MIN(salary) AS min_sal,
           COUNT(salary) AS count_sal
    FROM employee_demographics d
    JOIN employee_salary s
        ON d.employee_id = s.employee_id
    GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_example

-- CTE並非實際存在資料庫的物件，所以只能在建立後立刻使用

-- 也可以多個CTE JOIN
WITH CTE1 AS(
    -- query1
),
CTE2 AS(
    -- Query2
)
SELECT *
FROM CTE1
JOIN CTE2
    ON CTE1.colume = CTE2.colume