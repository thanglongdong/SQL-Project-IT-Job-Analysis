/*
Identify the skills required for top-paying data analyst jobs:
- Based on the top 10 highest paying data analyst jobs that are available remotely (Query 1)
- Add specific skills associated with these roles
- Goal: Highlight the skills that are most sought after in high-paying Data Analyst positions,
helping candidates understand what to focus on for career advancement
*/

-- Display the top-paying jobs with their associated skills

WITH top_paying_jobs AS (
    SELECT
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg,
    job_posted_date :: DATE
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills,
    skills_dim.type AS skill_type
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

-- Display the 10 most common skills required for the identified top-paying jobs

WITH top_paying_jobs AS (
    SELECT
    job_id,
    job_title,
    name AS company_name,
    salary_year_avg,
    job_posted_date :: DATE
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    skills_dim.skills,
    COUNT(skills_dim.skills) AS skill_count
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY skill_count DESC
LIMIT 10;



/* Key Findings - Patterns & Trends

- High-paying analyst roles require a blend of technical depth (SQL, Python, cloud) 
and business-facing skills (visualization, reporting).

- Cloud and big data tools are heavily represented, suggesting companies prioritize scalable, 
distributed analytics environments.

- Collaboration platforms appear frequently, reflecting the teamwork demands of remote roles.

Implications for Job Seekers

- To target top-paying remote analyst positions, focus on SQL + Python as a baseline.

- Add at least one major cloud platform (Azure, AWS, or Snowflake) 
and big data processing skills (PySpark, Pandas, Hadoop).

- Master a leading visualization tool (Tableau or Power BI) to complement technical skills.

- Familiarity with team collaboration tools can improve adaptability in remote environments.

*/