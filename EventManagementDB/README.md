# Event-Management-System-SQL-Python

A comprehensive Console-based Event Management System built with **Python** and **MySQL**. This project is developed to automate daily event operations including guest registrations, event maintenance, participation tracking, and scheduling analytics.

## Key Features

*   **Guest & Registration Management**: Track guest details and handle event registrations with demographic data validation.
*   **Automated Participation Tracking**: Real-time attendance monitoring using SQL joins to link guests with specific event schedules.
*   **Dynamic Event Maintenance**: Update event names, dates, and venues directly through the interface with immediate database synchronization.
*   **Conflict Detection Module**: Logic-driven system that identifies scheduling overlaps at the same venue and time to ensure operational integrity.
*   **Formatted Data Reporting**: Utilizes advanced string formatting to generate clean, tabular reports within the console for better readability.

## Technologies Used

*   **Language**: Python 3.12
*   **Database**: MySQL 8.x
*   **Libraries**: `mysql-connector-python`, `datetime`

## Repository Structure

*   `application.py`: The main Python script containing the console-based application interface and core business logic.
*   `insert_and_constraint.sql`: SQL script to initialize the database schema, create tables, and define integrity constraints.
*   `sample_data.sql`: SQL script containing pre-defined datasets to populate the database for testing and demonstration.
*   `advanced_database_objects.sql`: SQL script containing advanced database objects such as Views, Stored Procedures, and complex queries for reporting.

## How to Run

1.  Execute the SQL scripts in your MySQL environment in the following order:
    *   First: `insert_and_constraint.sql` (to create the structure).
    *   Second: `sample_data.sql` (to load the data).
    *   Third: `advanced_database_objects.sql` (to add advanced features).
2.  Update the database connection credentials in `application.py` (host, user, password).
3.  Install dependencies:
    ```bash
    pip install mysql-connector-python
    ```
4.  Run the application:
    ```bash
    python3 application.py
    ```

## Author

**Vu Kim Minh**

*   Data Science 66A
*   Falculty of Data Science and Artificial Intelligence
*   Database Management Systems Course Project
*   National Economics University (NEU)