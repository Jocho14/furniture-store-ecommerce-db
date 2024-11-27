-- Unique partial index to enforce that only one image per product is a thumbnail
CREATE UNIQUE INDEX unique_thumbnail_per_product
ON images (product_id)
WHERE is_thumbnail = TRUE;

CREATE INDEX idx_users_phone_number ON users (phone_number);
CREATE INDEX idx_accounts_email ON accounts (email);
CREATE INDEX idx_addresses_city ON addresses (city);
CREATE INDEX idx_products_name ON products ("name");
CREATE INDEX idx_shipping_addresses_city ON shipping_addresses (city);
CREATE INDEX idx_guests_email ON guests (email);
CREATE INDEX idx_guests_phone_number ON guests (phone_number);
