-- Create users table
CREATE TABLE
	users (
		user_id SERIAL PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		phone_number VARCHAR(15) UNIQUE NOT NULL,
		date_of_birth DATE NOT NULL
	);

-- Create addresses table
CREATE TABLE
	addresses (
		address_id SERIAL PRIMARY KEY,
		street_address VARCHAR(120) NOT NULL,
		house_number VARCHAR(10) NOT NULL,
		apartment_number VARCHAR(10),
		city VARCHAR(120) NOT NULL,
		postal_code VARCHAR(20) NOT NULL
	);

-- Create users_addresses table
CREATE TABLE
	users_addresses (
		user_id INT NOT NULL,
		address_id INT NOT NULL,
		PRIMARY KEY (user_id, address_id),
		-- Set relation between users and addresses
		FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
		FOREIGN KEY (address_id) REFERENCES addresses (address_id) ON DELETE CASCADE
	);

-- Create accounts table
CREATE TABLE
	accounts (
		account_id SERIAL PRIMARY KEY,
		user_id INT UNIQUE NOT NULL,
		email VARCHAR(255) UNIQUE NOT NULL,
		password_hash VARCHAR(255) NOT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		ACTIVE BOOL DEFAULT TRUE NOT NULL,
		-- Set relation between users and accounts
		FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
	);

-- Create clients table
CREATE TABLE
	clients (
		client_id SERIAL PRIMARY KEY,
		user_id INT UNIQUE NOT NULL,
		-- Set relation between clients and users
		FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
	);

-- Create employees table
CREATE TABLE
	employees (
		employee_id SERIAL PRIMARY KEY,
		user_id INT UNIQUE NOT NULL,
		-- Set relation between employees and users
		FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
	);

-- Create products table
CREATE TABLE
	products (
		product_id SERIAL PRIMARY KEY,
		"name" VARCHAR(255) NOT NULL,
		price NUMERIC(10,2) NOT NULL,
		description TEXT,
		is_active BOOL DEFAULT TRUE NOT NULL
	);

-- Create clients_favourites_products table
CREATE TABLE
	clients_favourites_products (
		client_id INT NOT NULL,
		product_id INT NOT NULL,
		PRIMARY KEY (client_id, product_id),
		-- Set relation between clients and products
		FOREIGN KEY (client_id) REFERENCES clients (client_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create reviews table
CREATE TABLE
	reviews (
		review_id SERIAL PRIMARY KEY,
		client_id INT NOT NULL,
		product_id INT NOT NULL,
		rating INT NOT NULL,
		comment TEXT,
		review_date DATE DEFAULT CURRENT_DATE,
		-- Set relation between users and products
		FOREIGN KEY (client_id) REFERENCES clients (client_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table images
CREATE TABLE
	images (
		image_id SERIAL PRIMARY KEY,
		product_id INT NOT NULL,
		url VARCHAR(255) NOT NULL,
		alt VARCHAR(255) NOT NULL,
		is_thumbnail BOOL DEFAULT FALSE NOT NULL,
		-- Set relation between images and products
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table categories
CREATE TABLE
	categories (
		category_id SERIAL PRIMARY KEY,
		name VARCHAR(255) NOT NULL
	);

-- Create table products_categories
CREATE TABLE products_categories (
	product_id INT NOT NULL,
	category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
	-- Set relation between products and categories
	FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- Create table warehouses
CREATE TABLE
	warehouses (
		warehouse_id SERIAL PRIMARY KEY,
		name VARCHAR(255) NOT NULL,
		location VARCHAR(255)
	);

-- Create table warehouse_products
CREATE TABLE
	products_warehouses (
		warehouse_id INT NOT NULL,
		product_id INT NOT NULL,
		quantity INT NOT NULL,
		last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		PRIMARY KEY (warehouse_id, product_id),
		-- Set relation between warehouses and products
		FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table guests
CREATE TABLE
	guests (
		guest_id SERIAL PRIMARY KEY,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		phone_number VARCHAR(15) NOT NULL,
		email VARCHAR(255) NOT NULL
	);

-- Create table shipping_addresses
CREATE TABLE
	shipping_addresses (
		shipping_address_id SERIAL PRIMARY KEY,
		street_address VARCHAR(120) NOT NULL,
		house_number VARCHAR(10) NOT NULL,
		apartment_number VARCHAR(10),
		city VARCHAR(120) NOT NULL,
		postal_code VARCHAR(20) NOT NULL
	);

-- Create enum for order status
CREATE TYPE order_status AS ENUM ('pending', 'completed', 'canceled');

-- Create table orders
CREATE TABLE
	orders (
		order_id SERIAL PRIMARY KEY,
		client_id INT,
		guest_id INT,
		shipping_address_id INT NOT NULL,
		total_amount NUMERIC(10,2) NOT NULL,
		order_date DATE DEFAULT CURRENT_DATE,
		status order_status DEFAULT 'pending' NOT NULL,
		-- Set relation between orders and clients, guests, and shipping_addresses
		FOREIGN KEY (client_id) REFERENCES clients (client_id) ON DELETE SET NULL,
		FOREIGN KEY (guest_id) REFERENCES guests (guest_id) ON DELETE SET NULL,
		FOREIGN KEY (shipping_address_id) REFERENCES shipping_addresses (shipping_address_id) ON DELETE CASCADE
	);

-- Create table order_products
CREATE TABLE
	orders_products (
		order_id INT NOT NULL,
		product_id INT NOT NULL,
		product_price NUMERIC(10,2) NOT NULL,
		quantity INT NOT NULL,
		PRIMARY KEY (order_id, product_id),
		-- Set relation between orders and products
		FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);