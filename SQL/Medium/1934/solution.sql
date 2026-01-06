SELECT 
  s.user_id,
  ROUND(COALESCE(COUNT(*) FILTER (WHERE c.action = 'confirmed')::decimal / NULLIF(COUNT(c.action), 0), 0), 2)
FROM signups s 
LEFT JOIN confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id
