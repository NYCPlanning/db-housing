UPDATE housing a
SET units_prop = NULL 
WHERE a.units_prop ~ '[^0-9]';