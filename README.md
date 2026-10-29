# E-commerce Customer Analytics & RFM Segmentation

An end-to-end data analytics project using SQL, Python, Pandas, and Power BI to analyse customer purchasing behaviour, segment customers, and identify churn risk.

## 1. Project Overview

This project focuses on analysing e-commerce transaction data to understand customer value, purchasing patterns, and retention.

The workflow covers business requirement analysis, data cleaning using SQL, customer segmentation using Python, and interactive dashboard development using Power BI.

The objective is to transform raw transactional data into meaningful insights that can help businesses make data-driven decisions about customer retention and marketing strategies.

## 2. Business Problem

Businesses need to understand which customers contribute the most revenue and which customers have become inactive. Without structured customer analytics, retention efforts may not be targeted effectively.

This project uses RFM analysis and rule-based churn identification to understand customer behaviour and support better business decisions.

## 3. Business Questions

- Who are the most valuable customers?
- How much revenue does each customer segment contribute?
- Which customers have become inactive?
- How do revenue and customer trends change over time?
- How does customer value differ across countries and customer segments?
- Which customer segments may require retention efforts?

## 4. Dataset

- **Dataset:** Online Retail II
- **Source:** [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/502/online+retail+ii)
- **Contributor:** Daqing Chen
- **Period:** December 2009 – December 2011
- **Raw records:** 1,067,371 transaction rows

The dataset contains anonymised transactional records from a UK-based online retailer selling giftware.

### Dataset Columns and Their Meaning

| Column | Description | Data Type / Nature |
|---|---|---|
| `InvoiceNo` | Invoice number. A 6-digit integral number uniquely assigned to each transaction. If the code starts with `C`, it indicates a cancellation. | Nominal |
| `StockCode` | Product (item) code. A 5-digit integral number uniquely assigned to each distinct product. | Nominal |
| `Description` | Product (item) name. | Nominal |
| `Quantity` | Quantity of each product per transaction. | Numeric |
| `InvoiceDate` | Date and time when a transaction was generated. | Date and time |
| `UnitPrice` | Product price per unit in sterling (£). | Numeric |
| `CustomerID` | Customer number. A 5-digit integral number uniquely assigned to each customer. | Nominal |
| `Country` | Country where the customer resides. | Nominal |

**Important points to remember:**
- An invoice represents a transaction; multiple products may belong to the same invoice.
- An invoice number starting with `C` indicates a cancellation.
- `Quantity` represents the number of items purchased, while `UnitPrice` represents the price per item.
- `CustomerID` identifies the customer and may be missing for some transactions.
- `Country` can be used to analyse customer distribution and revenue geographically.

## 5. Tech Stack

| Tool | Purpose |
|---|---|
| SQL Server / SSMS | Data import, cleaning, deduplication, and exploratory analysis |
| Python | RFM calculations, customer scoring, segmentation, and churn flagging |
| Pandas | Data manipulation and customer-level aggregation |
| Jupyter Notebook | Python analysis |
| Power BI Desktop | Interactive dashboard and data visualisation |
| DAX | Measures for revenue, customer counts, and customer value |

## 6. Project Workflow

### Step 1: Business Requirement Analysis

- Defined the business problem, scope, key metrics, customer segments, and analytical questions.
- Identified the insights required to support customer retention and business decisions.

### Step 2: Data Cleaning and Exploration Using SQL

- Imported and combined the raw transaction data.
- Corrected data types and handled mixed date formats.
- Identified missing values and invalid records.
- Detected and removed exact duplicate transactions.
- Validated row counts and checked the cleaned data.
- Performed exploratory analysis to understand the dataset.

### Step 3: Customer Analysis Using Python

- Calculated Recency, Frequency, and Monetary value for each customer.
- Assigned RFM scores on a scale of 1 to 5.
- Classified customers into six segments.
- Created a churn flag using a 90-day inactivity threshold.

### Step 4: Power BI Dashboard Development

Built a three-page interactive dashboard.

**Page 1 — Home**
- Project introduction and navigation.
- Glossary of important terms.

**Page 2 — Business Overview**
- KPIs: Total Customers, Total Revenue, Churn Percentage, and Average Customer Value.
- Revenue and customer comparisons by segment.
- Monthly, quarterly, and yearly trends.
- Slicers and bookmark-based toggles.

**Page 3 — RFM Analysis**
- Customer and revenue distribution across segments.
- Average RFM scores and customer value by segment.
- Churn trends and country-level comparisons.
- Conditional formatting for easier interpretation.

## 7. RFM Analysis

RFM stands for Recency, Frequency, and Monetary Value. It is a customer segmentation technique used to understand customer purchasing behaviour.

| Metric | Meaning | Interpretation |
|---|---|---|
| **Recency (R)** | Number of days since the customer's last purchase. | Fewer days generally indicate a more recent purchase and a better Recency score. |
| **Frequency (F)** | Number of distinct purchase transactions during the analysis period. | More transactions generally indicate stronger purchase engagement. |
| **Monetary (M)** | Total revenue generated by a customer during the analysis period. | Higher spending generally indicates greater customer value. |

### RFM Scoring

- Customers receive scores from 1 to 5 for each RFM metric.
- **Recency scoring is reversed:** fewer days since the last purchase receive a higher score.
- Higher Frequency and Monetary values generally receive higher scores.
- The scores are used to classify customers into meaningful segments.

## 8. Customer Segments

| Segment | Meaning |
|---|---|
| **Champions** | Highly valuable customers with strong purchasing behaviour. |
| **Loyal** | Customers showing consistent purchase activity. |
| **At Risk** | Previously valuable customers who may require re-engagement. |
| **New** | Customers with recent purchases but limited purchase history. |
| **Needs Attention** | Customers who may benefit from targeted engagement. |
| **Lost** | Customers with prolonged inactivity. |

## 9. Churn Identification

Churn is identified using a **fixed 90-day inactivity threshold**.

- Calculate the number of days since each customer's last purchase.
- Customers with more than 90 days since their last purchase are flagged as churned.
- This is a rule-based approach, not a machine learning prediction model.

The analysis uses a snapshot date of **10 December 2011**, the day after the dataset's last transaction date of 9 December 2011.

## 10. Key Findings

The following are reported results from the analysis and should be rechecked against the final cleaned dataset and dashboard before quoting them:

- Champions represent approximately 22% of customers and contribute close to 68% of revenue.
- Overall churn is approximately 50.86% under the 90-day inactivity rule.
- Average customer value varies across customer segments.
- Revenue shows seasonal peaks in Q4.

These findings are based on historical transaction data and do not guarantee future customer behaviour.

## 11. Important Metrics

| Metric | Meaning |
|---|---|
| **Total Customers** | Number of distinct customers included in the analysis. |
| **Total Revenue** | Total revenue calculated from the transaction data using the project's cleaning and calculation rules. |
| **Churn %** | Percentage of analysed customers flagged as churned under the 90-day rule. |
| **Average Customer Value** | Average customer-level revenue measure used in the dashboard. Confirm its exact formula before explaining it in an interview. |

## 12. Power BI Concepts Used

- **DAX:** Used to create calculated measures for KPIs and analysis.
- **Slicers:** Allow users to filter dashboard data by fields such as country, date, segment, and churn status.
- **Bookmarks:** Used to switch between selected dashboard views, such as revenue and customer comparisons.
- **Conditional Formatting:** Uses visual formatting to make differences in values easier to identify.
- **Matrix Visual:** Displays customer segments alongside measures such as customer count, revenue, and average RFM scores.
- **Date Hierarchy:** Enables analysis at year, quarter, and month levels.

## 13. Expected Outcome

This project demonstrates an end-to-end data analytics workflow combining SQL-based data preparation, Python-based customer segmentation, and Power BI reporting.

It showcases how raw transactional data can be transformed into customer-level insights that support business analysis and retention decisions.

