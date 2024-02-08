-- import CTEs
WITH source AS ( SELECT * FROM {{ source('hubspot', 'contacts') }}
),

contacts AS (
    SELECT * FROM dev.northwinds_hubspot
),

--logical CTE
contacts2 AS (
    SELECT CONCAT('hubspot-', hubspot_id) AS contact_id, first_name, last_name, phone,
    TRANSLATE(phone, '()-.', '') AS updated_phone, business_name
    FROM contacts
),

-- convert updated_phone 
-- from this format: 1234567890
-- to this format: (123) 456-7890
contacts3 AS (
    SELECT contact_id, first_name, last_name, phone, 
    FORMAT('(%s) %s-%s', 
    LEFT(updated_phone, 3), 
    SUBSTRING(updated_phone, 4, 3), 
    RIGHT(updated_phone, 4)) AS formatted_phone, business_name
    FROM contacts2
),

contacts4 AS (
    SELECT contact_id, first_name, last_name, formatted_phone AS phone, business_name
    FROM contacts3
),

-- add company_id
-- join on business_name
contacts5 AS (
    SELECT contacts4.contact_id, first_name, last_name, phone, 
    dev.stg_hubspot_companies.contact_id AS company_id
    FROM contacts4
    LEFT JOIN dev.stg_hubspot_companies
    ON contacts4.business_name = dev.stg_hubspot_companies.company_name
)

SELECT * FROM contacts5