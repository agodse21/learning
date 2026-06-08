--  Flow  -> database -> schema -> table -> column -> row -> data


--  create a schema

--  if the schema already exists, it will not create it again
CREATE SCHEMA IF NOT EXISTS first_schema;

--  to create a extension for the schema to use the pgcrypto extension
--  pgcrypto is a extension for the schema to use the pgcrypto extension
CREATE EXTENSION IF NOT EXISTS pgcrypto;



--  Queries

SELECT schema_name FROM information_schema.schemata ORDER BY schema_name;


--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 02_first_schema.sql