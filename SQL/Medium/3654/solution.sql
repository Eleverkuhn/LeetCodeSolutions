SELECT season, category, total_quantity, total_revenue
FROM
  (
    SELECT
      RANK() OVER (PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS rank,
      season, category, total_quantity, total_revenue
    FROM 
      (
        SELECT 
          CASE
            WHEN EXTRACT(MONTH FROM sale_date) IN (1, 2, 12) THEN 'Winter'
            WHEN EXTRACT(MONTH FROM sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM sale_date) IN (9, 10, 11) THEN 'Fall'
          END AS season,
          p.category, SUM(s.quantity) AS total_quantity, SUM(s.quantity * s.price) AS total_revenue
        FROM sales s
        JOIN products p 
        ON s.product_id = p.product_id
        GROUP BY p.category, season
      )
  )
WHERE rank = 1;
