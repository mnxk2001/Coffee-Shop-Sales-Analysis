# COFFEE SHOP SALES ANALYSIS
- This project is similar to the [**Sales Report Analysis**](https://github.com/mnxk2001/Sales-Report-Analysis) I previously completed. In this project, I analyze the business performance of a coffee shop over time and identify top-performing product groups. 
- The dataset covers the first six months of 2023, from **January 1, 2023** to **June 30, 2023**.
- The dataset was sourced from Kaggle via [**this link**](https://www.kaggle.com/datasets/divu2001/coffee-shop-sales-analysis)

## Insight Highlights
- Sales typically drop on the 28th and 29th, and some products record zero revenue on these days.
- Coffee and Bakery items are often bought together.
- Packaged Chocolate may be an add-on or complementary product.
- Ouro Brasileiro Shot and Ginger Scone are the most frequently bought together.

## Data Processing
- Checked data quality.
- Reclassified product categories into four main groups:
    - **Ingredients**: Loose Tea, Coffee beans
    - **Finished Products**: Coffee, Tea, Drinking Chocolate, Packaged Chocolate, Bakery
    - **Complementary Products**: Flavours
    - **Branded**: All remaining categories
- Adjusted the size for the following product IDs:
    - Product IDs **40, 37, and 87** were changed to **Regular**
    - Product ID **38** was changed to **Large**
- Identified commonly co-purchased products.

## Project Components
- See the report content in [**Report.pdf**](/Report.pdf)
- [**Draft.pbix**](/Draft.pbix) contains custom visualizations used for analysis and included as images in the report.
- Data processing steps are documented in [**Coffee_Shop_Sales_Process.ipynb**](/Coffee_Shop_Sales_Process.ipynb) and [**Coffee_shop_process.sql**](/Coffee_shop_process.sql)

## Contact
Please feel free to contact me at [kieumnx@gmail.com](mailto:kieumnx@gmail.com) if you have any questions.