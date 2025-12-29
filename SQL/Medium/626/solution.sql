SELECT
  ROW_NUMBER() OVER (ORDER BY id) as id,
  CASE 
    WHEN MOD(id, 2) != 0
      THEN COALESCE(LEAD(student) OVER (ORDER BY id), student)
      ELSE LAG(student) OVER (ORDER BY id)
  END student
FROM seat
