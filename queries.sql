-- busqueda de producto Por nombre--
SELECT product_id, name, price FROM Products
WHERE name LIKE '%Mug%';

-- busqueda de producto Por categoría--
SELECT p.name AS product_name, p.price, c.name AS category_name
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
WHERE c.name = 'Disney';

--top 2 productos por venta cantidad por categoria--
SELECT
    p.name AS product_name,
    SUM(oi.quantity) AS total_units_sold
FROM
    Order_Items oi
JOIN
    Products p ON oi.product_id = p.product_id
GROUP BY
    p.name
ORDER BY
    total_units_sold DESC
LIMIT 2;

--ventas monto total por mes y por categoria solo de pedidos entregados--
SELECT
    STRFTIME('%Y-%m', o.order_date) AS sales_month, --TO_CHAR --
    c.name AS category_name,
    SUM(o.total_amount) AS monthly_category_revenue
FROM
    Orders o
JOIN
    Order_Items oi ON o.order_id = oi.order_id
JOIN
    Products p ON oi.product_id = p.product_id
JOIN
    Categories c ON p.category_id = c.category_id
WHERE
    o.status = 'Delivered'
GROUP BY
    sales_month, category_name
ORDER BY
    sales_month DESC, monthly_category_revenue DESC;

--rango de Noviembre 2025 (KPI: Valor Promedio del Pedido)--
SELECT
    AVG(total_amount) AS average_ticket_clp
FROM
    Orders
WHERE
    order_date >= '2025-11-01' AND order_date < '2025-12-01'
    AND status = 'Delivered';

--Productos con stock bajo--
SELECT
    p.name AS product_name,
    i.stock_quantity
FROM
    Products p
JOIN
    Inventory i ON p.product_id = i.product_id
WHERE
    i.stock_quantity < 10
    AND i.stock_quantity > 0 -- Excluye productos agotados si es necesario
ORDER BY
    i.stock_quantity ASC;

--Clientes Frecuentes (Clientes con ≥ 3 órdenes)--
SELECT
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM
    Customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(o.order_id) >= 3;


