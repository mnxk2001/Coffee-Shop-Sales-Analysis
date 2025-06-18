-- CREATE DATABASE coffee_shop
-- GO

-- USE coffee_shop
-- GO

-- DROP TABLE order_items
-- GO
-- DROP TABLE orders
-- GO

SELECT *
FROM orders
WHERE transaction_id = 2993

-- Growth Rate Revenue, QTY, Orders by Day
SELECT 
    DAY(transaction_date) AS [Day]
    , SUM(total_bill) AS [Total Revenue]
    , LAG(SUM(total_bill)) OVER (ORDER BY DAY(transaction_date)) AS [Revenue PreDay]
    , (SUM(total_bill) - LAG(SUM(total_bill)) OVER (ORDER BY DAY(transaction_date))) / ABS(LAG(SUM(total_bill)) OVER (ORDER BY DAY(transaction_date))) AS [Revenue Growth Rate Day]
    , SUM(transaction_qty) AS [Total QTY]
    , LAG(SUM(transaction_qty)) OVER (ORDER BY DAY(transaction_date)) AS [QTY PreDay]
    , CAST((SUM(transaction_qty) - LAG(SUM(transaction_qty)) OVER (ORDER BY DAY(transaction_date))) AS FLOAT) / CAST(ABS(LAG(SUM(transaction_qty)) OVER (ORDER BY DAY(transaction_date))) AS FLOAT) AS [QTY Growth Rate Day]
    , COUNT(DISTINCT I.transaction_id) AS [Total Orders]
    , LAG(COUNT(DISTINCT I.transaction_id)) OVER (ORDER BY DAY(transaction_date)) AS [Orders PreDay]
    , CAST((COUNT(DISTINCT I.transaction_id) - LAG(COUNT(DISTINCT I.transaction_id)) OVER (ORDER BY DAY(transaction_date))) AS FLOAT) / CAST(ABS(LAG(COUNT(DISTINCT I.transaction_id)) OVER (ORDER BY DAY(transaction_date))) AS FLOAT) AS [Orders Growth Rate Day]
FROM orders O 
    INNER JOIN order_items I ON O.transaction_id = I.transaction_id
GROUP BY DAY(transaction_date)

;

-- Growth Rate in Week Day
SELECT *
    , (Revenue - Revenue_LD) / ABS(Revenue_LD) AS Revenue_Growth_Rate
    , CAST((Total_QTY - QTY_LD) AS FLOAT) / CAST(ABS(QTY_LD) AS FLOAT) AS QTY_Growth_Rate
    , CAST((Total_Orders - Orders_LD) AS FLOAT) / CAST(ABS(Orders_LD) AS FLOAT) AS Orders_Growth_Rate
FROM 
(
    SELECT
        CASE DATENAME(WEEKDAY, transaction_date)
            WHEN 'Monday' THEN 1
            WHEN 'Tuesday' THEN 2
            WHEN 'Wednesday' THEN 3
            WHEN 'Thursday' THEN 4
            WHEN 'Friday' THEN 5
            WHEN 'Saturday' THEN 6
            ELSE 7
        END AS Day_Num
        , DATENAME(WEEKDAY, transaction_date) AS Day_Name
        , SUM(line_total) AS Revenue
        , LAG(SUM(line_total)) OVER (ORDER BY 
                                        CASE DATENAME(WEEKDAY, transaction_date)
                                            WHEN 'Monday' THEN 1
                                            WHEN 'Tuesday' THEN 2
                                            WHEN 'Wednesday' THEN 3
                                            WHEN 'Thursday' THEN 4
                                            WHEN 'Friday' THEN 5
                                            WHEN 'Saturday' THEN 6
                                            ELSE 7
                                        END) AS Revenue_LD
        , SUM(transaction_qty) AS Total_QTY
        , LAG(SUM(transaction_qty)) OVER (ORDER BY 
                                            CASE DATENAME(WEEKDAY, transaction_date)
                                                WHEN 'Monday' THEN 1
                                                WHEN 'Tuesday' THEN 2
                                                WHEN 'Wednesday' THEN 3
                                                WHEN 'Thursday' THEN 4
                                                WHEN 'Friday' THEN 5
                                                WHEN 'Saturday' THEN 6
                                                ELSE 7
                                            END) AS QTY_LD
        , COUNT(DISTINCT I.transaction_id) AS Total_Orders
        , LAG(COUNT(DISTINCT I.transaction_id)) OVER (ORDER BY 
                                                        CASE DATENAME(WEEKDAY, transaction_date)
                                                            WHEN 'Monday' THEN 1
                                                            WHEN 'Tuesday' THEN 2
                                                            WHEN 'Wednesday' THEN 3
                                                            WHEN 'Thursday' THEN 4
                                                            WHEN 'Friday' THEN 5
                                                            WHEN 'Saturday' THEN 6
                                                            ELSE 7
                                                        END) AS Orders_LD
    FROM orders O 
        INNER JOIN order_items I ON O.transaction_id = I.transaction_id
    GROUP BY 
        CASE DATENAME(WEEKDAY, transaction_date)
            WHEN 'Monday' THEN 1
            WHEN 'Tuesday' THEN 2
            WHEN 'Wednesday' THEN 3
            WHEN 'Thursday' THEN 4
            WHEN 'Friday' THEN 5
            WHEN 'Saturday' THEN 6
            ELSE 7
        END
        , DATENAME(WEEKDAY, transaction_date)
) T


;
-- Tính tỷ lệ tăng trưởng ngày 28 và 29, và tỷ lệ tăng trưởng trung bình của 2 ngày 28 và 29 của các product category 
-- thuộc category type là Finished Products (trừ product category Packaged Chocolate)
WITH
DAY_RATE AS 
(
    SELECT 
        product_category
        , DATEPART(DAY, transaction_date) AS [Day]
        , ROUND(AVG(Growth_Rate), 2) AS AVG_Rate
    FROM 
    (
        SELECT
            product_category
            , transaction_date
            , SUM(transaction_qty) AS Total_QTY
            , LAG(SUM(transaction_qty)) OVER (PARTITION BY product_category ORDER BY transaction_date) AS QTY_LD
            , ROUND((CAST(SUM(transaction_qty) AS FLOAT) - LAG(CAST(SUM(transaction_qty) AS FLOAT)) OVER (PARTITION BY product_category ORDER BY transaction_date)) * 100 / ABS(LAG(CAST(SUM(transaction_qty) AS FLOAT)) OVER (PARTITION BY product_category ORDER BY transaction_date)), 2) AS Growth_Rate
        FROM orders O 
            INNER JOIN order_items I ON O.transaction_id = I.transaction_id
        WHERE category_type = 'Finished Products'
            AND product_category <> 'Packaged Chocolate'
        GROUP BY 
            product_category
            , transaction_date
    ) T
    WHERE DATEPART(DAY, transaction_date) IN (28, 29)
    GROUP BY 
        product_category
        , DATEPART(DAY, transaction_date)
)
SELECT 
    product_category
    , (SELECT AVG_Rate FROM DAY_RATE R1 WHERE R1.product_category = R.product_category AND [Day] = 28) AS DAY_28
    , (SELECT AVG_Rate FROM DAY_RATE R1 WHERE R1.product_category = R.product_category AND [Day] = 29) AS DAY_29
    , AVG(AVG_Rate) AS AVG_2DAYS
FROM DAY_RATE R
GROUP BY product_category


