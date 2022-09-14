{% test type_check(model, table_schema) %}

WITH existing_schema AS (
  SELECT COLUMN_NAME, DATA_TYPE FROM input.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = "{{ model.identifier }}"
), expected_column_schema AS (
  SELECT SPLIT(schema_object, ":") AS column_type FROM UNNEST(SPLIT(TRIM("""{{table_schema}}""", ","))) schema_object
), expected_schema AS (
  SELECT TRIM(column_type[OFFSET(0)]) AS column_name, TRIM(IF(ARRAY_LENGTH(column_type) > 1, column_type[OFFSET(1)], column_type[OFFSET(0)])) AS data_type FROM expected_column_schema
)

SELECT 
  expected_schema.column_name AS expected_column_name,
  expected_schema.data_type AS expected_data_type,
  existing_schema.column_name AS existing_column_name,
  existing_schema.data_type AS existing_data_type
FROM expected_schema 
FULL JOIN existing_schema ON expected_schema.column_name = existing_schema.column_name AND expected_schema.data_type = existing_schema.data_type
WHERE NULLIF(TRIM(expected_schema.column_name), '') IS NULL OR NULLIF(TRIM(existing_schema.column_name), '') IS NULL

{% endtest %}