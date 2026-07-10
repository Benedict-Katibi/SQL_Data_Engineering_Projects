/*
 Question: What are the most in-demand skills for data engineers?
 -Identify the top 10 in-demand skills for data engineers
 -Focus on remote job postings
 -Provide a ranking for the top 10 in-demand skills for data engineers
 -Why?
 Retrieves the top 10 skills with the highest denmand in the remote job market, 
 providing insights into the most valuable skills for data engineers seeking remote work
 and provides a ranking 
 */
SELECT sd.skills,
    jpf.job_title_short,
    COUNT(jpf.*) AS demand_count,
    RANK() OVER(
        ORDER BY COUNT(jpf.*) DESC
    ) AS demand_rank
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY sd.skills,
    jpf.job_title_short
ORDER BY demand_count DESC
LIMIT 10;
/*
 ┌────────────┬─────────────────┬──────────────┬─────────────┐
 │   skills   │ job_title_short │ demand_count │ demand_rank │
 │  varchar   │     varchar     │    int64     │    int64    │
 ├────────────┼─────────────────┼──────────────┼─────────────┤
 │ sql        │ Data Engineer   │        29221 │           1 │
 │ python     │ Data Engineer   │        28776 │           2 │
 │ aws        │ Data Engineer   │        17823 │           3 │
 │ azure      │ Data Engineer   │        14143 │           4 │
 │ spark      │ Data Engineer   │        12799 │           5 │
 │ airflow    │ Data Engineer   │         9996 │           6 │
 │ snowflake  │ Data Engineer   │         8639 │           7 │
 │ databricks │ Data Engineer   │         8183 │           8 │
 │ java       │ Data Engineer   │         7267 │           9 │
 │ gcp        │ Data Engineer   │         6446 │          10 │
 └────────────┴─────────────────┴──────────────┴─────────────┘
 10 rows                                         4 columns
 */