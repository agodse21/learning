

--  drop a table if it exists -> just to learn the syntax. In production, you should not drop a table.
DROP TABLE IF EXISTS first_schema.students;


CREATE TABLE first_schema.students (
--  id is a serial primary key -> it will auto increment the id 
--  PRIMARY KEY is a constraint that ensures the id is unique and not null
 id SERIAL PRIMARY KEY,

 --  name is a text not null -> it will not allow the name to be null -> its a required field
 name  TEXT NOT NULL,

  --  email is a text not null -> it will not allow the email to be null -> its a required field 
  --  UNIQUE is a constraint that ensures the email is unique -> it will not allow duplicate emails
  email  TEXT NOT NULL UNIQUE,

 --  age is an integer not null -> it will not allow the age to be null -> its a required field
 --  CHECK is a constraint that ensures the age is greater than or equal to 18 -> it will not allow age less than 18
age INTEGER CHECK (age >= 18),


--  created_at is a timestamp not null -> it will not allow the created_at to be null -> its a required field
--  DEFAULT NOW() is a constraint that sets the created_at to the current timestamp
created_at TIMESTAMP DEFAULT NOW()
);



--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 03_first_table.sql



-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1

-- postgresql_part1=# \dt
-- Did not find any relations.
-- postgresql_part1=# \dt first_schema.*
--              List of relations
--     Schema    |   Name   | Type  |  Owner   
-- --------------+----------+-------+----------
--  first_schema | students | table | postgres
-- (1 row)




-- INSERT Some Data into the table
INSERT INTO first_schema.students (name, email, age)
  VALUES ('John Doe', 'john.doe@example.com', 20), 
         ('Jane Smith', 'jane.smith@example.com', 21),
         ('Jim Beam', 'jim.beam@example.com', 22);



--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 03_first_table.sql


--  Query to get all data from the table
SELECT * FROM first_schema.students;