-- populate the status_a_year and status_q_year fields
UPDATE housing
SET status_a_year = RIGHT(status_a, 4)
WHERE status_a IS NOT NULL;
UPDATE housing
SET status_q_year = LEFT(status_q, 4)
WHERE status_q IS NOT NULL AND status_q LIKE '%-%';
UPDATE housing
SET status_q_year = RIGHT(status_q, 4)
WHERE status_q IS NOT NULL AND status_q LIKE '%/%';