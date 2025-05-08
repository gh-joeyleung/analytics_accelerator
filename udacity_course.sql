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

SELECT *
  FROM web_events
  JOIN accounts
  ON web_events.account_id = accounts.id
  JOIN orders
  ON accounts.id = orders.account_id;

--ALIAS
FROM tablename AS t1
JOIN tablename2 AS t2
--Same results without AS
FROM tablename t1
JOIN tablename2 t2
--ALIAS for tablename
Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2
  
SELECT w.channel, w.occured_at, a.primary_poc, a.name
  FROM web_events w
  JOIN accounts a
  ON w.account_id = a.id
  WHERE a.name = 'Walmart';

SELECT r.name region, s.name rep, a.name account;
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  ORDER BY a.name ;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id;

-- Left Join - all of the results left table and those that match right table
SELECT
  FROM left table
  LEFT JOIN right table

-- Right Join - those accounts that match the left table and accounts that don't have orders
SELECT a.id, a.name, o.total
  FROM orders o
  RIGHT JOIN accounts a
  ON o.account_id = a.id

-- Same result
SELECT a.id, a.name, o.total
  FROM orders o
  RIGHT JOIN accounts a
  ON o.,account_id = a.id

SELECT a.id, a.name, o.total
  FROM accounts a
  LEFT JOIN orders o
  ON o.account_id = a.id

SELECT orders.*,
      accounts.*
  FROM orders
  LEFT accounts
  ON orders.account_id = accounts.id
  WHERE accounts.sales_rep_id = 321500
-- Change WHERE to AND (will act as part as ON so it's run before the JOIN clause and cases that are not from sales rep 321500 are also present)
-- A simple rule to remember this is that, when the database executes this query, it executes the join and everything in the ON clause first. 
-- Think of this as building the new result set. That result set is then filtered using the WHERE clause.

SELECT r.name region, s.name sales_rep, a.name account
  FROM region r
  JOIN sales_rep s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  WHERE r.name = 'Midwest'
  ORDER BY a.name;

SELECT r.name region, s.name sales_rep, a.name account
  FROM region r
  JOIN sales_rep s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
  ORDER BY a.name;

SELECT r.name region, s.name sales_rep, a.name account
  FROM region r
  JOIN sales_rep s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
  ORDER BY a.name;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  WHERE o.standard_qty >100;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  WHERE o.standard_qty >100 AND o.poster_qty >50
    ORDER BY o.unit_price;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unit_price
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  WHERE o.standard_qty >100 AND o.poster_qty >50
  ORDER BY o.unit_price DESC;

SELECT DISTINCT a.name, w.channel
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  WHERE a.id = '1001';

SELECT a.name, o.occurred_at, o.total, o.total_amt_usd
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  WHERE o.occured_at BETWEEN '01-01-2015' AND '01-01-2016'
  ORDER BY o.occurred_at DESC;

-- When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL. 
-- We don't use =, because NULL isn't considered a value in SQL. Rather, it is a property of the data.

SELECT SUM(poster_qty) AS total_poster_sales
  FROM orders;

SELECT SUM(standard_qty) AS total_standard_sales
  FROM orders;

SELECT SUM(total_amt_usd) AS total_dollar_sales
  FROM orders;

SELECT standard_amt_usd+gloss_amt_usd AS total_standard_gloss
  FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) standard_sum_per_unit
  FROM orders;

SELECT MIN(occurred_at)
  FROM orders;

SELECT occurred_at
  FROM orders
  ORDER BY occurred_at
  LIMIT 1;

SELECT MAX(occurred_at)
  FROM web_events;

SELECT occurred_at
  FROM web_events
  ORDER BY occurred_at DESC
  LIMIT 1;

SELECT AVG(standard_amt_usd) AS avg_standard_spent,
      AVG(gloss_amt_usd) AS avg_gloss_spent,
      AVG(poster_amt_usd) AS avg_poster_spent,
      AVG(standard_qty) AS avg_standard_qty,
      AVG(gloss_qty) AS avg_gloss_qty,
      AVG(poster_qty) AS avg_poster_qty,
  FROM orders;

--MEDIAN
SELECT * 
  FROM orders
  (SELECT total_amt_usd
  FROM orders
  ORDER BY total_amt_usd
  LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
-- Since there are 6912 orders - we want the average of the 3457 and 3456 order amounts when ordered. 
--This is the average of 2483.16 and 2482.55. This gives the median of 2482.855.

SELECT account_id,
  SUM(standard_qty) AS standard_sum
  SUM(gloss_qty) AS gloss_sum
  SUM(poster_qty) AS poster_sum
FROM orders
GROUP BY account_id
ORDER BY account_id;
-- The GROUP BY always goes between WHERE and ORDER BY.

SELECT a.name, 
  o.occurred_at
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  ORDER BY o.occurred_at
  LIMIT 1;

SELECT a.name, 
  SUM(o.total_amt_usd) total sales
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

SELECT a.name, 
  w.channel,
  w.occurred_at
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  ORDER BY w.occurred_at DESC
  LIMIT 1;

SELECT channel, COUNT(*)
  FROM web_events
  GROUP BY channel;

SELECT a.primary_poc,
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  ORDER BY w.occurred_at
  LIMIT 1;

SELECT a.name, 
  MIN(.total_amt_usd) smallest_order
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name
  ORDER BY smallest_order;

SELECT r.name, COUNT(*) num_rep
  FROM sales_rep s
  JOIN region r
  ON s.region_id = r.id
  GROUP BY r.name
  ORDER BY num_reps;

-- REDO
SELECT a.name, o.occurred_at
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  ORDER BY o.occurred_at
  LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) AS total_sales
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

SELECT a.name, w.occurred_at, w.channel
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  ORDER BY o.occurred_at DESC
  LIMIT 1;

SELECT channel, COUNT(*)
  FROM web_events
  GROUP BY channel;

SELECT a.primary_poc
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  ORDER BY o.occurred_at
  LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) AS smallest_order
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name
  ORDER BY smallest_order;

SELECT r.name, COUNT(*) AS num_rep
  FROM region r
  JOIN sales_reps s 
  ON s.region_id = r.id
  GROUP BY r.name
  ORDER BY num_rep;

SELECT accountd_id,
  channel,
  COUNT(id) AS events
  FROM web_events_full
  GROUP BY account_id, channel
  ORDER BY account_id, events DESC;

SELECT a.name, AVG(o.standard_qty)avg_stand, AVG(o.poster_qty) avg_post, AVG(o.glossy_qty) avg_gloss
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

SELECT a.name, AVG(o.standard_amt_usd)avg_stand, AVG(o.poster_amt_usd)avg_post, AVG(o.glossy_amt_usd) avg_gloss
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.name;

SELECT s.name, w.channel, COUNT(*) num_events
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  JOIN sales_rep s
  ON s.id = a.sales_rep_id
  GROUP BY s.name, w.channel
  ORDER BY num_events DESC;

SELECT r.name, w.channel, COUNT(*) AS num_events
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  JOIN sales_rep s
  ON s.id = a.sales_rep_id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY r.name, w.channel
  GROUP BY num_events DESC;

SELECT a.id as account_id, r.id region, a.name as account_name, r.name as region_name
  FROM accounts a
  JOIN sales_rep s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON s.region_id = r.id;
--OR 
SELECT DISTINCT id, name
    FROM accounts;

SELECT  s.id, s.name, COUNT(*) num_accounts
  FROM accounts a
  JOIN sales_rep s
  ON a.sales_rep_id = s.id
  GROUP BY s.id, s.name
  ORDER BY num_accounts;
--OR
SELECT DISTINCT id, name
  FROM sales_reps;

SELECT account_id, SUM(total_amt_usd) AS sum_total_amt_usd
  FROM orders
  GROUP BY 1
  HAVING SUM(total_amt_usd) >= 250000;

SELECT s.id, s.name, COUNT(*) AS num_accounts
  FROM accounts a
  JOIN sales_reps s
  ON s.id = a.sales_rep_id
  GROUP BY s.id, s.name
  HAVING COUNT(*) >5
  ORDER BY num_accounts;

SELECT a.id, a.name, COUNT(*) AS num_orders
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  HAVING COUNT(*) >20
  ORDER BY num_orders;

SELECT a.id, a.name, COUNT(*) AS num_orders
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  ORDER BY num_orders DESC
  LIMIT 1;

SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  HAVING SUM(o.total_amt_usd) >30000
  ORDER BY total_spent;

SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  HAVING SUM(o.total_amt_usd) <1000
  ORDER BY total_spent;

SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  ORDER BY total_spent DESC
  LIMIT 1;

SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  ORDER BY total_spent
  LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  GROUP BY a.id, a.name, w.channel
  HAVING COUNT(*) >6 AND w.channel ='facebook'
  ORDER BY use_of_channel;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  WHERE w.channel ='facebook'
  GROUP BY a.id, a.name, w.channel
  ORDER BY use_of_channel DESC
  LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
  FROM accounts a
  JOIN web_events w
  ON a.id = w.account_id
  GROUP BY a.id, a.name, w.channel
  ORDER BY use_of_channel DESC
  LIMIT 10;

SELECT DATE_TRUNC('day', occurred_at), SUM(standard_qty) AS standard_qty_sum
  FROM orders
  GROUP BY DATE_TRUNC('day', occurred_at)
  ORDER BY DATE_TRUNC('day', occurred_at);

SELECT DATE_PART ('dow', occurred_at) AS day_of_week, SUM(total) AS total_qty
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC;
-- 1 refers to the standard_qty since it is the first column

SELECT DATE_PART ('year', occurred_at) AS year, SUM(total_amt_usd) AS total_sales
  FROM orders
  GROUP BY 1
  ORDER BY 2 DESC;

SELECT DATE_PART ('month', occurred_at) AS ord_month, SUM(total_amt_usd) AS total_sales
  FROM orders
  WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP BY 1
  ORDER BY 2 DESC;

SELECT DATE_PART ('year', occurred_at) AS ord_year, COUNT(*) AS total_ord
  FROM orders
  WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP BY 1
  ORDER BY 2 DESC;

SELECT DATE_PART ('month', occurred_at) AS ord_month, COUNT(*) AS total_ord
  FROM orders
  WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
  GROUP BY 1
  ORDER BY 2 DESC;

SELECT DATE_PART ('month', o.occurred_at) AS ord_month, SUM(gloss_amt_usd) AS gloss_spent
  FROM orders o 
  JOIN accounts a
  ON a.id = o.account_id
  WHERE w.name = 'walmart'
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1;

SELECT id, account_id, occurred_at, channel,
  CASE WHEN channel = 'facebook' OR channel 'direct' THEN 'yes' ELSE 'no' END AS is_facebook
  FROM web_events
  ORDER BY occurred_at;

SELECT account_id, occurred_at, total,
  CASE WHEN total >500 THEN 'Over 500'
      WHEN total >300 AND total <= 500 THEN '301-500'
      WHEN total >100 AND total <= 300 THEN '101-300'
      ELSE '100 or under' END AS total_group
  FROM orders

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;
-- Use CASE statement
SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

SELECT account_id, total_amt_usd, 
  CASE WHEN total_amt_usd >3000 THEN 'Large'
      ELSE 'Small'
      END AS order_level
  FROM orders;

SELECT 
  CASE WHEN total >= 2000 THEN 'At least 2000'
      WHEN total >= 1000 AND total <2000 THEN 'Btw 1000 and 2000' 
      ELSE 'Less than 1000'
      END AS order_category,
  COUNT(*) AS order_account
  FROM orders
  ORDER BY 1;

SELECT a.name,SUM(total_amt_usd) total_sales
  CASE WHEN SUM(total_amt_usd) >200000 THEN 'top'
      WHEN SUM(total_amt_usd) <=200000 AND SUM(total_amt_usd) >=100000 THEN 'mid'
      ELSE 'low'
      END AS cust_level
  FROM orders
  JOIN accounts
  ON o.account_id = a.id
  GROUP BY a.name
  ORDER BY total_sales;

SELECT a.name,SUM(total_amt_usd) total_sales
  CASE WHEN SUM(total_amt_usd) >200000 THEN 'top'
      WHEN SUM(total_amt_usd) <=200000 AND SUM(total_amt_usd) >=100000 THEN 'mid'
      ELSE 'low'
      END AS cust_level
  FROM orders
  JOIN accounts
  ON o.account_id = a.id
  WHERE occurred_at > '2015-12-31'
  GROUP BY 1
  ORDER BY 2;

SELECT s.name, COUNT (*) num_orders
  CASE WHEN COUNT (*) > 200 THEN 'top'
      ELSE 'not'
      END AS sales_rank
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  JOIN sales_reps
  ON s.id = a.sales_rep_id
  GROUP BY s.name
  ORDER BY num_orders DESC;

SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent
  CASE WHEN COUNT (*) > 200 OR SUM(o.total_amt_usd) >75000 THEN 'top'
      WHEN COUNT (*) > 150 OR SUM(o.total_amt_usd) >50000 THEN 'mid'
      ELSE 'low'
      END AS sales_rank
  FROM orders o
  JOIN accounts a
  ON a.id = o.id
  JOIN sales_reps
  ON s.id = a.sales_rep_id
  GROUP BY s.name
  ORDER BY total_spent DESC;

--SUBQUERIES

SELECT channel,
  AVG(events_count) AS avg_event_count
  FROM
(SELECT DATE_TRUNC('day', occurred_at) AS day,
  channel,
  COUNT(*) AS event_acount
  FROM web_events
  GROUP BY 1, 2
  ) sub
  GROUP BY 1
  ORDER BY 2 DESC;
-- first inner query will run then outer query will run

SELECT DATE_TRUNC('day', occurred_at) AS day,
  channel,
  COUNT(*) AS event_acount
  FROM web_events
  GROUP BY 1, 2
  ORDER BY 3 DESC;

SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
                channel, COUNT(*) as events
          FROM web_events 
          GROUP BY 1,2
          ORDER BY 3 DESC) sub;

SELECT channel, AVG(event_account) AS avg_events
  FROM 
  (SELECT DATE_TRUNC('day', occurred_at) AS day,
  channel,
  COUNT(*) AS event_acount
  FROM web_events
  GROUP BY 1, 2
  ) sub
  ORDER BY 2 DESC;

SELECT *
  FROM orders
  WHERE DATE_TRUNC('month', occurred_at) = 
(SELECT DATE_TRUNC('month', MIN(occurred_at)_ AS min_month
    FROM orders)
  ORDER BY occurred_at;

SELECT DATE_TRUNC('month', MIN(occurred_at))
  FROM orders;

SELECT AVG(standard_qty) avg_std, AVG(poster_qty)avg_post, AVG(glossy_qty) avg_gloss
  FROM orders
  WHERE DATE_TRUNC('month', occurred_at)=
      (SELECT DATE_TRUNC('month', MIN(occurred_at))
      FROM orders);

SELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) 
      FROM orders);

SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN orders o
  ON o.account_id = a.id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY 1,2
  ORDER BY 3 DESC;

SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
        FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                JOIN accounts a
                ON a.sales_rep_id = s.id
                JOIN orders o
                ON o.account_id = a.id
                JOIN region r
                ON r.id = s.region_id
                GROUP BY 1, 2) t1
        GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN accounts a
        ON a.sales_rep_id = s.id
        JOIN orders o
        ON o.account_id = a.id
        JOIN region r
        ON r.id = s.region_id
        GROUP BY 1,2
        ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;


SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
         SELECT MAX(total_amt)
         FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
                 FROM sales_reps s
                 JOIN accounts a
                 ON a.sales_rep_id = s.id
                 JOIN orders o
                 ON o.account_id = a.id
                 JOIN region r
                 ON r.id = s.region_id
                 GROUP BY r.name) sub);

--WITH

WITH events AS (SELECT DATE_TRUNC('day', occurred_at) AS day,
    channel,
    COUNT(*) AS event_count
    FROM web_events
    GROUP BY 1,2)
SELECT channel, AVG(event_count) AS avg_event_count
  FROM events
  GROUP BY 1
  ORDER BY 2 DESC;

--SUBQUERY VERSION
SELECT channel, AVG(events) AS average_events
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
             channel, COUNT(*) as events
      FROM web_events 
      GROUP BY 1,2) sub
GROUP BY channel
ORDER BY 2 DESC;

--WITH VERSION
WITH events AS( 
            SELECT DATE_TRUNC('day',occurred_at) AS day, 
                              channel, COUNT(*) as events
            FROM web_events
            GROUP BY 1,2)
SELECT channel, AVG(events) AS avg_events
  FROM events
  GROUP BY channel
  ORDER BY 2 DESC;

WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)


SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;

WITH t1 AS (
     SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY 1,2
      ORDER BY 3 DESC), 
t2 AS (
      SELECT region_name, MAX(total_amt) total_amt
      FROM t1
      GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;





