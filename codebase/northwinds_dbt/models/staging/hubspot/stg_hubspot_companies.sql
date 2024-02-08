-- import CTEs
WITH source AS ( SELECT * FROM {{ source('hubspot', 'companies') }}
),

companies AS (
    SELECT * FROM dev.northwinds_hubspot
),


-- logical CTE
companies2 AS (
    SELECT CONCAT('hubspot-', REPLACE(business_name, ' ', '-')) AS contact_id, 
    business_name AS company_name
    FROM companies
)

SELECT * FROM companies2