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

-- Create products table
CREATE TABLE
	products (
		product_id SERIAL PRIMARY KEY,
		"name" VARCHAR(255) NOT NULL,
		price INT NOT NULL,
		description TEXT
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
		user_id INT NOT NULL,
		product_id INT NOT NULL,
		-- Set relation between users and products
		FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table orders
CREATE TABLE
	orders (
		order_id SERIAL PRIMARY KEY,
		client_id INT UNIQUE NOT NULL,
		total_price INT NOT NULL,
		-- Set relation between orders and clients
		FOREIGN KEY (client_id) REFERENCES clients (client_id) ON DELETE CASCADE
	);

-- Create table order_products
CREATE TABLE
	orders_products (
		order_id INT UNIQUE NOT NULL,
		product_id INT UNIQUE NOT NULL,
		product_price INT NOT NULL,
		quantity INT NOT NULL,
		PRIMARY KEY (order_id, product_id),
		-- Set relation between orders and products
		FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table returns
CREATE TABLE
	"returns" (
		return_id SERIAL PRIMARY KEY,
		order_id INT UNIQUE NOT NULL,
		total_price INT NOT NULL,
		-- Set relation between orders and clients
		FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE
	);

-- Create table return_products
CREATE TABLE
	returns_products (
		return_id INT UNIQUE NOT NULL,
		product_id INT UNIQUE NOT NULL,
		product_price INT NOT NULL,
		quantity INT NOT NULL,
		PRIMARY KEY (return_id, product_id),
		-- Set relation between returns and products
		FOREIGN KEY (return_id) REFERENCES "returns" (return_id) ON DELETE CASCADE,
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);

-- Create table images
CREATE TABLE
	images (
		image_id INT PRIMARY KEY,
		product_id INT NOT NULL,
		url VARCHAR(255) NOT NULL,
		alt VARCHAR(255),
		-- Set relation between images and products
		FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE
	);