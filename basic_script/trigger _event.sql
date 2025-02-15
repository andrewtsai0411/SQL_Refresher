-- trigger happens when event takes place

-- when employee_salary updated, also update employee_demographics
CREATE TRIGGER employee_insert
    AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics(employee_id, first_name, last_name)
    VALUES (NEW. employee_id, NEW.first_name, NEW.last_name);
END

SHOW TRIGGERS

INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Bruce', 'Wayne', 'Batman', 5000000, NULL)

SELECT * FROM employee_demographics

-- event takes palce when scheduled

-- automatically retire employees aged over 60
SELECT *
FROM employee_demographics

CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
    DELETE
    FROM employee_demographics
    WHERE age >= 60;
END

SHOW EVENTS

ALTER EVENT delete_retirees
 DISABLE;