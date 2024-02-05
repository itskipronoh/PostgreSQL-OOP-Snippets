
# PostgreSQL OOP Principles Implementation, Functions, Triggers and Stored Procedures 

This repository contains SQL code examples demonstrating the implementation of Object-Oriented Programming (OOP) principles in PostgreSQL. The examples cover concepts such as Inheritance, Abstraction, Polymorphism, and Encapsulation using relational database structures.



# Introduction

This repository provides SQL code snippets illustrating the application of OOP principles within a relational database context using PostgreSQL. The principles covered include Inheritance, Abstraction, Polymorphism, and Encapsulation.

# Contents

The repository is organized into sections, each demonstrating a specific OOP principle:

- **Inheritance:** Tables `vehicle` and `car` illustrate a child table (`car`) inheriting properties from a parent table (`vehicle`).
  
- **Abstraction:** A function `calculate_average_salary()` abstracts the calculation of average employee salary.

- **Polymorphism:** Tables `car1` and `bicycle` showcase polymorphism using the `UNION` operation to combine data from different tables with similar structures.

- **Encapsulation:** Schema `hr1` encapsulates an employee table (`employee1`) with a trigger enforcing a salary constraint.

# Usage

To use these examples, follow these steps:

1. Execute the SQL code in a PostgreSQL environment with the appropriate permissions.

2. Customize the code or adapt it to your specific use case.



# Contributing

Contributions are welcome! Feel free to open issues or pull requests to enhance or extend the examples.

## License

This repository is licensed under the [MIT License].
