SELECT id, num
FROM 
  (
    SELECT id, SUM(num) AS num, DENSE_RANK() OVER (ORDER BY SUM(num) DESC) as rank
      FROM
        (
          SELECT requester_id AS id, COUNT(*) AS num FROM requestaccepted GROUP BY requester_id
          UNION ALL
          SELECT accepter_id AS id, COUNT(*) AS num FROM requestaccepted GROUP BY accepter_id
        )
      GROUP BY id
  )
WHERE rank = 1;
