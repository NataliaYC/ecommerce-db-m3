-- Limpiar tablas (Opcional, útil para reinicios)
DELETE FROM Payments;
DELETE FROM Order_Items;
DELETE FROM Orders;
DELETE FROM Inventory;
DELETE FROM Products;
DELETE FROM Customers;
DELETE FROM Categories;

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
(201, 'Natalia', 'Perez', 'natalia.perez@gmail.com', 'hash123'), -- Cliente Frecuente
(202, 'Andres', 'Gomez', 'andres.gomez@gmail.com', 'hash456'),
(203, 'Sofia', 'Rojas', 'sofia.rojas@gmail.com', 'hash789');

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