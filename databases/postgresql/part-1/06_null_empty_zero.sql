--  NULL -> NULL is a value that is not present
-- empty string -> '' is a value that is an empty string
-- zero -> 0 is a value that is zero


DROP TABLE IF EXISTS first_schema.value_examples;

CREATE TABLE first_schema.value_examples (
    id SERIAL PRIMARY KEY,
   nickname TEXT,
   bio TEXT,
   score INTEGER
);

INSERT INTO first_schema.value_examples (nickname, bio, score)
  VALUES
--   nickname is null -> it will not allow the nickname to be null -> its a required field
        (null, 'I am a software engineer', 100),

--  nickname is an empty string -> it will not allow the nickname to be empty -> its a required field
        ('', 'I am a software engineer', 200),

        ('raj',null,null),

--  score is zero -> it will not allow the score to be zero -> its a required field
        ('Jim Beam', '', 0);


--  Query to get all data from the table
SELECT * FROM first_schema.value_examples;

SELECT * FROM first_schema.value_examples WHERE nickname IS NULL;
SELECT * FROM first_schema.value_examples WHERE nickname IS NOT NULL;

SELECT * FROM first_schema.value_examples WHERE nickname = '';

SELECT * FROM first_schema.value_examples WHERE score = 0;

--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 06_null_empty_zero.sql