/*
Identify the most demanded skills for data analyst jobs:
- Focus on the skills that are most frequently required in data analyst job postings
- Display the 5 most in-demand skills for the role
- Consider all job postings, not just the top-paying ones
- Goal: Provide insights into the skills that are currently in high demand for Data Analysts,
assisting job seekers in identifying key areas for skill development
*/

SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 10;

/*Key Findings - Implications for Job Seekers

- Mastery of SQL and Excel is essential to be competitive in almost any data analyst role.

- Adding Python (for automation and advanced analysis) plus at least one BI/visualization tool 
(Tableau or Power BI) will cover the majority of employer requirements.

- Developing both technical skills (querying, coding) and communication tools (visualization, presentation) 
creates a well-rounded skill profile.

*/