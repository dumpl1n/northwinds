WITH source AS (
	SELECT * FROM {{ source('rds', 'customers') }}
	),

renamed AS (
	SELECT concat('rds-',REPLACE(LOWER(company_name), ' ', '-') ) AS company_id,
	MAX(company_name) as company_name,
	MAX(address) AS address, 
	MAX(city) AS city, 
	MAX(postal_code) AS postal_code,
	MAX(country) AS country
	FROM source
	GROUP BY company_id
)

SELECT * FROM renamed