-- Case Statement
SELECT first_name, last_name,age,
CASE
    WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Senior'
    WHEN age >= 51 THEN 'Elder'
END AS Age_Bracket
FROM employee_demographics

-- raise: < 50000 : 5% / > 50000 : 7% / Finance(id=6) : 10% bonus
SELECT first_name, last_name, salary AS old_salary,
CASE
    WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS new_salary,
CASE
    WHEN dept_id =6 THEN salary * 1.1
END AS bonus
FROM employee_salary