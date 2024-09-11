-- Create users table
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(15) UNIQUE NOT NULL,
	date_of_birth DATE NOT NULL
);

-- Create addresses table
CREATE TABLE addresses (
	address_id SERIAL PRIMARY KEY,
	street_address VARCHAR(120) NOT NULL,
	house_number VARCHAR(10) NOT NULL,
	apartment_number VARCHAR(10),
	city VARCHAR(120) NOT NULL,
	postal_code VARCHAR(20) NOT NULL
);

-- Create users_addresses table
CREATE TABLE users_addresses (
	user_id INT NOT NULL,
	address_id INT NOT NULL,
	PRIMARY KEY (user_id, address_id),
	
-- Set relation between users and addresses
	FOREIGN KEY (user_id) 
		REFERENCES users(user_id) 
		ON DELETE CASCADE,
	FOREIGN KEY (address_id)
		REFERENCES addresses(address_id)
		ON DELETE CASCADE
);

-- Create accounts table
CREATE TABLE accounts (
	account_id SERIAL PRIMARY KEY,
	user_id INT UNIQUE NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	ACTIVE BIT DEFAULT 1 NOT NULL,
	
-- Set relation between users and accounts
	FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE
);

-- Create products table
CREATE TABLE products (
	product_id SERIAL PRIMARY KEY
);

-- Create accounts_favourites_products table
CREATE TABLE accounts_favourites_products (
	account_id INT NOT NULL,
	product_id INT NOT NULL,
	PRIMARY KEY(account_id, product_id),
	
-- Set relation between accounts and products
	FOREIGN KEY (account_id)
		REFERENCES accounts(account_id)
		ON DELETE CASCADE,
	FOREIGN KEY (product_id)
		REFERENCES products(product_id)
		ON DELETE CASCADE
);

-- Create reviews table
CREATE TABLE reviews (
	review_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL,
	product_id INT NOT NULL,
	
-- Set relation between users and products
	FOREIGN KEY (user_id)
		REFERENCES users(user_id)
		ON DELETE CASCADE,
	FOREIGN KEY (product_id)
		REFERENCES products(product_id)
		ON DELETE CASCADE
);
