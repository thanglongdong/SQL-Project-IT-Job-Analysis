/*
Identify the most optimal skills to acquire for data analyst jobs, aiming for high demand and salary:
- Focus on skills that are both in high demand and associated with higher salaries
- Analyze the intersection of high-demand skills and those that lead to better-paying roles
- Goal: Target skills that offer job security and financial benefits for Data Analysts,
offer strategic insights into career development
*/

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
), average_skill_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg),2) AS average_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_skill_salary.average_salary
FROM skills_demand
JOIN average_skill_salary ON skills_demand.skill_id = average_skill_salary.skill_id
WHERE skills_demand.demand_count> 10
ORDER BY 
    skills_demand.demand_count DESC,
    average_skill_salary.average_salary DESC
LIMIT 25;

-- More concise version of the query
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/* Key Findings - Market Direction Signals

- Cloud & Big Data expertise (Azure, Snowflake, Hadoop, BigQuery, AWS) shows consistent premium salaries, 
which aligns with the shift toward distributed analytics and AI pipelines.

- End-to-end skills (Python + SQL + BI + Cloud) are increasingly valued, reflecting employers’ preference 
for analysts who can build, analyse, and present without heavy reliance on separate teams.

- Traditional BI tools (Tableau, SAS, Oracle) retain relevance, especially in enterprise and finance sectors, 
despite the rise of newer stacks.

Career Strategy

Step 1: Secure core skills for job stability — Python, R, Tableau, SQL variant.

Step 2: Layer in one niche, high-salary tech (Snowflake, Hadoop, Go) to stand out.

Step 3: Monitor emerging tools in cloud analytics; early adoption leads to premium pay before market saturation.

*/