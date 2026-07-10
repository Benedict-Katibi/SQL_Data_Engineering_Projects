/*
 Question: What are the most optima skills for data engineers-balancing both demand and salary?
 -Create a ranking column that combines demand count and median saary to identify the most valuable skills.
 -Focus only on remote Data Engineer positions with specified annual salaries.
 -Why?
 - This approach highlihts skills that balance market demand and financial reward.
 */
SELECT sd.skills,
    CAST(ROUND(MEDIAN(jpf.salary_year_avg), 0) AS INT) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND(
        (MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000,
        2
    ) AS optimal_score
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills,
    jpf.job_title_short
HAVING COUNT(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 25;
/*
 
 
 Here is a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:
 
 Top skills by Optimal Score:
 - Terraform leads the list with a $184K median salary and 193 postings, resulting  in the highest overall "optimal score" of 0.97.
 - Python and SQL dominate demand (over 1000 postings each), with strong median salaries of $135K and $138K, respectively
 - AWS(783 postings, $137K median), Spark(503 postings, 140K median), and Airflow(386 postings, $150K median) are also ranking higher on optimal scores
 - Kafka offers high compensation ($145K median) and a solid demand(292 postings)
 -Tools like Snowflake, Azure, and Databricks each have 250-475 postings and median salaries between $128K-$137K
 
 ┌────────────┬─────────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
 │   skills   │ job_title_short │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
 │  varchar   │     varchar     │     int32     │    int64     │     double      │    double     │
 ├────────────┼─────────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
 │ terraform  │ Data Engineer   │        184000 │          193 │             5.3 │          0.97 │
 │ python     │ Data Engineer   │        135000 │         1133 │             7.0 │          0.95 │
 │ aws        │ Data Engineer   │        137320 │          783 │             6.7 │          0.91 │
 │ sql        │ Data Engineer   │        130000 │         1128 │             7.0 │          0.91 │
 │ airflow    │ Data Engineer   │        150000 │          386 │             6.0 │          0.89 │
 │ spark      │ Data Engineer   │        140000 │          503 │             6.2 │          0.87 │
 │ kafka      │ Data Engineer   │        145000 │          292 │             5.7 │          0.82 │
 │ snowflake  │ Data Engineer   │        135500 │          438 │             6.1 │          0.82 │
 │ azure      │ Data Engineer   │        128000 │          475 │             6.2 │          0.79 │
 │ java       │ Data Engineer   │        135000 │          303 │             5.7 │          0.77 │
 │ scala      │ Data Engineer   │        137290 │          247 │             5.5 │          0.76 │
 │ kubernetes │ Data Engineer   │        150500 │          147 │             5.0 │          0.75 │
 │ git        │ Data Engineer   │        140000 │          208 │             5.3 │          0.75 │
 │ databricks │ Data Engineer   │        132750 │          266 │             5.6 │          0.74 │
 │ redshift   │ Data Engineer   │        130000 │          274 │             5.6 │          0.73 │
 │ gcp        │ Data Engineer   │        136000 │          196 │             5.3 │          0.72 │
 │ hadoop     │ Data Engineer   │        135000 │          198 │             5.3 │          0.71 │
 │ nosql      │ Data Engineer   │        134415 │          193 │             5.3 │          0.71 │
 │ pyspark    │ Data Engineer   │        140000 │          152 │             5.0 │           0.7 │
 │ mongodb    │ Data Engineer   │        135750 │          136 │             4.9 │          0.67 │
 │ docker     │ Data Engineer   │        135000 │          144 │             5.0 │          0.67 │
 │ go         │ Data Engineer   │        140000 │          113 │             4.7 │          0.66 │
 │ r          │ Data Engineer   │        134775 │          133 │             4.9 │          0.66 │
 │ bigquery   │ Data Engineer   │        135000 │          123 │             4.8 │          0.65 │
 │ github     │ Data Engineer   │        135000 │          127 │             4.8 │          0.65 │
 └────────────┴─────────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
 */