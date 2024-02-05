/*functions stored procedures and triggers*/

CREATE TABLE EMPLOYEE_INFO (
   EMPLOYEE_ID INT PRIMARY KEY     NOT NULL,
   EMPLOYEE_NAME TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL,
   JOIN_DATE      DATE	
);

INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, EMPLOYEE_NAME, AGE, ADDRESS, SALARY, JOIN_DATE) 
VALUES (1, 'Alice', 30, 'Nairobi', 500000.00, '2022-01-20'),
       (2, 'Bob', 28, 'kiambu', 750000.00, '2021-02-15'),
	   (3, 'Charlie', 35, 'Ruiru', 900000.00, '2020-02-10'),
	   (4, 'Diana', 26, 'Westlands', 600000.00, '2019-09-22'),
	   (5, 'Evaline', 32, 'Embakasi', 800000.00, '2015-08-18');

SELECT * FROM EMPLOYEE_INFO;


CREATE OR REPLACE FUNCTION insert_employee_info(
    emp_id INT,
    emp_name TEXT,
    emp_age INT,
    emp_address CHAR(50),
    emp_salary REAL,
    emp_join_date DATE
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO EMPLOYEE_INFO (EMPLOYEE_ID, EMPLOYEE_NAME, AGE, ADDRESS, SALARY, JOIN_DATE)
    VALUES (emp_id, emp_name, emp_age, emp_address, emp_salary, emp_join_date);
END;
$$;

SELECT insert_employee_info(6, 'Frank', 29, 'Kabuku', 750000.00, '2016-11-05');


SELECT * FROM EMPLOYEE_INFO;


CREATE OR REPLACE FUNCTION total_records_employee_info()
RETURNS INTEGER
LANGUAGE plpgsql  
AS $$
DECLARE
    no_of_records INTEGER;
BEGIN
 
    SELECT count(*) INTO no_of_records FROM EMPLOYEE_INFO;
    RETURN no_of_records;
END;
$$;


SELECT total_records_employee_info();


SELECT * FROM EMPLOYEE_INFO;

CREATE OR REPLACE FUNCTION get_salaries(Salary_from INT, Salary_to INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    salary_count INTEGER;
BEGIN
   
    SELECT COUNT(*)
    INTO salary_count
    FROM EMPLOYEE_INFO
    WHERE SALARY BETWEEN Salary_from AND Salary_to;

    RETURN salary_count;
END;
$$;


SELECT get_salaries(600000, 750000);


SELECT * FROM EMPLOYEE_INFO;


CREATE OR REPLACE FUNCTION salary_update(IN emp_id INT, IN rate DECIMAL)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
  
    UPDATE EMPLOYEE_INFO
    SET SALARY = SALARY + (rate * SALARY)
    WHERE EMPLOYEE_ID = emp_id;
    
 
END;
$$;


SELECT salary_update(1, 0.25);

SELECT * FROM EMPLOYEE_INFO;

CREATE TABLE EMPLOYEE_audits (
   STAFF_ID INT PRIMARY KEY,
   STAFF_NAME TEXT NOT NULL,
   changed_on TIMESTAMP(6) NOT NULL
);

SELECT * FROM EMPLOYEE_audits;


CREATE OR REPLACE FUNCTION logname_changes()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NEW.STAFF_NAME <> OLD.STAFF_NAME THEN
        INSERT INTO EMPLOYEE_audits(STAFF_ID, STAFF_NAME, changed_on)
        VALUES(OLD.STAFF_ID, OLD.STAFF_NAME, now());
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER LOGchanges
BEFORE UPDATE
ON Staff_audits
FOR EACH ROW
EXECUTE PROCEDURE logname_changes();

SELECT * FROM EMPLOYEE_audits
SELECT * FROM EMPLOYEE_INFO;


CREATE TABLE EMPLOYEE_ACCOUNTS (
   EMPLOYEE_ID INT PRIMARY KEY,
   ACCOUNT_ID INT
  
);


INSERT INTO EMPLOYEE_ACCOUNTS (EMPLOYEE_ID, ACCOUNT_ID)
VALUES
   (1, 1), 
   (2, 2); 
   
CREATE OR REPLACE PROCEDURE transfer_funds_between_employees(
   sender_employee_id INT,
   receiver_employee_id INT,
   amount DECIMAL
)
LANGUAGE plpgsql    
AS $$
DECLARE
    sender_account_id INT;
    receiver_account_id INT;
BEGIN
    
    SELECT ACCOUNT_ID INTO sender_account_id
    FROM EMPLOYEE_ACCOUNTS
    WHERE EMPLOYEE_ID = sender_employee_id;

    SELECT ACCOUNT_ID INTO receiver_account_id
    FROM EMPLOYEE_ACCOUNTS
    WHERE EMPLOYEE_ID = receiver_employee_id;

   
   
    UPDATE accountsA
    SET balance = balance - amount 
    WHERE id = sender_account_id;

   
    UPDATE accountsA
    SET balance = balance + amount 
    WHERE id = receiver_account_id;

    COMMIT;
END;
$$;
    
	
