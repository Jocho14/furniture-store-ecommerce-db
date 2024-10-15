-- Unique partial index ti enforce only one image per product is a thumbnail
CREATE UNIQUE INDEX unique_thumbnail_per_product
ON images (product_id)
WHERE is_thumbnail = TRUE;