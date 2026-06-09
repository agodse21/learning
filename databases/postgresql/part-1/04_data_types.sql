



DROP TABLE IF EXISTS first_schema.products;

CREATE TABLE first_schema.products (
    id SERIAL PRIMARY KEY,


    --  name is a varchar not null -> it will not allow the name to be null -> its a required field
    --  VARCHAR(100) is a data type that allows up to 100 characters
    name VARCHAR(100) NOT NULL,

    description TEXT,

        --  price is a decimal not null -> it will not allow the price to be null -> its a required field
        --  DECIMAL(10, 2) is a data type that allows up to 10 digits and 2 decimal places
    price NUMERIC(10, 2) NOT NULL,
 
 --  total_views is a bigint not null -> it will not allow the total_views to be null -> its a required field
 --  bigint is a data type that allows up to 20 digits
total_views BIGINT DEFAULT 0,

--  stock is an integer not null -> it will not allow the stock to be null -> its a required field
--  DEFAULT 0 is a constraint that sets the stock to 0 if not provided
    stock INTEGER DEFAULT 0,


   is_active BOOLEAN DEFAULT TRUE
);


INSERT INTO first_schema.products (name, description, price, stock, is_active, total_views)
  VALUES ('Product 1', 'Description 1', 100.00, 100, TRUE, 100),
         ('Product 2', 'Description 2', 200.00, 200, TRUE, 200),
         ('Product 3', 'Description 3', 300.00, 300, FALSE, 300);


--  Query to get all data from the table
SELECT * FROM first_schema.products;



-- GET only active products
SELECT id,name,price,is_active 
FROM first_schema.products
WHERE is_active = TRUE;


--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 04_data_types.sql

