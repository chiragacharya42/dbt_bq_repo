{{ config(materialized='table') }}

SELECT
  country,
  COUNT(*)  AS total_airports
FROM {{ ref('clean_data') }}
GROUP BY country