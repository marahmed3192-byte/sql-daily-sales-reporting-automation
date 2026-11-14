# sql-daily-sales-reporting-automation
Automated daily sales validation and reporting using SQL Server , T-SQL stored procedures and SQL server agent.
# Daily Sales Reporting Automation Using SQL Server

## Project Overview

Developed an automated daily sales reporting workflow using Microsoft SQL Server, T-SQL stored procedures, and SQL Server Agent.

The project demonstrates how repetitive data validation and reporting activities can be automated to improve reporting consistency and reduce manual processing.

## Business Problem

Retail businesses receive daily sales transactions that may contain missing information, duplicate records, invalid quantities, incorrect prices, and inconsistent discounts.

Manually validating this data and preparing daily sales reports can be time-consuming and error-prone.

This project automates data quality checks and refreshes a clean, aggregated sales summary.

## Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Stored Procedures
- SQL Server Agent
- Common Table Expressions (CTEs)
- Window Functions
- TRY...CATCH and Transactions

## Automation Workflow

1. Sales transactions are stored in `dbo.Sales_Raw`.
2. `dbo.usp_ValidateDailySales` executes five data quality checks.
3. Validation results are logged in `dbo.DataQuality_Audit`.
4. `dbo.usp_RefreshDailySalesSummary` filters invalid records, handles duplicate transaction-product combinations, and calculates reporting metrics.
5. Aggregated results are stored in `dbo.Daily_Sales_Summary`.
6. SQL Server Agent schedules the workflow to run daily at 8:00 AM.

## Data Quality Checks

| Validation Check | Description |
|---|---|
| Missing Values | Identifies missing transaction IDs, product IDs, quantities, and unit prices |
| Invalid Quantity | Detects quantities below 1 |
| Invalid Price | Detects unit prices less than or equal to zero |
| Invalid Discount | Identifies negative discounts or discounts exceeding the transaction line amount |
| Duplicate Records | Identifies repeated transaction-product combinations |

## Reporting Metrics

The automated summary calculates the following metrics by transaction date and store:

- Total Transactions
- Total Quantity Sold
- Total Revenue
- Last Updated Timestamp

**Revenue Calculation:**

`Total Revenue = SUM((Quantity × Unit Price) - Discount)`

## Automation Features

- Scheduled daily execution using SQL Server Agent
- Automated data quality audit logging
- Duplicate handling using `ROW_NUMBER()`
- Transaction-based error handling
- Repeatable full-refresh reporting process
- Sequential execution of validation and summary procedures

## How to Run the Project

1. Create a SQL Server database named `RetailSalesAutomation`.
2. Execute the three table creation scripts in numerical order.
3. Execute `07_sample_sales_data.sql` to load the sample records.
4. Execute the two stored procedure scripts.
5. Execute `06_sql_agent_job.sql` using an account with the necessary SQL Server Agent permissions.
6. Run the SQL Server Agent job manually to test both steps.
7. Review `dbo.DataQuality_Audit` and `dbo.Daily_Sales_Summary`.

**Note:** The SQL Server Agent service must be running for scheduled execution.

## Project Outcome

Successfully developed and manually tested a scheduled SQL Server automation workflow that validates sales data, records data quality results, and refreshes store-level daily sales reporting tables.

The project uses synthetic sample data containing intentional quality issues to demonstrate validation and reporting automation.
