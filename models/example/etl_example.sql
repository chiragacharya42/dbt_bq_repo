{{ config(materialized='view') }}

SELECT *
FROM `profound-jet-461007-r0.mydataset.airdata`