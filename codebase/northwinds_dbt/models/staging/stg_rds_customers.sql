-- import CTE. similar to imports in python.
WITH source AS (
    SELECT * FROM{{ source('rds', 'customers')}}
),
companies AS (
    SELECT * FROM dev.stg_rds_companies
),
-- logical CTE
renamed AS (
    SELECT CONCAT('rds-', customer_id) AS customer_id, 
    customers.country,
    split_part(contact_name, ' ', 1) AS first_name,
    split_part(contact_name, ' ', 2) AS last_name,
    REPLACE(TRANSLATE(phone, '()-.', ''), ' ', '' ) AS updated_phone,
    company_id
    FROM customers
    JOIN companies 
    ON companies.company_name = customers.company_name
    ), 
final AS (
    SELECT customer_id,
    first_name,
    last_name,
    CASE WHEN LENGTH(updated_phone) = 10 THEN
        '(' || SUBSTRING(updated_phone, 1, 3) || ') ' || 
        SUBSTRING(updated_phone, 4, 3) || '-' ||
        SUBSTRING(updated_phone, 7, 4) 
        END as phone,
    company_id
    FROM renamed
)

-- final SELECT statement
    SELECT * FROM final