SELECT
  total_buy.stock_name,
  total_sell.total_sell - total_buy.total_buy AS capital_gain_loss
FROM (
  SELECT stock_name, SUM(price) total_buy
  FROM stocks
  GROUP BY stock_name, operation
  HAVING operation = 'Buy'
) total_buy
LEFT JOIN (
  SELECT stock_name, SUM(price) total_sell
  FROM stocks
  GROUP BY stock_name, operation
  HAVING operation = 'Sell'
) total_sell
ON total_buy.stock_name = total_sell.stock_name;
