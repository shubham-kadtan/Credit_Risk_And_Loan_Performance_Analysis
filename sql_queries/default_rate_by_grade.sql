SELECT 
  grade,
  COUNT(*) AS total_loans,
  SUM(CASE WHEN loan_status = 'charged off' THEN 1 ELSE 0 END) AS defaults,
  ROUND(100.0 * SUM(CASE WHEN loan_status = 'charged off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate
FROM loan_data
GROUP BY grade;
