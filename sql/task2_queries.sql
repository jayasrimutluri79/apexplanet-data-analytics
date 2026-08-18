-- ApexPlanet Task 2: SQL for Data Extraction

-- 1. Display first 10 records
SELECT *
FROM superstore
LIMIT 10;


-- 2. Find orders with sales greater than 1000
SELECT
    "Order ID",
    "Customer Name",
    Sales,
    Profit
FROM superstore
WHERE Sales > 1000
ORDER BY Sales DESC;


-- 3. Top 10 orders by sales
SELECT
    "Order ID",
    "Customer Name",
    Sales,
    Profit
FROM superstore
ORDER BY Sales DESC
LIMIT 10;


-- 4. Total sales by category
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- 5. Total profit by category
SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;


-- 6. Categories with sales greater than 100000
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 100000
ORDER BY Total_Sales DESC;


-- 7. Top 5 sub-categories by sales
SELECT
    "Sub-Category",
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY "Sub-Category"
ORDER BY Total_Sales DESC
LIMIT 5;


-- 8. Monthly sales trend
SELECT
    strftime('%Y-%m', "Order Date") AS Month,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Month
ORDER BY Month;


-- 9. Top 10 customers by sales
SELECT
    "Customer Name",
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY "Customer Name"
ORDER BY Total_Sales DESC
LIMIT 10;


-- 10. Sales by region
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- 11. Profit by region
SELECT
    Region,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Region
ORDER BY Total_Profit DESC;


-- 12. Top 10 customers by profit
SELECT
    "Customer Name",
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY "Customer Name"
ORDER BY Total_Profit DESC
LIMIT 10;


-- 13. Highest-selling sub-category
SELECT
    "Sub-Category",
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY "Sub-Category"
ORDER BY Total_Sales DESC
LIMIT 1;


-- 14. Average sales per order
SELECT
    AVG(Order_Sales) AS Average_Order_Sales
FROM (
    SELECT
        "Order ID",
        SUM(Sales) AS Order_Sales
    FROM superstore
    GROUP BY "Order ID"
);


-- 15. Above-average sales orders
SELECT
    "Order ID",
    "Customer Name",
    SUM(Sales) AS Order_Sales
FROM superstore
GROUP BY "Order ID", "Customer Name"
HAVING SUM(Sales) > (
    SELECT AVG(Order_Sales)
    FROM (
        SELECT
            "Order ID",
            SUM(Sales) AS Order_Sales
        FROM superstore
        GROUP BY "Order ID"
    )
)
ORDER BY Order_Sales DESC;


-- 16. Monthly profit trend
SELECT
    strftime('%Y-%m', "Order Date") AS Month,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Month
ORDER BY Month;


-- 17. ROW_NUMBER
SELECT
    "Order ID",
    "Customer Name",
    Sales,
    ROW_NUMBER() OVER (ORDER BY Sales DESC) AS Sales_Row_Number
FROM superstore
ORDER BY Sales DESC
LIMIT 10;


-- 18. RANK customers by sales
WITH customer_sales AS (
    SELECT
        "Customer Name",
        SUM(Sales) AS Total_Sales
    FROM superstore
    GROUP BY "Customer Name"
)
SELECT
    "Customer Name",
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM customer_sales
ORDER BY Sales_Rank
LIMIT 10;


-- 19. LAG monthly sales
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', "Order Date") AS Month,
        SUM(Sales) AS Total_Sales
    FROM superstore
    GROUP BY Month
)
SELECT
    Month,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Month) AS Previous_Month_Sales
FROM monthly_sales
ORDER BY Month;


-- 20. LEAD monthly sales
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', "Order Date") AS Month,
        SUM(Sales) AS Total_Sales
    FROM superstore
    GROUP BY Month
)
SELECT
    Month,
    Total_Sales,
    LEAD(Total_Sales) OVER (ORDER BY Month) AS Next_Month_Sales
FROM monthly_sales
ORDER BY Month;
