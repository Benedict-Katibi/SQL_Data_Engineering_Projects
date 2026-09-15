SELECT table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';
SELECT CAST('123' AS INT);
SELECT 15::FLOAT;