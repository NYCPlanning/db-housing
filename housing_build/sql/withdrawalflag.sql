-- set the x_withdrawal flag to binary values based on the attribute value
UPDATE housing
SET x_withdrawal = TRUE
WHERE x_withdrawal = 'W' OR x_withdrawal = 'C';
UPDATE housing
SET x_withdrawal = FALSE
WHERE x_withdrawal <> 'TRUE';