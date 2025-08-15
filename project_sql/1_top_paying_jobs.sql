/*
Identify top-paying data analyst jobs:
- Top 10 highest paying data analyst jobs that are available remotely
- Focus on job postings with specific salary ranges (remove NULLs)
- Goal: Highlight top paying opportunities for Data Analysts, offering insights into job offerings
*/

SELECT
    job_id,
    job_title,
    job_location,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date :: DATE
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title LIKE '%Data Analyst%' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

/* Key Findings

- Majority are senior or principal-level roles (e.g., Principal Data Analyst, Director, Senior Data Analyst).

- A few specialized roles appear, such as Marketing Data Analyst, AV Performance Analysis, and ERM Data Analyst.

- Leadership-focused titles like Director and Principal dominate the upper salary range.

*/