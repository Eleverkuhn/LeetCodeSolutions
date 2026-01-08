SELECT COALESCE(p1.product_id, p2.product_id) AS product_id, COALESCE(p1.new_price, 10) AS price
  FROM 
    (
      SELECT product_id, new_price, change_date
        FROM 
          (
            SELECT
              DISTINCT product_id, new_price, change_date, RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) AS rank
            FROM products
            WHERE change_date <= '2019-08-16'
          )
      WHERE rank = 1
    ) p1
FULL JOIN 
  (
    SELECT DISTINCT product_id
    FROM products
    WHERE change_date > '2019-08-16'
  ) p2 
ON p1.product_id = p2.product_id
