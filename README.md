# 🏦 Loan Approval Risk Analysis (SQL Case Study)

> **Can banks truly identify risky borrowers — or are approvals still based on incomplete signals?**

Financial institutions rely heavily on automated screening to approve or reject loan applications.
But a critical question remains:

> **Do approvals actually reflect applicant reliability, or just credit history dominance?**

This project investigates real loan application data using **SQL analytics (including window functions)** to uncover patterns in approval decisions, customer behaviour, and hidden risk segments.

---

## 📊 Problem Statement

Banks aim to minimise **default risk** while maximising **loan approvals**.

However, approval systems often:

* Over-depend on a single factor (credit history)
* Ignore behavioural financial signals
* Reject potentially safe customers
* Approve high-risk segments unknowingly

This project analyses borrower demographics, income patterns, and credit attributes to evaluate:

> **Are banks making optimal approval decisions?**

---

## 🗂 Dataset

Loan application dataset containing **600+ applicants** with demographic and financial attributes.

### Features

| Category       | Columns                                               |
| -------------- | ----------------------------------------------------- |
| Personal       | Gender, Married, Dependents, Education, Self_Employed |
| Financial      | ApplicantIncome, CoapplicantIncome, LoanAmount        |
| Loan Details   | Loan_Amount_Term, Property_Area                       |
| Risk Indicator | Credit_History                                        |
| Target         | Loan_Status (Approved / Rejected)                     |

---

## 🎯 Objectives

1. Understand approval distribution across customer segments
2. Identify factors influencing loan approval
3. Detect risky approvals & unfair rejections
4. Measure the relationship between income and loan amount
5. Determine the most reliable borrower profile
6. Evaluate whether **credit history dominates the decision system**
7. Segment customers using SQL window analytics

---

## 🛠 Tools & Technologies

* **MySQL** → Core analysis (joins, aggregations, window functions)
* **Pandas** → Data cleaning & preprocessing
* **Jupyter Notebook** → Exploration
* **GitHub** → Documentation & versioning

---

## 🧹 Data Cleaning

* Removed unnamed index column
* Handled missing categorical values using mode
* Handled numerical nulls using the median
* Encoded Yes/No and Y/N fields
* Standardised dependents and term fields

---

## 🔍 Key Analytical Areas

### 1️⃣ Demographic Behaviour

* Approval rate by gender, education, and marital status
* Property area influence on approvals
* Dependents vs approval relationship

### 2️⃣ Financial Patterns

* Income vs loan amount relationship
* Loan term vs approval probability
* High income rejection paradox

### 3️⃣ Credit Risk Insights

* Impact of credit history
* Hidden safe borrowers without a credit history
* High-risk approved segments

### 4️⃣ Advanced SQL Analytics

* Quartile-based approval comparison
* Ranking applicants within segments
* Cumulative approvals
* Percent contribution analysis

---

## 📈 Major Findings (Business Insights)

✔ Credit history dominates approval decisions
✔ Many high-income applicants still get rejected
✔ Some low-income applicants get approved due to credit history alone
✔ Semi-urban applicants show the highest approval probability
✔ Loan amount is weakly correlated with income
✔ Banks may be rejecting safe customers and approving risky ones

> **Conclusion:** The approval system is rule-biased, not risk-optimised.

---

## 💡 Business Recommendations

* Combine income stability with credit history
* Introduce income-to-loan ratio scoring
* Reduce over-reliance on credit history
* Use percentile-based approval thresholds
* Create segment-specific approval rules

---

## 🧠 What This Project Demonstrates

* Real business problem solving using SQL
* Analytical thinking beyond dashboards
* Window function expertise
* Financial risk interpretation
* Data storytelling

---

## 📌 How to Run

1. Import the dataset into MySQL
2. Run SQL scripts inside `/queries`
3. Review insights & segmentation outputs

---

## 👨‍💻 Author

**Abhishek Singh**
Aspiring Data Analyst | SQL • Python • Business Analytics
