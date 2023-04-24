CREATE TABLE customer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    order_status ENUM('Created', 'Cancelled','Approved','Shipped') DEFAULT 'Created'
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2)
);

CREATE TABLE order_line (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE company (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    contact_number VARCHAR(20)
);

CREATE TABLE store_or_warehouse (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    address_line_1 VARCHAR(255) NOT NULL,
    address_line_2 VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    contact_number VARCHAR(20)
);

CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    --company_id INT,
    store_or_warehouse_id INT,
    quantity INT,
    --price DECIMAL(10, 2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id),
    --FOREIGN KEY (company_id) REFERENCES company(id),
    FOREIGN KEY (store_or_warehouse_id) REFERENCES store_or_warehouse(id)
);

CREATE TABLE restock_order (
    id INT PRIMARY KEY AUTO_INCREMENT,
    store_or_warehouse_id INT,
    order_date DATE,
    FOREIGN KEY (store_or_warehouse_id) REFERENCES store_or_warehouse(id)
);


CREATE TABLE restock_lines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    restock_order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (restock_order_id) REFERENCES restock_order(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE shipment (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  shipment_number VARCHAR(255),
  shipper_name VARCHAR(255),
  consignee_name VARCHAR(255),
  shipment_date DATE,
  expected_delivery_date DATE,
  actual_delivery_date DATE,
  shipment_status ENUM('Created', 'Cancelled','Approved','Shipped') DEFAULT 'Created',
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE invoice (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_number VARCHAR(255),
  order_id INT,
  invoice_date DATE,
  total_amount DECIMAL(10,2),
  CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE invoice_lines (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT,
  product_name VARCHAR(255),
  quantity INT,
  price DECIMAL(10,2),
  CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoice(id)
);
 


