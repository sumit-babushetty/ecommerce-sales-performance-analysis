-- ================================================
-- E-Commerce Sales Performance Analysis
-- Author: Sumit Babushetty
-- Tool: MySQL
-- ================================================

-- Query 1: Monthly Revenue Trend
-- Query 2: Top 10 Product Categories
-- Query 3: Average Delivery Time by State
-- Query 4: Late Delivery Impact on Review Score
-- Query 5: Seller Performance Ranking
-- Query 6: Monthly Revenue Growth %
-- Query 7: Customer Repeat Purchase Rate
-- Query 8: Revenue by Payment Method
-- ================================================

-- Business Questions Answered:
-- 1. What is the monthly revenue trend?
-- 2. Which are top 10 product categories by revenue?
-- 3. Which states have slowest delivery times?
-- 4. How does late delivery impact customer ratings?
-- 5. Who are the top 10 sellers by revenue?
-- 6. What is the monthly revenue growth %?
-- 7. What is the customer repeat purchase rate?
-- 8. Which payment method is most preferred?



-- Query 1 

USE ecommerce_analysis;

SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS months,
ROUND(SUM(price), 2) as total_revenue 
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY months
ORDER BY months;


-- Query 2
-- Which are the top 10 product categories by revenue?

SELECT 
    p.product_category_name AS portuguese,
    ct.product_category_name_english AS english,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct 
    ON p.product_category_name = ct.product_category_name
GROUP BY p.product_category_name, ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;


-- Query 3 — Average Delivery Time by State:

SELECT c.customer_state,
ROUND(AVG(DATEDIFF(O.order_delivered_customer_date , O.order_purchase_timestamp)), 1)
AS avg_delivery_days,
COUNT(o.order_id) AS total_orders
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL 
AND o.order_delivered_customer_date != ''
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;


-- Query 4 — Late Delivery Impact on Review Score

SELECT 
	CASE 
		WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'Late'
        ELSE'On Time'
        END AS delivery_status,
	ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(o.order_id) AS total_orders
FROM orders o 
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
AND o.order_delivered_customer_date != ''
GROUP BY delivery_status
ORDER BY avg_review_score DESC;


-- "Late deliveries caused a 1.72 star drop in customer ratings (4.29 → 2.57), 
-- affecting 7,701 orders — proving that delivery speed is the single biggest driver of 
-- customer satisfaction"



-- Query 5 — Seller Performance Ranking
-- Who are the top 10 sellers by revenue?"

SELECT oi.seller_id,
ROUND(SUM(oi.price), 2) AS total_sales,
COUNT(DISTINCT oi.order_id) AS total_orders,
RANK() OVER (ORDER BY SUM(oi.price) DESC) AS seller_rank
FROM order_items oi 
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.seller_id
ORDER BY total_sales DESC
LIMIT 10;



-- MONTHLY PERFORMANCE GROWTH % 

WITH monthly_revenue AS(
SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS months,
ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY months
)
SELECT 
	months,
    revenue,
    LAG(revenue) OVER (ORDER BY months) AS prev_month_revenue,
ROUND((revenue - LAG(revenue) OVER (ORDER BY months)) / 
	LAG(revenue) OVER (ORDER BY months) * 100, 1) AS growth_pct
    FROM monthly_revenue
    ORDER BY months;




-- Query 7 — Customer Repeat Purchase Rate
-- "How many customers bought more than once?"

SELECT 
COUNT(CASE WHEN order_count > 1 THEN 1 END ) AS repeat_customers,
COUNT(*) AS total_customers,
ROUND(COUNT(CASE WHEN order_count > 1 THEN 1 END ) * 100.0 / COUNT(*), 2) AS repeat_rate_pct
FROM(
SELECT c.customer_unique_id,
COUNT(o.order_id) AS order_count
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_unique_id)t;


-- Query 8 - "Which payment method do customers prefer most?"

SELECT payment_type,
ROUND(SUM(payment_value), 2) AS total_revenue,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(COUNT(DISTINCT order_id) * 100.0 / 
    (SELECT COUNT(DISTINCT order_id) FROM order_payments)
, 1) AS percentage
FROM order_payments
GROUP BY payment_type
ORDER BY total_revenue DESC;