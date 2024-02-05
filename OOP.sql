	
/*Implementation of OOP Principles */

/* Inheritance */
/* a child table car inherits the properties of a parent table vehicle */


CREATE TABLE vehicle (
    vehicle_id SERIAL PRIMARY KEY,
    brand VARCHAR(100),
    model VARCHAR(100)
);


CREATE TABLE car (
    vehicle_id INT PRIMARY KEY,
    num_wheels INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle(vehicle_id)
);


INSERT INTO vehicle (vehicle_id, brand, model) VALUES (1, 'Toyota', 'Camry');

INSERT INTO car (vehicle_id, num_wheels) VALUES (1, 4);

SELECT * FROM vehicle;

SELECT * FROM car;

/* Abstraction */
/* The create or replace function abstracts/hide the implementation details of how the average salary is calculated.*/

CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    emp_salary DECIMAL(10, 2)
);

INSERT INTO employee (emp_name, emp_salary) VALUES
('Andrew kibet', 500000.00),
('Jane wambui', 600000.00),
('Johnson mutua', 700000.00);

CREATE OR REPLACE FUNCTION calculate_average_salary()
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    avg_salary DECIMAL(10, 2);
BEGIN
    SELECT AVG(emp_salary) INTO avg_salary FROM employee;
    RETURN avg_salary;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_average_salary();

/* Polymorphism */

CREATE TABLE car1(
    vehicle_id SERIAL PRIMARY KEY,
    brand VARCHAR(100),
    model VARCHAR(100),
    num_doors INT
);

CREATE TABLE bicycle (
    vehicle_id SERIAL PRIMARY KEY,
    brand VARCHAR(100),
    model VARCHAR(100),
    num_wheels INT
);

INSERT INTO car1 (brand, model, num_doors) VALUES
('Toyota', 'Camry', 4),
('Honda', 'Accord', 4),
('Ford', 'Mustang', 4);

INSERT INTO bicycle (brand, model, num_wheels) VALUES
('Schwinn', 'Mountain Bike', 2),
('Giant', 'Road Bike', 2),
('Trek', 'Hybrid Bike', 2);

SELECT vehicle_id, brand, model, num_doors AS num_wheels FROM car1
UNION
SELECT vehicle_id, brand, model, num_wheels FROM bicycle;

/* Encapsulation */

CREATE SCHEMA hr1;

CREATE TABLE hr1.employee1 (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    emp_salary DECIMAL(10, 2)
);


INSERT INTO hr1.employee1 (emp_name, emp_salary) VALUES ('John Doe', 25000.00);


INSERT INTO hr1.employee1 (emp_name, emp_salary) VALUES ('Jane Smith', 35000.00);


CREATE OR REPLACE FUNCTION enforce_salary_constraint()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.emp_salary < 30000.00 THEN
        RAISE EXCEPTION 'Salary must be greater than $30,000';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_salary
BEFORE INSERT OR UPDATE ON hr1.employee1
FOR EACH ROW EXECUTE FUNCTION enforce_salary_constraint();



