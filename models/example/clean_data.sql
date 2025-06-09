-- models/clean_data.sql
{{ config(materialized='view') }}

WITH raw AS (
  SELECT CAST(airport_ID AS INT64) AS airport_id,
    TRIM(Name) AS name,
    TRIM(City) AS city,
    UPPER(TRIM(Country))AS country,
    UPPER(TRIM(IATA)) AS iata_code,
    UPPER(TRIM(ICAO))AS icao_code,
    SAFE_CAST(Latitude AS FLOAT64) AS latitude,
    SAFE_CAST(Longitude AS FLOAT64) AS longitude,
    SAFE_CAST(Altitude AS INT64)AS altitude,
    SAFE_CAST(Timezone AS FLOAT64)AS timezone_offset,
    UPPER(TRIM(DST))AS dst,
    TRIM(Tz_database_time_zone)AS tz_db_tz,
    TRIM(Type)AS airport_type,
    TRIM(Source)AS source,
    SAFE_CAST(start_date AS DATE) AS start_date,
    SAFE_CAST(end_date AS DATE) AS end_date,
    COALESCE(is_current, FALSE) AS is_current
  FROM `profound-jet-461007-r0.mydataset.airdata`
)

SELECT
  airport_id,
  name,
  COALESCE(NULLIF(city, ''), 'Unknown') AS city,
  country,
  iata_code,
  icao_code,
  latitude,
  longitude,
  altitude,
  timezone_offset,
  dst,
  tz_db_tz,
  airport_type,
  source,
  start_date,
  end_date,
  is_current
FROM raw