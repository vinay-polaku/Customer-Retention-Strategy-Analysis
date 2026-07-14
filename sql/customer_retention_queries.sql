-- Customer Retention Strategy Analysis
-- Telco Customer Churn Dataset

-- Query 1: How many customers are in the dataset?

SELECT COUNT(*) AS total_customers
FROM churn;


-- Query 2: How many customers churned vs. stayed?

SELECT
    Churn,
    COUNT(*) AS customers
FROM churn
GROUP BY Churn;


-- Query 3: Do churned customers have shorter tenure?

SELECT
    Churn,
    ROUND(AVG(tenure),2) AS avg_tenure
FROM churn
GROUP BY Churn;


-- Query 4: How many customers churned by contract type?

SELECT
    Contract,
    Churn,
    COUNT(*) AS customers
FROM churn
GROUP BY Contract, Churn
ORDER BY Contract;


-- Query 5: What is the churn rate by contract type?

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate
FROM churn
GROUP BY Contract
ORDER BY churn_rate DESC;


-- Query 6: What is the churn rate by internet service?

SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate
FROM churn
GROUP BY InternetService
ORDER BY churn_rate DESC;


-- Query 7: Which contract types generate the most monthly revenue?

SELECT
    Contract,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge,
    ROUND(SUM(MonthlyCharges),2) AS monthly_revenue
FROM churn
GROUP BY Contract
ORDER BY monthly_revenue DESC;


-- Query 8: Do churned customers pay higher monthly charges?

SELECT
    Churn,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge
FROM churn
GROUP BY Churn;


-- Query 9: How much monthly revenue is at risk due to churn?

SELECT
    ROUND(SUM(MonthlyCharges),2) AS revenue_at_risk
FROM churn
WHERE Churn = 'Yes';


-- Query 10: Which contract type keeps customers the longest?

SELECT
    Contract,
    ROUND(AVG(tenure),2) AS avg_tenure
FROM churn
GROUP BY Contract
ORDER BY avg_tenure DESC;


-- Query 11: Does tech support reduce churn?

SELECT
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS churn_rate
FROM churn
GROUP BY TechSupport
ORDER BY churn_rate DESC;


-- Query 12: Which tenure group generates the most revenue?

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49+ Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge,
    ROUND(SUM(MonthlyCharges),2) AS monthly_revenue
FROM churn
GROUP BY tenure_group
ORDER BY monthly_revenue DESC;
