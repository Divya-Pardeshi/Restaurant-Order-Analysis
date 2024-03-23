-- Restaurant Order Analysis
-- Objective: To Analyze order data to identify the most and least popular menu items and types of cuisine.

-- Task 1: Explore the items table
/* Your first objective is to better understand the items table by finding the number of rows in the table, 
the least and most expensive items, and the item prices within each category.*/
USE restaurant_db;

-- 1. View the menu_items table.
SELECT * FROM menu_items;

-- 2. Find the number of items on the menu.
SELECT COUNT(*) FROM menu_items;

-- 3. What are the least and most expensive items on the menu?

-- Least Expensive Items
SELECT * FROM menu_items
ORDER BY price;

-- Most Expensive Items
SELECT * FROM menu_items
ORDER BY price DESC;

-- 4. How many Italian dishes are on the menu?

SELECT COUNT(*) FROM menu_items
WHERE category = 'Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?
-- Least Expensive Italian Dishes
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price;

-- Most Expensive Italian Dishes
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- 6. How many dishes are in each category?

SELECT category, COUNT(menu_item_id) as num_dishes
FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category?

SELECT category, AVG(Price) as avg_price
FROM menu_items
GROUP BY category;

-- Task 2: Explore the orders table
/*Your second objective is to better understand the orders table by finding the date range, 
the number of items within each order, and the orders with the highest number of items.*/
-- 1.View the order_details table.
SELECT * FROM order_details;

-- 2. What is the date range of the table?

SELECT * FROM order_details
ORDER BY order_date;
 
SELECT * FROM order_details
ORDER BY order_date DESC;

-- Alternative Way
SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- 3. How many orders were made within this date range? 
SELECT COUNT(DISTINCT order_id) FROM order_details;

-- 4. How many items were ordered within this date range?
SELECT COUNT(*) FROM order_details;

-- 5. Which orders had the most number of items?
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id 
ORDER BY num_items DESC;

-- 6.How many orders had more than 12 items?

SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id 
HAVING num_items > 12) AS num_orders;

-- Task 3: Analyze customer behavior
/* Your final objective is to combine the items and orders tables, find the least and most ordered categories, 
and dive into the details of the highest spend orders.*/

-- 1. Combine the menu_items and order_details tables into a single table
SELECT * FROM menu_items; -- to view menu_items table
SELECT * FROM order_details; -- to view order_details table

SELECT * FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id

-- 2. What were the least and most ordered items?
-- Least Ordered

SELECT item_name,COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases;

-- Most Ordered
SELECT item_name,COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name
ORDER BY num_purchases DESC;

-- 3. What categories were they in?
-- Least Ordered Categories
SELECT item_name,category, COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases;

-- Most Ordered Categories
SELECT item_name,category, COUNT(order_details_id) AS num_purchases
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases DESC;

-- 4. What were the top 5 orders that spent the most money?

SELECT order_id, SUM(Price) as total_spend
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 5. View the details of the highest spend order. Which specific items were purchased?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- 6. View the details of the top 5 highest spend orders

SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id, category;


