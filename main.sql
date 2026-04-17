-- 1-mashq
WITH ranked_orders AS (
    SELECT 
        buyer_id,
        order_date,
        item_id,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY order_date) AS rn
    FROM orders
)
SELECT 
    u.user_id AS buyer_id,
    u.join_date,
    r.item_id AS favorite_item
FROM users u
LEFT JOIN ranked_orders r ON u.user_id = r.buyer_id AND r.rn = 2;
-- 2-mashq
WITH RECURSIVE hierarchy AS (
    SELECT id, name, manager_id, 0 AS level
    FROM employees
    WHERE id = 1
    UNION ALL
    SELECT e.id, e.name, e.manager_id, h.level + 1
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.id
)
SELECT id, name, manager_id, level
FROM hierarchy
ORDER BY level, id;
