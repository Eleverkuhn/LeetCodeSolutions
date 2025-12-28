SELECT
  useractivity.user_id,
  ROUND(AVG(trial_activity.activity_duration), 2) trial_avg_duration,
  ROUND(AVG(useractivity.activity_duration), 2) paid_avg_duration
FROM useractivity
LEFT JOIN
  (
    SELECT user_id, activity_duration
    FROM useractivity
    WHERE activity_type = 'free_trial'
  ) trial_activity
ON useractivity.user_id = trial_activity.user_id
GROUP BY useractivity.user_id, useractivity.activity_type
HAVING useractivity.activity_type = 'paid';
