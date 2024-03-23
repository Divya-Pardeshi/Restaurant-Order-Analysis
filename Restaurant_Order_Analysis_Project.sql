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