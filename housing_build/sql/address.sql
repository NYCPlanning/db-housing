-- populate the address field
-- where street address is not null and house number only contains numbers
UPDATE housing a
SET address = a.address_house||' '||a.address_street
WHERE a.address_street IS NOT NULL
	AND replace(a.address_house, '-', '') ~ '[0-9]';