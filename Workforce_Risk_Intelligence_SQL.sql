CREATE DATABASE hr_analytics_db;
USE hr_analytics_db;



CREATE TABLE workforce_risk_analysis (
Employee_ID INT,
Age INT,
Gender VARCHAR(20),
Marital_Status VARCHAR(30),
Department VARCHAR(50),
Job_Role VARCHAR(50),
Job_Level INT,
Monthly_Income INT,
Hourly_Rate INT,
Years_at_Company INT,
Years_in_Current_Role INT,
Years_Since_Last_Promotion INT,
Work_Life_Balance INT,
Job_Satisfaction INT,
Performance_Rating INT,
Training_Hours_Last_Year INT,
Overtime VARCHAR(10),
Project_Count INT,
Average_Hours_Worked_Per_Week INT,
Absenteeism INT,
Work_Environment_Satisfaction INT,
Relationship_with_Manager INT,
Job_Involvement INT,
Distance_From_Home INT,
Number_of_Companies_Worked INT,
Attrition VARCHAR(10)
);
SELECT COUNT(*)
FROM workforce_risk_analysis;
SELECT *
FROM workforce_risk_analysis
LIMIT 10;
SELECT
COUNT(*) - COUNT(Employee_ID) AS Missing_EmployeeID,
COUNT(*) - COUNT(Monthly_Income) AS Missing_Income,
COUNT(*) - COUNT(Job_Satisfaction) AS Missing_Satisfaction,
COUNT(*) - COUNT(Attrition) AS Missing_Attrition
FROM workforce_risk_analysis;
SELECT Employee_ID,
COUNT(*)
FROM workforce_risk_analysis
GROUP BY Employee_ID
HAVING COUNT(*) > 1;
SELECT Attrition,
COUNT(*)
FROM workforce_risk_analysis
GROUP BY Attrition;
SELECT Department,
COUNT(*)
FROM workforce_risk_analysis
GROUP BY Department;
SELECT COUNT(*) AS Total_Employees
FROM workforce_risk_analysis;
SELECT
ROUND(
100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS Attrition_Rate
FROM workforce_risk_analysis;
SELECT
ROUND(AVG(Monthly_Income),2)
AS Avg_Monthly_Income
FROM workforce_risk_analysis;
SELECT
ROUND(AVG(Years_at_Company),2)
AS Avg_Tenure
FROM workforce_risk_analysis;
SELECT Department,
COUNT(*) Employee_Count
FROM workforce_risk_analysis
GROUP BY Department
ORDER BY Employee_Count DESC;


         ###attrition by department
SELECT                 
Department,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(
100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/
COUNT(*),
2
) AS Attrition_Rate
FROM workforce_risk_analysis
GROUP BY Department
ORDER BY Attrition_Rate DESC;

         #####attrition by overtime

SELECT
Overtime,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(
100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/
COUNT(*),
2
) AS Attrition_Rate
FROM workforce_risk_analysis
GROUP BY Overtime;

      #####attrition by job satisfaction
      
SELECT
Job_Satisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(
100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/
COUNT(*),
2
) AS Attrition_Rate
FROM workforce_risk_analysis
GROUP BY Job_Satisfaction
ORDER BY Job_Satisfaction;

       ####attrition by work life balance
       
SELECT
Work_Life_Balance,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(
100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
/
COUNT(*),
2
) AS Attrition_Rate
FROM workforce_risk_analysis
GROUP BY Work_Life_Balance
ORDER BY Work_Life_Balance;

       ###attrition by years since last promotion
SELECT
Years_Since_Last_Promotion,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM workforce_risk_analysis
GROUP BY Years_Since_Last_Promotion
ORDER BY Years_Since_Last_Promotion;

 #####Department Risk Ranking 

SELECT
    Department,
    COUNT(*) AS Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),2
    ) AS Attrition_Rate
FROM workforce_risk_analysis
GROUP BY Department
ORDER BY Attrition_Rate DESC;

#####Compensation Analysis 

SELECT
    Job_Role,
    ROUND(AVG(Monthly_Income),2) AS Avg_Salary
FROM workforce_risk_analysis
GROUP BY Job_Role
ORDER BY Avg_Salary DESC
LIMIT 5;

####Burnout Analysis 

SELECT
    Overtime,
    ROUND(AVG(Job_Satisfaction),2) AS Avg_Satisfaction,
    ROUND(AVG(Work_Life_Balance),2) AS Avg_WorkLifeBalance
FROM workforce_risk_analysis
GROUP BY Overtime;

########Workforce Risk Segmentation 

SELECT
CASE
    WHEN Overtime='Yes'
         AND Job_Satisfaction <=2
         AND Work_Life_Balance <=2
    THEN 'High Risk'

    WHEN Job_Satisfaction <=3
    THEN 'Medium Risk'

    ELSE 'Low Risk'
END AS Risk_Level,

COUNT(*) AS Employees

FROM workforce_risk_analysis
GROUP BY Risk_Level;

#######Performance Benchmarking 

SELECT
    Department,
    ROUND(AVG(Performance_Rating),2) AS Avg_Performance,
    DENSE_RANK() OVER(
        ORDER BY AVG(Performance_Rating) DESC
    ) AS Performance_Rank
FROM workforce_risk_analysis
GROUP BY Department;


