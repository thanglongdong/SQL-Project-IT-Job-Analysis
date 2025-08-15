/*
Identify the top skills based on salary for data analyst jobs:
- Look into the average salary associated with each skill
- Focus on roles with specified salary, regardless of location
- Goal: Discover how different skills impact salary levels for Data Analysts,
helping job seekers understand which skills can lead to higher earnings
*/

SELECT 
    skills_dim.skills,
    ROUND(AVG(salary_year_avg),2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
ORDER BY average_salary DESC
LIMIT 25;

/*
Key Findings

- Highest-paying skill: svn stands out dramatically at $400,000 average salary, 
which likely skewed by a very small number of high-paying niche roles rather than a broad market trend.

- Emerging tech pays well: Skills like Solidity, Couchbase, Golang, and MXNet command $149K–$179K, 
reflecting demand in blockchain, NoSQL databases, modern programming, and AI frameworks.

- Machine learning libraries such as Keras, PyTorch, Hugging Face, and TensorFlow all cluster around $120K–$127K, 
showing strong value for advanced analytics & AI skills.

- DevOps & automation tools (Terraform, Ansible, Puppet, Airflow) also rank high, which suggesting crossover demand 
for analysts who can work with data pipelines and deployment environments.

- Collaboration & version control platforms (GitLab, Atlassian, Bitbucket, Notion) average around $116K–$134K, 
showing that employers value analysts who can work within structured development workflows.
*/