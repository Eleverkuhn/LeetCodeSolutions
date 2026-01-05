SELECT * FROM customer_transactions;

SELECT customer_id, COUNT(transaction_id) as customer_transactions
FROM customer_transactions
GROUP BY customer_id
HAVING COUNT(transaction_id) >= 3;

SELECT customer_id, MAX(transaction_date) - MIN(transaction_date) AS activity
FROM customer_transactions
GROUP BY customer_id;

SELECT
  customer_id,
  (COUNT(transaction_type) FILTER (WHERE transaction_type = 'refund') * 1.0 / COUNT(transaction_type)) * 100 AS refund_rate
FROM customer_transactions
GROUP BY customer_id;

SELECT customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING COUNT(transaction_id) >= 3
    AND MAX(transaction_date) - MIN(transaction_date) >= 30
    AND (COUNT(transaction_type) FILTER (WHERE transaction_type = 'refund') * 1.0 / COUNT(transaction_type)) * 100 < 20
ORDER BY customer_id ASC
