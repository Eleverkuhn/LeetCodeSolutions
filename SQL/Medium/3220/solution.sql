SELECT
  ta.transaction_date,
  COALESCE(os.odd_sum, 0) AS odd_sum,
  COALESCE(es.even_sum, 0) AS even_sum
FROM transactions ta
LEFT JOIN 
  (
    SELECT transaction_date, SUM(amount) AS even_sum
    FROM transactions
    WHERE MOD(amount, 2) = 0
    GROUP BY transaction_date
  ) es
ON ta.transaction_date = es.transaction_date
LEFT JOIN
  (
    SELECT transaction_date, SUM(amount) AS odd_sum
    FROM transactions
    WHERE MOD(amount, 2) != 0
    GROUP BY transaction_date
  ) os
ON ta.transaction_date = os.transaction_date
GROUP BY ta.transaction_date, os.odd_sum, es.even_sum
ORDER BY ta.transaction_date;
