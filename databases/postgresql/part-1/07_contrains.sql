-- constraints are used to enforce rules on the data in the table
-- NOT NULL -> ensures that the column cannot be null
-- UNIQUE -> ensures that the column cannot have duplicate values
-- PRIMARY KEY -> ensures that the column is unique and not null
-- FOREIGN KEY -> ensures that the column is a foreign key
-- CHECK -> ensures that the column value satisfies a condition
-- DEFAULT -> ensures that the column is set to a default value if not provided
-- INDEX -> ensures that the column is indexed for faster retrieval
-- TRIGGER -> ensures that a function is called when a row is inserted or updated
-- VIEW -> ensures that the column is a view
-- SEQUENCE -> ensures that the column is a sequence
-- CONSTRAINT -> ensures that the column is a constraint

-- Examples for all constraints:

DROP TABLE IF EXISTS first_schema.orders;
DROP TABLE IF EXISTS first_schema.customers CASCADE;
DROP VIEW IF EXISTS first_schema.active_customers;
DROP FUNCTION IF EXISTS first_schema.update_timestamp();
DROP SEQUENCE IF EXISTS first_schema.invoice_seq;

-- NOT NULL, UNIQUE, PRIMARY KEY, CHECK, DEFAULT, and named CONSTRAINT
CREATE TABLE first_schema.customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    age INTEGER,
    status TEXT DEFAULT 'active',
    created_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT customers_email_unique UNIQUE (email),
    CONSTRAINT customers_age_check CHECK (age IS NULL OR age >= 18)
);

-- FOREIGN KEY -> links orders to an existing customer
CREATE TABLE first_schema.orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    order_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT orders_customer_fk
        FOREIGN KEY (customer_id)
        REFERENCES first_schema.customers (id)
);

-- INDEX -> speeds up lookups on frequently queried columns
CREATE INDEX orders_customer_id_idx
    ON first_schema.orders (customer_id);

-- SEQUENCE -> generates unique numbers (often used for invoice numbers)
CREATE SEQUENCE first_schema.invoice_seq
    START WITH 1000
    INCREMENT BY 1;

-- TRIGGER -> runs a function before insert or update
CREATE OR REPLACE FUNCTION first_schema.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

ALTER TABLE first_schema.customers
    ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();

CREATE TRIGGER set_updated_at
    BEFORE UPDATE ON first_schema.customers
    FOR EACH ROW
    EXECUTE FUNCTION first_schema.update_timestamp();

-- VIEW -> saved query that behaves like a virtual table
CREATE VIEW first_schema.active_customers AS
SELECT id, name, email, age, created_at
FROM first_schema.customers
WHERE status = 'active';

-- Valid inserts
INSERT INTO first_schema.customers (name, email, age)
VALUES
    ('John Doe', 'john.doe@example.com', 25),
    ('Jane Smith', 'jane.smith@example.com', 30);

INSERT INTO first_schema.orders (customer_id, amount)
VALUES
    (1, 49.99),
    (2, 129.50);

-- These would fail because of constraints:
-- INSERT INTO first_schema.customers (name, email, age) VALUES (NULL, 'test@example.com', 25);        -- NOT NULL on name
-- INSERT INTO first_schema.customers (name, email, age) VALUES ('Bob', 'john.doe@example.com', 25);  -- UNIQUE on email
-- INSERT INTO first_schema.customers (name, email, age) VALUES ('Bob', 'bob@example.com', 16);       -- CHECK on age
-- INSERT INTO first_schema.orders (customer_id, amount) VALUES (999, 10.00);                         -- FOREIGN KEY
-- INSERT INTO first_schema.orders (customer_id, amount) VALUES (1, 0);                               -- CHECK on amount

SELECT * FROM first_schema.customers;
SELECT * FROM first_schema.orders;
SELECT * FROM first_schema.active_customers;
SELECT nextval('first_schema.invoice_seq') AS next_invoice_number;

-- Command to run
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 07_contrains.sql

