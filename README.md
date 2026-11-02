# Coffee Shop Sales Analysis
### Retail & F&B | Sales Performance, Product Analysis, and Cross-Selling Opportunities

## Table of Contents
- [Project Overview](#project-overview)
- [Business Questions](#business-questions)
- [Dataset](#dataset)
- [Tools and Technologies](#tools-and-technologies)
- [Data Preparation and Analysis](#data-preparation-and-analysis)
- [Key Findings](#key-findings)
- [Project Files](#project-files)
- [Contact](#contact)

## Project Overview

This project analyzes a coffee shop's sales performance over the first six months of 2023. The analysis focuses on sales trends, product performance, and purchasing patterns to identify potential opportunities for improving sales and cross-selling complementary products.

This project builds on a previous [Sales Report Analysis](https://github.com/mnxk2001/Sales-Report-Analysis), with a more specific focus on retail and coffee shop transactions.

## Business Questions

1. How does sales performance change over the analysis period?
2. Are there recurring dates when sales or product revenue declines?
3. Which product categories are commonly purchased together?
4. Which product combinations could present cross-selling or add-on opportunities?

## Dataset

- **Period:** January 1, 2023 – June 30, 2023
- **Source:** [Coffee Shop Sales Analysis – Kaggle](https://www.kaggle.com/datasets/divu2001/coffee-shop-sales-analysis)

## Tools and Technologies

- **SQL:** Data processing and analysis
- **Python (Pandas):** Data quality checks, transformation, and product-pair analysis
- **Power BI:** Data visualization and reporting

## Data Preparation and Analysis

The analysis included the following preparation and processing steps:

### 1. Data Quality Checks
- Reviewed the dataset for data quality issues before analysis.

### 2. Product Category Reclassification

Reclassified the original product categories into four broader groups:

- **Ingredients:** Loose Tea, Coffee beans
- **Finished Products:** Coffee, Tea, Drinking Chocolate, Packaged Chocolate, Bakery
- **Complementary Products:** Flavours
- **Branded:** All remaining categories

### 3. Product Size Corrections

Updated the size values for selected product IDs:

- Product IDs **40, 37, and 87** → **Regular**
- Product ID **38** → **Large**

### 4. Product-Pair Analysis

Identified products that were frequently purchased together to explore potential cross-selling opportunities.

## Key Findings

| Finding | Evidence from the Analysis | Business Implication |
|---|---|---|
| Sales decline near the end of the month | Sales typically drop on the **28th and 29th**; some products record zero revenue on these dates. | Review daily sales and transaction records around these dates to understand whether the pattern reflects demand changes, availability, or data issues. |
| Coffee and Bakery products are commonly purchased together | Coffee and Bakery items frequently appear in the same purchasing patterns. | Consider testing cross-category promotions or product bundles. |
| Packaged Chocolate may be a complementary purchase | Packaged Chocolate appears as a potential add-on product. | Explore its suitability for add-on recommendations at the point of sale. |
| A specific product pair is frequently purchased together | **Ouro Brasileiro Shot** and **Ginger Scone** are the most frequently bought-together pair identified. | Consider testing a targeted bundle or recommendation for this combination. |

## Project Files

| File | Description |
|---|---|
| [Report.pdf](./Report.pdf) | Report containing the analysis and findings. |
| [Draft.pbix](./Draft.pbix) | Power BI file containing custom visualizations used in the analysis and included in the report. |
| [Coffee_Shop_Sales_Process.ipynb](./Coffee_Shop_Sales_Process.ipynb) | Google Colab documenting Python data processing steps. |
| [Coffee_shop_process.sql](./Coffee_shop_process.sql) | SQL script documenting data processing steps. |

## Contact

For questions or feedback, feel free to contact me at [kieumnx@gmail.com](mailto:kieumnx@gmail.com).
