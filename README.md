# E-Commerce Sales Performance and ROI Analysis

An end-to-end data analysis project on the Brazilian E-Commerce (Olist) dataset — covering data cleaning in Excel, business analysis in SQL, and an interactive dashboard in Power BI.

**Author:** Sumit Babushetty
**LinkedIn:** [linkedin.com/in/sumit-babushetty-520a69338](https://linkedin.com/in/sumit-babushetty-520a69338)
**GitHub:** [github.com/sumit-babushetty](https://github.com/sumit-babushetty)

---

## Project Overview

This project analyzes 3 years of real e-commerce transaction data (2016–2018) from Olist, a Brazilian marketplace, to answer 8 core business questions around revenue, delivery performance, customer satisfaction, and seller performance.

The project follows a real-world analyst workflow:
**Excel** (initial cleaning & exploration) → **SQL** (deep business analysis) → **Power BI** (interactive dashboard for stakeholders).

---

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

| Metric | Value |
|---|---|
| Total Orders | 99,441 |
| Time Period | Sep 2016 – Oct 2018 |
| Tables Used | Orders, Order Items, Customers, Reviews, Payments, Products, Sellers, Category Translation |

---

## Tools Used

| Tool | Purpose |
|---|---|
| **Excel** | Data cleaning, pivot tables, initial exploratory charts |
| **MySQL** | Data cleaning, joins, window functions, CTEs, business analysis |
| **Power BI** | Interactive 2-page dashboard with DAX measures |

---

## Project Structure

```
ecommerce-sales-analysis/
│
├── data/                  → Raw dataset (sample)
├── excel/                 → Cleaned Excel file with pivot tables and charts
├── sql/                   → ecommerce_analysis.sql (8 business queries)
├── powerbi/               → ecommerce_dashboard.pbix
├── screenshots/           → Excel, SQL, and Power BI visuals
└── README.md
```

---

## Business Questions Answered

1. What is the monthly revenue trend?
2. Which are the top 10 product categories by revenue?
3. Which states have the slowest delivery times?
4. How does late delivery impact customer ratings?
5. Who are the top 10 sellers by revenue?
6. What is the monthly revenue growth %?
7. What is the customer repeat purchase rate?
8. Which payment method is most preferred?

---

## Key Insights

### Revenue & Sales
- Generated **R$13.59M** in total revenue across **99,441 orders**, with an average order value of **R$136.68**.
- Revenue grew consistently through 2017, peaking in **November 2017 at R$1.01M** (+52.4% month-over-month), driven by seasonal/holiday demand.
- **health_beauty** was the top-performing category, generating **R$1.26M** in revenue, followed by watches_gifts and bed_bath_table.

### Delivery Performance
- National average delivery time was **~16 days**, with **São Paulo (SP)** the fastest state and **Roraima (RR)** the slowest (~29 days) — highlighting a clear logistics gap for remote regions.
- **97% of orders (96,478)** were successfully delivered; only 0.6% were cancelled.

### Customer Satisfaction
- Late deliveries caused a **1.72-star drop** in customer ratings — On Time orders averaged **4.29★** vs. **2.57★** for Late orders — making delivery speed the single biggest driver of satisfaction.
- Only **3.12%** of customers made repeat purchases (2,997 of 96,096), typical of marketplace-style platforms with low brand loyalty.

### Sellers & Payments
- The top-performing seller generated **R$226,987** in sales across 1,124 orders — significantly ahead of the next-best seller.
- **Credit card** was the dominant payment method, used in **76.9%** of all transactions.

---

## Dashboard Preview

### Page 1 — Sales Overview
KPI cards (Revenue, Orders, AOV), monthly revenue trend, top 10 categories, and payment method breakdown.

![Sales Overview](screenshots/Sales%20Overview%20PBI.png)

### Page 2 — Delivery & Satisfaction
Review score & late delivery KPIs, delivery time by state, review score by delivery status, and monthly satisfaction trend.

![Delivery & Satisfaction](screenshots/Delivery%20%26%20Satisfaction%20PBI.png)

---

## SQL Highlights

The SQL file (`sql/ecommerce_analysis.sql`) includes:
- Multi-table **JOINs** across 7+ tables
- **Window functions** — `RANK()`, `LAG()`
- **CTEs** (Common Table Expressions) for month-over-month growth calculations
- **Subqueries** for repeat purchase rate and payment share
- **CASE WHEN** logic for delivery status classification

---

## Excel Highlights

- Cleaned and merged multi-table data using Power Query
- Built 3 pivot tables: Monthly Revenue, Top 10 Categories, Order Status Breakdown
- Created supporting line, bar, and donut charts

---

## Power BI Highlights

- Connected to CSV source data with defined table relationships (star-schema style)
- Built 5 custom DAX measures: `Total Revenue`, `Total Orders`, `Avg Order Value`, `Avg Review Score`, `Late Delivery %`
- 2-page interactive report with cross-filtering visuals

---

## How to Explore This Project

1. **Excel:** Open `excel/ecommerce_cleaned.xlsx` to view pivot tables and charts
2. **SQL:** Run `sql/ecommerce_analysis.sql` in MySQL Workbench (requires the Olist dataset imported)
3. **Power BI:** Open `powerbi/ecommerce_dashboard.pbix` in Power BI Desktop

---

## Connect With Me

- **LinkedIn:** [linkedin.com/in/sumit-babushetty-520a69338](https://linkedin.com/in/sumit-babushetty-520a69338)
- **GitHub:** [github.com/sumit-babushetty](https://github.com/sumit-babushetty)
