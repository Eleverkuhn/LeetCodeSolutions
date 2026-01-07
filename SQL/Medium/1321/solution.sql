SELECT r.visited_on, SUM(c.amount) AS amount, ROUND(AVG(c.amount), 2) AS average_amount
  FROM
    (
      SELECT visited_on, SUM(amount) AS amount
      FROM customer
      GROUP BY visited_on
    ) c
JOIN 
  (
    SELECT visited_on, range
      FROM
        (
          SELECT 
              visited_on,
              LAG(visited_on, 6) OVER (ORDER BY visited_on) AS range
            FROM (SELECT DISTINCT visited_on FROM customer)
        )
    WHERE range IS NOT NULL
  ) r 
  ON c.visited_on BETWEEN r.range AND r.visited_on
GROUP BY r.visited_on;
