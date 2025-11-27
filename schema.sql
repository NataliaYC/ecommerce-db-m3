-- CREACION DE TABLAS--

-- Usamos DECIMAL(10, 2) para manejar precios en CLP (peso chileno)
-- y VARCHAR para campos de texto como nombres y categorías.

-- 1. Tabla: Categories (Licencias)
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 2. Tabla: Customers (Usuarios que compran)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    shipping_address TEXT
);

-- 3. Tabla: Products (Artículos a la venta)
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    category_id INT NOT NULL,
    
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 4. Tabla: Inventory (Stock de productos)
CREATE TABLE Inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 5. Tabla: Orders (Pedidos realizados)
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(50) NOT NULL CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 6. Tabla: Order_Items (Detalle de cada pedido)
CREATE TABLE Order_Items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    
    PRIMARY KEY (order_id, product_id), -- Clave compuesta
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

select * from Categories;
select * from Customers;
select * from Products;
select * from Inventory;
select * from Orders;
select * from Order_Items;

-- Limpiar tablas (Opcional, útil para reinicios)
DELETE FROM Payments;
DELETE FROM Order_Items;
DELETE FROM Orders;
DELETE FROM Inventory;
DELETE FROM Products;
DELETE FROM Customers;
DELETE FROM Categories;


--INSERTAR SEED--

-- 1. Insertar CATEGORIES
INSERT INTO Categories (category_id, name, description) VALUES
(1, 'Disney', 'Productos de licencias Disney.'),
(2, 'Marvel', 'Productos basados en superhéroes de Marvel.'),
(3, 'Equipos', 'Productos relacionados con equipos deportivos (Fútbol Chileno).'),
(4, 'Otros', 'Artículos licenciados varios.');

-- 2. Insertar PRODUCTS
INSERT INTO Products (product_id, name, description, price, category_id) VALUES
(1001, 'Mug 40 Oz Stitch', 'Mug térmico 40 oz, licencia Stitch original.', 20990.00, 1),
(1002, 'Mug Botón Iron Man', 'Mug boton Marvel para bebidas frías, 380 ml.', 7000.00, 2),
(1003, 'Mug Fanatikos U. de Chile', 'Mug 350 ml aprox. de la U. de Chile.', 7990.00, 3),
(1004, 'Mug Fanatikos Colo-Colo', 'Mug 350 ml aprox. de Colo-Colo.', 7990.00, 3),
(1005, 'Taza Minnie Glitter', 'Taza de cerámica con glitter, licencia Minnie.', 12500.00, 1),
(1006, 'Llavero Thanos Guante', 'Llavero metálico, licencia Marvel.', 4500.00, 2);

-- 3. Insertar INVENTORY
INSERT INTO Inventory (product_id, stock_quantity) VALUES
(1001, 50),
(1002, 5),    -- Stock bajo
(1003, 30),
(1004, 0),    -- Producto sin stock
(1005, 15),
(1006, 100);

-- 4. Insertar CUSTOMERS
INSERT INTO Customers (customer_id, first_name, last_name, email, password_hash) VALUES
(201, 'Natalia', 'Perez', 'natalia.perez@example.com', 'hash123'), -- Cliente Frecuente
(202, 'Andres', 'Gomez', 'andres.gomez@example.com', 'hash456'),
(203, 'Sofia', 'Rojas', 'sofia.rojas@example.com', 'hash789');

-- 5. Insertar ORDERS (Fechas para simular Ventas por Mes)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(3001, 201, '2025-10-15 10:00:00', 35490.00, 'Delivered'), -- Octubre, Natalia
(3002, 202, '2025-11-05 14:30:00', 7000.00, 'Delivered'), -- Noviembre, Andres
(3003, 201, '2025-11-10 11:00:00', 12500.00, 'Delivered'), -- Noviembre, Natalia
(3004, 203, '2025-11-25 18:00:00', 7990.00, 'Pending'), -- Noviembre, Pendiente
(3005, 201, '2025-09-01 09:00:00', 4500.00, 'Delivered'); -- Septiembre, Natalia (3 órdenes)

-- 6. Insertar ORDER_ITEMS
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
-- Orden 3001 (Octubre): Mug Stitch (1) + Taza Minnie (1)
(3001, 1001, 1, 20990.00),
(3001, 1005, 1, 14500.00), -- Precio diferente al actual
-- Orden 3002 (Noviembre): Mug Iron Man (1)
(3002, 1002, 1, 7000.00),
-- Orden 3003 (Noviembre): Taza Minnie (1)
(3003, 1005, 1, 12500.00),
-- Orden 3004 (Noviembre): Mug U. Chile (1)
(3004, 1003, 1, 7990.00),
-- Orden 3005 (Septiembre): Llavero Thanos (1)
(3005, 1006, 1, 4500.00);

-- 7. Insertar PAYMENTS
INSERT INTO Payments (payment_id, order_id, amount, method, status) VALUES
(4001, 3001, 35490.00, 'Credit Card', 'Completed'),
(4002, 3002, 7000.00, 'Debit Card', 'Completed'),
(4003, 3003, 12500.00, 'Credit Card', 'Completed');
-- La orden 3004 y 3005 no tienen registro de pago (Status Pending/Delivered sin pago)


--QUERIES CONTULTAS--

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
    TO_CHAR(o.order_date, 'YYYY-MM') AS sales_month, 
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



-- TRANSACCIÓN: CREAR ORDEN Y DESCONTAR STOCK --
-- Sustitución de valores fijos: Order ID 3007, Cliente 202

BEGIN; 

--ROLLback--
ROLLBACK;

-- 1. Crear la Orden (ID fijo: 3007)
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status)
VALUES (3007, 202, CURRENT_TIMESTAMP, 0.00, 'Processing');

-- 2. Insertar los ítems de la Orden
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(3007, 1001, 2, 20990.00), -- Item 1: Mug Stitch (2 unidades)
(3007, 1002, 4, 7000.00);  -- Item 2: Mug Iron Man (4 unidades)

-- 3. Descontar Existencias del Inventario para ITEM 1 (1001)
UPDATE Inventory
SET 
    stock_quantity = stock_quantity - 2,
    last_updated = NOW()
WHERE
    product_id = 1001;

-- 4. Descontar Existencias del Inventario para ITEM 2 (1002)
UPDATE Inventory
SET 
    stock_quantity = stock_quantity - 4,
    last_updated = NOW()
WHERE
    product_id = 1002;

-- 5. Recalcular y Actualizar el Total FINAL de la Orden
-- Esta subconsulta suma (2 * 20990) + (4 * 7000) = 69980.00
UPDATE Orders
SET 
    total_amount = sub.calculated_total
FROM (
    SELECT SUM(quantity * unit_price) AS calculated_total
    FROM Order_Items
    WHERE order_id = 3007
) AS sub
WHERE
    Orders.order_id = 3007;

-- 6. CONFIRMAR si todos los pasos anteriores fueron exitosos
COMMIT;