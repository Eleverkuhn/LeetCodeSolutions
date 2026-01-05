SELECT id, num
FROM 
  (
    SELECT id, num, DENSE_RANK() OVER (ORDER BY num DESC) AS rank_col
    FROM 
      (
        SELECT req1.requester_id AS id, COALESCE(req1.friends + req2.friends, 0) AS num
          FROM (SELECT requester_id, COUNT(*) AS friends FROM requestaccepted GROUP BY requester_id) req1
        LEFT JOIN  (SELECT accepter_id, COUNT(*) AS friends FROM requestaccepted GROUP BY accepter_id) req2
        ON req1.requester_id = req2.accepter_id
      )
  )
WHERE rank_col = 1;

SELECT requester_id, COUNT(*) AS friends FROM requestaccepted GROUP BY requester_id;
SELECT accepter_id, COUNT(*) AS friends FROM requestaccepted GROUP BY accepter_id;

SELECT req1.accepter_id AS id, req1.friends + req2.friends AS num
  FROM (SELECT accepter_id, COUNT(*) AS friends FROM requestaccepted GROUP BY accepter_id) req1
JOIN (SELECT requester_id, COUNT(*) AS friends FROM requestaccepted GROUP BY requester_id) req2
ON req1.accepter_id = req2.requester_id;

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
