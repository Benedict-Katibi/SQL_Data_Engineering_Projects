/*
 Question: What are the highest-paying skills for data engineers?
 -Calculate the median salary for each skill required in data engineer positions 
 -Focus on remote positions with specified salaries
 -Focus on skills that have a demand count greater than 100
 -Include skill frequency to identify both salary and demand 
 -Why?
 Helps to identify which skillls command the highest compensation while also showing
 how common those skills are, providing a more complete picture for skill development priorities
 */
SELECT sd.skills,
    jpf.job_title_short,
    CAST(ROUND(MEDIAN(jpf.salary_year_avg), 0) AS INT) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY sd.skills,
    jpf.job_title_short
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;
/*
 Here is a breakdown for the highest-paying skills for data engineers:
 
 Key Insights:
 -Rust tops the salary chart with a median salary of $21,000 but with only 232 job postings indicating a niche, 
 specialized skill rather than a common requirement
 -Terraform($184,000) and Golang($184,000) tie for second-highest pay, 
 but Terraform has vastly more demand(3,248 postings vs. Golang's 912)
 suggesting Terraform pays well and is genuinely sought-after, while Golang is
 moure of a rare, premium skill
 -Other notable skills with both high pay and moderrate-to-high postings include:
 - Spring: $175.5K media salary(364 postings)
 - Neo4J: $170K median salary(582 postings)
 
 ┌────────────┬─────────────────┬───────────────┬──────────────┐
 │   skills   │ job_title_short │ median_salary │ demand_count │
 │  varchar   │     varchar     │     int32     │    int64     │
 ├────────────┼─────────────────┼───────────────┼──────────────┤
 │ rust       │ Data Engineer   │        210000 │          232 │
 │ terraform  │ Data Engineer   │        184000 │         3248 │
 │ golang     │ Data Engineer   │        184000 │          912 │
 │ spring     │ Data Engineer   │        175500 │          364 │
 │ neo4j      │ Data Engineer   │        170000 │          277 │
 │ gdpr       │ Data Engineer   │        169616 │          582 │
 │ zoom       │ Data Engineer   │        168438 │          127 │
 │ graphql    │ Data Engineer   │        167500 │          445 │
 │ mongo      │ Data Engineer   │        162250 │          265 │
 │ fastapi    │ Data Engineer   │        157500 │          204 │
 │ django     │ Data Engineer   │        155000 │          265 │
 │ bitbucket  │ Data Engineer   │        155000 │          478 │
 │ crystal    │ Data Engineer   │        154224 │          129 │
 │ atlassian  │ Data Engineer   │        151500 │          249 │
 │ c          │ Data Engineer   │        151500 │          444 │
 │ typescript │ Data Engineer   │        151000 │          388 │
 │ kubernetes │ Data Engineer   │        150500 │         4202 │
 │ node       │ Data Engineer   │        150000 │          179 │
 │ css        │ Data Engineer   │        150000 │          262 │
 │ airflow    │ Data Engineer   │        150000 │         9996 │
 │ ruby       │ Data Engineer   │        150000 │          736 │
 │ redis      │ Data Engineer   │        149000 │          605 │
 │ ansible    │ Data Engineer   │        148798 │          475 │
 │ vmware     │ Data Engineer   │        148798 │          136 │
 │ jupyter    │ Data Engineer   │        147500 │          400 │
 └────────────┴─────────────────┴───────────────┴──────────────┘
 */