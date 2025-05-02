-- Basic SQL
SELECT *
  FROM orders;

SELECT id, account_id, occured_at
  FROM orders;

SELECT *
  FROM orders
  LIMIT 10;

SELECT occured_at, account_id, channel
  FROM web_events
  LIMIT 15;

SELECT *
  FROM orders
  ORDER BY occured_at
  LIMIT 15;
-- ascending by default, add DESC for descending 

SELECT id, occured_at, total_amt_usd
  FROM orders
  ORDER BY occured_at
  LIMIT 10;

SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd DESC
  LIMIT 5;

SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd
  LIMIT 20;

SELECT account_id, total_amt_usd
  FROM orders
  ORDER BY account_id, total_amt_usd DESC;
-- first ordered by account_id then by total_amt_usd from highest to lowest

SELECT account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd DESC, account_id;
-- sorted by highest to lowest total_amt_usd then lowest to highest account_id

SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
  FROM orders
  ORDER BY total_amt_usd DESC, account_id;

SELECT *
  FROM orders
  WHERE account_id = 4251
  ORDER BY occured_at
  LIMIT 1000;
-- Common symbols used in WHERE statements include: > (greater than), < (less than), >= (greater than or equal to), <= (less than or equal to), = (equal to), != (not equal to)

SELECT * 
  FROM orders
  WHERE gloss_amt_usd >= 1000
  LIMIT 5;

SELECT * 
  FROM orders
  WHERE total_amt_usd < 500
  LIMIT 10;

SELECT *
  FROM accounts
  WHERE name = 'United Technologies';
-- use single quotes for text

SELECT name, website, primary_poc
  FROM accounts
  WHERE name = 'Exxon Mobil';

SELECT account_id, occured_at, standard_qty, gloss_qty, poster_qty, gloss_qty + poster_qty AS nonstandard_qty
  FROM orders;
-- derived column (creating a new column that is a combination of exisiting columns) 

SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
  FROM orders
  LIMIT 10;

SELECT id, account_id,standard_amt_usd/standard_qty AS unit_price
  FROM orders
  LIMIT 10;

--**Write a query that finds the percentage of revenue that comes from poster paper for each order. 
  You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also. 
    
SELECT id, account_id, 
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

-- LIKE This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.
-- IN This allows you to perform operations similar to using WHERE and =, but for more than one condition.
-- NOT This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.
-- AND & BETWEEN These allow you to combine operations where all combined conditions must be true.
-- OR This allows you to combine operations where at least one of the combined conditions must be true.

SELECT name
  FROM accounts
  WHERE name LIKE 'C%';

SELECT name
  FROM accounts
   WHERE name LIKE '%one%';

SELECT name
  FROM accounts
  WHERE name LIKE '%s';

SELECT name, primary_poc, sales_rep_id 
  FROM accounts
  WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords');

SELECT sales_rep_id, name
  FROM accounts
  WHERE sales_rep_id NOT IN (321500, 321570)
  ORDER BY sales_rep_id;

SELECT *
  FROM web_events_full
  WHERE referrer_url NOT LIKE '%google%';

SELECT name, primary_poc, sales_rep_id
  FROM accounts
  WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
  FROM web_events
  WHERE channel NOT IN ('organic', 'adwords');

SELECT name
  FROM accounts
  WHERE name NOT LIKE 'C%';

SELECT name
  FROM accounts
  WHERE name NOT LIKE '%one%';

SELECT name
  FROM accounts
  WHERE name NOT LIKE '%s';

SELECT *
  FROM orders
  WHERE occurred_at >= '2016-04-01' AND occurred_at <= '2016-10-01'
  ORDER BY occurred_at DESC;

-- * LIKE*,* IN*, and* NOT logic can also be linked together using the AND* operator.

SELECT *
  FROM orders
  WHERE standard_qty >1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT name
  FROM accounts
  WHERE name NOT LIKE 'C%' AND NOT LIKE '%s';

SELECT occurred_at, gloss_qty
  FROM orders
  WHERE gloss_qty BETWEEN 24 AND 29;
-- BETWEEN operator is inclusive; the endpoint values are included

SELECT *
  FROM web_events
  WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
  ORDER BY occurred_at DESC; 

SELECT account_id, occurred_at, standard_qty, gloss_qty, poster_qty
  FROM orders
  WHERE standard_qty =0 OR gloss_qty =0 OR poster_qty = 0;

SELECT account_id, occurred_at, standard_qty, gloss_qty, poster_qty
  FROM orders
  WHERE (standard_qty =0 OR gloss_qty =0 OR poster_qty = 0)
  AND occurred_at >= '2016-10-01';

SELECT id
  FROM orders
  WHERE gloss_qty > 4000 OR poster_qty >4000;

SELECT *
  FROM orders
  WHERE standard_qty = 0
  AND (gloss_qty >1000 OR poster_qty >1000);

SELECT *
  FROM accounts
  WHERE (name LIKE 'C%' OR name LIKE 'W%')
  AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE'%Ana%') AND primary_poc NOT LIKE '%eana%');

SELECT orders.*,
      accounts.*
  FROM demo.orders
  JOIN demo.accounts
  ON orders.account_id =accounts_id;

-- The table name is always before the period.
-- The column you want from that table is always after the period.

SELECT accounts.name, orders.occurred_at
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts_id;
-- This only pulls two columns in these two tables 

SELECT orders.*
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts.id;
-- This pulls all information from only the orders table

SELECT accounts.*,
      orders.*
  FROM accounts
  JOIN orders
  ON accounts.id = orders.account_id;

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,
      accounts.website, accounts.primary_poc
  FROM orders
  JOIN accounts
  ON orders.account_id = accounts_id;












