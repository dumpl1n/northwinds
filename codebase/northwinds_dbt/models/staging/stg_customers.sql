-- import CTE. similar to imports in python.
WITH source AS (
    SELECT *
    FROM public.customers
    ),

-- logical CTE
renamed AS (
    SELECT customer_id, country,
    split_part(contact_name, ' ', 1) AS first_name,
    split_part(contact_name, ' ', 2) AS last_name
    FROM source
    )

-- final SELECT statement
    SELECT * FROM renamed