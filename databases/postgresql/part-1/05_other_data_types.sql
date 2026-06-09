

DROP TABLE IF EXISTS first_schema.app_events;

CREATE TABLE first_schema.app_events (
  
--   UUID is a data type that allows a unique identifier
    id UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),

    event_name TEXT NOT NULL,

    -- JSONB is a data type that allows a JSON object
    -- DEFAULT '{}'::jsonb is a constraint that sets the metadata to an empty JSON object if not provided
    metadata JSONB DEFAULT '{}'::jsonb,

    created_at TIMESTAMP DEFAULT NOW()
);


INSERT INTO first_schema.app_events (event_name, metadata)
  VALUES ('Product Viewed', '{"product_id": 1, "user_id": 1}'),
         ('Product Purchased', '{"product_id": 2, "user_id": 2}'),
         ('Product Viewed', '{"item_id": 3, "user_id": 3}');


--  Query to get all data from the table
SELECT * FROM first_schema.app_events;

--  Query to get all events where the product_id is present in the metadata
--  metadata ? 'product_id' is a condition that checks if the product_id is present in the metadata
SELECT 
  event_name,
  metadata->>'product_id' as product_id
FROM first_schema.app_events
WHERE metadata ? 'product_id';

--  Command to run 
-- psql -h 127.0.0.1 -p 5433 -U postgres -d postgresql_part1 -f 05_other_data_types.sql