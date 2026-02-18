create database loan_analysis;
use loan_analysis;

select * from loan limit 10;

# 🟢 BASIC INSIGHTS (Understanding Customers)
## 1. How many loan applications are approved vs rejected?
select count(*),loan_status from loan group by loan_status;

## 2. What is the gender distribution of applicants?
select count(*),gender from loan group by gender;

## 3. What percentage of applicants are married?
select count(*),Married from loan group by married;

## 4. How many applicants are self-employed?
select count(*),self_employed from loan group by self_employed;

## 5. What is the distribution of applicants across property areas (Urban/Rural/Semiurban)?
select count(*),property_area from loan group by property_area;

## 6. What is the average applicant income?
select avg(applicantincome)  from loan;

## 7. What is the average loan amount requested?
select avg(loanamount) from loan;

## 8. What is the average loan term?
select avg(loan_amount_term) from loan;

## 9. How many applicants have credit history vs no credit history?
select count(*),credit_history from loan group by credit_history;

## 10. What is the approval rate overall?
select ROUND(100*SUM(loan_status='Y')/COUNT(*),2) from loan;

# 🟡 DEMOGRAPHIC ANALYSIS
## 11. Approval rate by gender?
select gender, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by gender;

## 12. Approval rate by marital status?
select married, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by married;

## 13. Approval rate by education level?
select education, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by education;

## 14. Approval rate by self-employment status?
select gender, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by gender;

## 15. Approval rate by property area?
select property_area, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by property_area;

## 16. Approval rate based on number of dependents?
select dependents, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by dependents;

## 17. Which education group applies for higher loan amounts?
select education, avg(loanamount) as avg_loan from loan group by education;

## 18. Which property area has the highest average income?
select property_area, avg(applicantincome) as avg_inc from loan group by property_area;

## 19. Does marital status influence loan amount requested?
select married, avg(loanamount) as avg_loan from loan group by married;

## 20. Does self-employment influence loan approval?
select self_employed, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by self_employed;

# 🟠 INCOME & LOAN RELATIONSHIPS
## 21. Average loan amount by income range buckets?
select case when applicantincome < 2500 then 'Low' when applicantincome < 5000 then 'Medium' else 'High' end as income_buckets , avg(loanamount) from loan group by income_buckets;

## 22. Average co-applicant income by approval status?
select loan_status, avg(coapplicantincome) from loan group by loan_status;

## 23. Do higher income applicants get approved more?
select applicantincome, loan_status from loan order by applicantincome desc;

## 24. Loan approval rate by income quartiles?
select quartile, round(100*sum(loan_status=0)/count(*),2) as approval from (select loan_status, ntile(4) over(order by applicantincome) as quartile from loan) t
group by quartile order by quartile;

## 25. Average total income (applicant + coapplicant) by approval status?
select loan_status, avg(applicantincome + coapplicantincome) as avg_income from loan group by loan_status;

## 26. What income range has the highest rejection rate?
select case when applicantincome < 3000 then 'Low' when applicantincome < 6000 then 'Medium' else 'High' end as income_buckets, round(100*sum(loan_status='N')/count(*),2) from loan group by income_buckets;

## 27. Is loan amount proportional to income?
SELECT 
(COUNT(*) * SUM(ApplicantIncome * LoanAmount) - SUM(ApplicantIncome) * SUM(LoanAmount))
/
SQRT(
    (COUNT(*) * SUM(POW(ApplicantIncome,2)) - POW(SUM(ApplicantIncome),2)) *
    (COUNT(*) * SUM(POW(LoanAmount,2)) - POW(SUM(LoanAmount),2))) AS correlation from loan;

## 28. Average loan amount requested by education level?
select education, avg(loanamount) from loan group by education;

## 29. Does higher loan term affect approval rate?
select loan_amount_term, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by loan_amount_term;

## 30. Compare average loan amount between approved and rejected loans.
select loan_status, avg(loanamount) from loan group by loan_status;

# 🔵 CREDIT RISK ANALYSIS
## 31. Approval rate for applicants with credit history vs without?
select credit_history, ROUND(100*SUM(loan_status='Y')/COUNT(*),2) as approval from loan group by credit_history;

## 32. Percentage of rejected applicants without credit history?
select ROUND(100*SUM(loan_status='N' and credit_history=0)/COUNT(loan_status='N'),2) as approval from loan;

## 33. Average loan amount for customers without credit history?
select credit_history, avg(loanamount) from loan where credit_history=0;

## 34. Do applicants without credit history request higher loans?
select credit_history, avg(loanamount) from loan group by credit_history;

## 35. Property area vs credit history relationship?
select property_area, credit_history, count(*) from loan group by credit_history, property_area;

## 36. Education vs credit history relationship?
select education, credit_history, count(*) from loan group by credit_history, education;

## 37. Self-employed vs credit history relationship?
select self_employed, credit_history, count(*) from loan group by credit_history, self_employed;

## 38. Which group has highest risk (rejection %)?
select property_area, ROUND(100*SUM(loan_status='N')/COUNT(*),2) as rejection from loan group by property_area;

## 39. Does credit history dominate approval decision?
select credit_history, loan_status, count(*) from loan group by credit_history, loan_status;

## 40. Among approved loans, how many lacked credit history?
select count(*) from loan where credit_history=0 and loan_status='Y';

# 🟣 GROUPED AGGREGATE INSIGHTS
## 41. Average income by gender and education combination?
select gender, education, avg(applicantincome) from loan group by gender,education;

## 42. Average loan amount by property area and marital status?
select property_area, married, avg(applicantincome) from loan group by property_area,married;

## 43. Approval rate by (gender + education)?
select gender, education, round(100*sum(loan_status='Y')/count(*),2) from loan group by gender, education;

## 44. Approval rate by (self_employed + credit_history)?
select self_employed, credit_history, round(100*sum(loan_status='Y')/count(*),2) from loan group by self_employed, credit_history;

## 45. Average income by dependents group?
select dependents, avg(applicantincome) from loan group by dependents;

## 46. Highest approving demographic segment?
select property_area, round(100*sum(loan_status='Y')/count(*),2) from loan group by property_area order by 2 desc limit 1;

## 47. Highest rejecting demographic segment?
select property_area, round(100*sum(loan_status='N')/count(*),2) from loan group by property_area order by 2 desc limit 1;

## 48. Which property area requests highest loans but gets least approvals?
select property_area, avg(loanamount), round(100*sum(loan_status='Y')/count(*),2) from loan group by property_area;

## 49. Income vs approval grouped by education?
select education, avg(applicantincome), round(100*sum(loan_status='Y')/count(*),2) from loan group by education; 

## 50. Average loan term by approval status?
select loan_status, avg(loan_amount_term) from loan group by loan_status;

# 🔴 ADVANCED ANALYSIS (Business Insights)
## 51. Top 10 highest income applicants — how many got approved?
select count(*) from (select loan_status from loan order by applicantincome desc limit 10)top where loan_status='Y';

## 52. Top 10 largest loan requests — approval percentage?
select round(100*sum(loan_status='Y')/count(*),2) from (select loan_status from loan order by applicantincome desc limit 10)top;

## 53. Which segment requests high loan but has low approval rate?
select property_area, avg(loanamount), round(100*sum(loan_status='Y')/count(*), 2) from loan group by property_area;

## 54. Which segment gets approved despite low income?
select * from loan where loan_status='Y' and applicantincome<1500;

## 55. Which group is safest for banks (high approval + good credit)?
select property_area, round(100*sum(loan_status='Y')/count(*),2) from loan where credit_history=1 group by property_area;

## 56. What % of approvals come from semiurban areas?
select round(100*sum(loan_status='Y' and property_area='Semiurban')/sum(loan_status='Y'),2) from loan;

## 57. What % of rejections come from rural areas?
select round(100*sum(loan_status='N' and property_area='Rural')/sum(loan_status='N'),2) from loan;

## 58. Which demographic is over-represented in rejections?
select gender, round(100*sum(loan_status='N')/count(*),2) from loan group by gender order by 2 desc;

## 59. Compare average loan per approved vs rejected per property area.
select property_area, loan_status, avg(loanamount) from loan group by property_area, loan_status;

## 60. Identify ideal customer profile for loan approval.
select * from loan where credit_history=1 and applicantincome>12500 and loan_status='Y';

# 🟤 WINDOW FUNCTION INSIGHTS (NO LAG/LEAD)
## 61. Rank applicants by income within each property area.
select *, rank() over(partition by property_area order by applicantincome desc) rnk from loan;

## 62. Rank applicants by loan amount within education group.
select *, rank() over(partition by education order by loanamount desc) rnk from loan;

## 63. Dense rank customers by total income within gender.
select *, dense_rank() over(partition by gender order by applicantincome+coapplicantincome desc) rnk from loan;

## 64. Find top 5 highest income applicants per property area.
select * from (select *, rank() over(partition by property_area order by applicantincome+coapplicantincome desc) rnk from loan) a where rnk<=5;

## 65. Find top 3 loan amounts per education category.
select * from (select *, rank() over(partition by education order by loanamount desc) rnk from loan) a where rnk<=3;

## 66. Running total of loan amounts ordered by income.
select loan_id, sum(loanamount) over(order by applicantincome) running_total from loan;

## 67. Running average income across applicants ordered by loan amount.
select avg(applicantincome) over(order by loanamount) running_avg from loan;

## 68. Percentage contribution of each applicant’s income to total income.
select loan_id, applicantincome, coapplicantincome,  applicantincome/sum(applicantincome+coapplicantincome) over()*100 pct from loan;

## 69. Percentage contribution of each property area to total approved loans.
select property_area ,sum(loan_status='Y')*100/sum(sum(loan_status='Y')) over() pct from loan group by property_area;

## 70. Cumulative approval count ordered by income.
select loan_id, sum(loan_status='Y') over(order by applicantincome) as cum_app from loan;

## 71. Cumulative rejection count ordered by loan amount.
select loan_id, sum(loan_status='N') over(order by loanamount) as cum_rej from loan;

## 72. Find percentile rank of applicants by income.
select loan_id, percent_rank() over(order by applicantincome) from loan;

## 73. Which applicants fall in top 25% income bracket?
select * from (select *, ntile(4) over(order by applicantincome desc) q from loan) a where q=1;

## 74. Compare applicant income to average income of their property area.
select loan_id, applicantincome, avg(applicantincome) over(partition by property_area) area_avg from loan;

## 75. Compare loan amount to average loan amount of their education group.
select loan_id, loanamount, avg(loanamount) over(partition by education) edu_avg from loan;

## 76. Identify applicants whose income is above group average but rejected.
select * from (select *, avg(applicantincome) over(partition by property_area) avg_inc from loan) a where applicantincome>avg_inc and loan_status='N';

## 77. Identify applicants whose income is below group average but approved.
select * from (select *, avg(applicantincome) over(partition by property_area) avg_inc from loan) a where applicantincome<avg_inc and loan_status='Y';

## 78. Find highest income applicant within each marital status group.
select * from (select *, rank() over(partition by married order by applicantincome desc) rnk from loan) a where rnk=1;

## 79. Find lowest loan amount approved per property area.
select * from (select *, rank() over(partition by property_area order by loanamount desc) rnk from loan where loan_status='Y') a where rnk=1;

## 80. Determine approval share per demographic segment using window aggregates.
select gender, 100*sum(loan_status='Y')/sum(sum(loan_status='Y')) over() share from loan group by gender;