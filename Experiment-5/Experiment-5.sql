--------------------------------MEDIUM LEVEL PROBLEM --------------------------------------------

-- Set default schem

-- Create table
CREATE TABLE TRANSACTION_DATA (
    id int,
    val decimal
);

-- Insert data
INSERT INTO TRANSACTION_DATA(ID, VAL)
SELECT 1, RANDOM()
FROM GENERATE_SERIES(1,1000000);

INSERT INTO TRANSACTION_DATA(ID, VAL)
SELECT 2, RANDOM()
FROM GENERATE_SERIES(1,1000000);

-- Select all data
SELECT * FROM TRANSACTION_DATA;

-- Create simple view
CREATE OR REPLACE VIEW SALES_SUMMARY AS
SELECT 
    ID,
    COUNT(*) AS total_quantity_sold,
    SUM(val) AS total_sales,
    COUNT(DISTINCT id) AS total_orders
FROM TRANSACTION_DATA
GROUP BY ID;

-- Analyze view performance
EXPLAIN ANALYZE
SELECT * FROM SALES_SUMMARY;

-- Create materialized view
CREATE MATERIALIZED VIEW SALES_SUMM_MV AS
SELECT 
    ID,
    COUNT(*) AS total_quantity_sold,
    SUM(val) AS total_sales,
    COUNT(DISTINCT id) AS total_orders
FROM TRANSACTION_DATA
GROUP BY ID;

-- Analyze materialized view
EXPLAIN ANALYZE
SELECT * FROM SALES_SUMM_MV;

------------------------------------HARD PROBLEM-------------------------------------

-- Create customer data table
CREATE TABLE customer_data (
    transaction_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    payment_info VARCHAR(50),  -- sensitive
    order_value DECIMAL,
    order_date DATE DEFAULT CURRENT_DATE
);

-- Insert sample data
INSERT INTO customer_data (customer_name, email, phone, payment_info, order_value)
VALUES
('Abhi Kumar', 'abhi@example.com', '9040122324', '1234-5678-9012-3456', 500),
('Sumit Singh', 'sumit@example.com', '9040122324', '1234-5678-9012-3456', 1000),
('Anil Sachdeva', 'anil@example.com', '9876543210', '9876-5432-1098-7654', 700),
('Ashutosh Singh', 'ashutosh@example.com', '9876543210', '9876-5432-1098-7654', 300);

-- Create restricted view
CREATE OR REPLACE VIEW RESTRICTED_SALES_DATA AS
SELECT
    CUSTOMER_NAME,
    COUNT(*) AS total_orders,
    SUM(order_value) AS total_sales
FROM customer_data
GROUP BY customer_name;

-- Select from restricted view
SELECT * FROM RESTRICTED_SALES_DATA;

-- Create user and grant/revoke access
CREATE USER CLIENT1 WITH PASSWORD 'REPORT1234';
GRANT SELECT ON RESTRICTED_SALES_DATA TO CLIENT1;
REVOKE SELECT ON RESTRICTED_SALES_DATA FROM CLIENT1;
REVOKE SELECT ON RESTRICTED_SALES_DATA FROM postgres;
-- Step 1: Create a restricted role
CREATE ROLE reporting_user;

-- Step 2: Change view owner (optional, makes postgres not automatically have full access)
ALTER VIEW restricted_sales_data OWNER TO reporting_user;

-- Step 3: Grant SELECT only to reporting users
GRANT SELECT ON restricted_sales_data TO reporting_user;

-- Step 4: Revoke public access
REVOKE ALL ON restricted_sales_data FROM PUBLIC;


