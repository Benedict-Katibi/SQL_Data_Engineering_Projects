# Exploratory Data Analysis with SQL: Job Market Analysis

![Project 1 Overview](../Images/1_1_Project1_EDA.png)

A SQL project analyzing the data engineer job market using real-world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## Executive Summary

- **Project scope:** Built 3 analytical queries that answer key questions about the data engineer job market.
- **Data modeling:** Used multi-table joins across fact, dimension, and bridge tables to extract job market insights.
- **Analytics:** Applied aggregations, filtering, ranking, and sorting to identify top skills by demand, salary, and overall value.
- **Outcomes:** Delivered actionable insights on SQL/Python dominance, cloud platform demand, infrastructure tooling, and salary patterns.

If you only have a minute, review these:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) - Demand analysis using multi-table joins
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) - Salary analysis using aggregations
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) - Combined demand/salary optimization query

## Problem & Context

Job market analysts need to answer questions like:

- **Most in-demand:** Which skills are most in-demand for data engineers?
- **Highest paid:** Which skills command the highest salaries?
- **Best trade-off:** What is the optimal skill set balancing demand and compensation?

This project analyzes a data warehouse built using a star schema design. The warehouse structure consists of:

![Data Warehouse](../Images/1_2_Data_Warehouse.png)

- **Fact table:** `job_postings_fact` - Central table containing job posting details such as job titles, locations, salaries, and dates.
- **Dimension tables:**
  - `company_data` - Company information linked to job postings.
  - `skills_dim` - Skills catalog with skill names and skill types.
- **Bridge table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills.

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles.

## Tech Stack

- **Query engine:** DuckDB for fast OLAP-style analytical queries
- **Language:** SQL
- **Data model:** Star schema with fact, dimension, and bridge tables
- **Development:** VS Code for SQL editing and Terminal for DuckDB CLI
- **Version control:** Git/GitHub for versioned SQL scripts

## Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql
├── 02_top_paying_skills.sql
├── 03_optimal_skills.sql
└── README.md
```

## How to Run

Open DuckDB from the project directory and run any of the SQL scripts:

```sql
.read 1_EDA/01_top_demanded_skills.sql
.read 1_EDA/02_top_paying_skills.sql
.read 1_EDA/03_optimal_skills.sql
```

Each query assumes the data warehouse tables are already available in DuckDB:

- `job_postings_fact`
- `company_data`
- `skills_dim`
- `skills_job_dim`

## Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** - Identifies and ranks the 10 most in-demand skills for remote data engineer positions.
2. **[Top Paying Skills](./02_top_paying_skills.sql)** - Analyzes the 25 highest-paying skills with salary and demand metrics.
3. **[Optimal Skills](./03_optimal_skills.sql)** - Calculates an optimal score using the natural log of demand combined with median salary to identify the most valuable skills to learn.

### Key Insights

- **Core languages:** SQL and Python each appear in about 29,000 job postings, making them the most demanded skills.
- **Cloud platforms:** AWS and Azure are critical for modern data engineering roles.
- **Infrastructure and tooling:** Kubernetes, Docker, and Terraform are associated with premium salaries.
- **Big data tools:** Apache Spark shows strong demand with competitive compensation.

## Business Value

This analysis helps data engineers and job market analysts identify which skills are most worth prioritizing. Instead of looking only at demand or only at salary, the project compares both signals to highlight skills with strong career value.

## SQL Skills Demonstrated

### Query Design & Optimization

- **Complex joins:** Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`.
- **Aggregations:** `COUNT()`, `MEDIAN()`, and `ROUND()` for statistical analysis.
- **Filtering:** Boolean logic with `WHERE` clauses and multiple conditions such as `job_title_short`, `job_work_from_home`, and `salary_year_avg IS NOT NULL`.
- **Window functions:** `RANK()` for ranking skills based on demand.
- **Sorting and limiting:** `ORDER BY`, `DESC`, and `LIMIT` for top-N analysis.

### Data Analysis Techniques

- **Grouping:** `GROUP BY` for categorical analysis by skill.
- **Conditional logic:** `CASE WHEN` statements for derived metrics.
- **Mathematical functions:** `LN` for natural logarithm transformation to normalize demand metrics.
- **Calculated metrics:** Derived optimal score combining log-transformed demand with median salary.
- **HAVING clauses:** Filtering aggregated results for skills with at least 100 postings.
- **NULL handling:** Filtering incomplete salary records with `salary_year_avg IS NOT NULL`.
