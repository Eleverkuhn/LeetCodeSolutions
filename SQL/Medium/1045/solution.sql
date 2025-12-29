SELECT customer_id
FROM (
  SELECT customer_id, COUNT(DISTINCT(product_key)) AS count
  FROM customer
  GROUP BY customer_id
)
WHERE count = (SELECT COUNT(*) FROM product);
