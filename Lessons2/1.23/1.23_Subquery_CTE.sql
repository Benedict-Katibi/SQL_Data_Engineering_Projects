-- Subquery
SELECT *
FROM(
        SELECT *
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
            OR salary_hour_avg IS NOT NULL
    ) AS valid_salaries
LIMIT 10;
-- CTE 
WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries;
-- Scenario 1 - Subquery in 'SELECT'
--Show each job's salary next to the overall market median:
SELECT job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;
-- Scenario 2 - Sunquery in 'FROM'
--Stage only jobs that are remote before aggregation:
SELECT job_title_short,
    MEDIAN(salary_year_avg) as median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
        SELECT job_title_short,
            salary_year_avg
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
GROUP BY job_title_short
LIMIT 10;
-- Scenario 3 - Subquery in 'HAVING'
-- Keep only job titles whose median salary is above the overall median:
SELECT job_title_short,
    MEDIAN(salary_year_avg) as median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
        SELECT job_title_short,
            salary_year_avg
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    )
LIMIT 10;
SELECT *
FROM range(3) AS src(key);
SELECT *
FROM range(2) AS tgt(key);
SELECT *
FROM range(3) AS src(key)
WHERE EXISTS (
        SELECT 1
        FROM range(2) AS tgt
        WHERE src.key = tgt.src
    );