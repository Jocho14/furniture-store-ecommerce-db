ALTER SEQUENCE products_product_id_seq RESTART;
UPDATE products SET product_id = DEFAULT;