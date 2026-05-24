/* Project: Data Analysis for Fantasy Game
 * Part 2. Solving ad hoc tasks
 *
 * Author: Vorobyeva T.
*/

--Task 1. Investigation of Paying Player Share
-- 1.1. Number of players and share of paying users across all data:
SELECT 
    COUNT(id) AS users_total,
    SUM(CASE WHEN payer = 1 THEN 1 ELSE 0 END) AS payers_num,
    -- Calculate the share as a percentage
    ROUND(SUM(CASE WHEN payer = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(id), 2) AS payers_share
FROM fantasy.users;

-- 1.2. Share of paying users broken down by character race:
--Calculation of the number of players who make in-game purchases:
WITH buying_users_calc AS 
(SELECT DISTINCT id 
FROM fantasy.events),

--Calculation of the share of paying players among players making in-game purchases
metrics_calc AS (SELECT r.race_id, 
r.race, 
COUNT(u.id) AS users_total,
SUM(CASE WHEN u.payer = 1 THEN 1 ELSE 0 END) AS payers_num,
ROUND(SUM(CASE WHEN u.payer = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(bu.id), 2) AS payers_share
FROM fantasy.users AS u
LEFT JOIN fantasy.race AS r ON u.race_id=r.race_id
JOIN buying_users_calc AS bu ON u.id=bu.id
GROUP BY r.race_id, r.race)

--main query
SELECT *,
ROUND(AVG(payers_share) OVER (), 2) AS avg_payers_share
FROM metrics_calc;

--Task 2. Investigation of In-Game Purchases
-- 2.1. Statistical indicators for the amount field:
-- Write your query here
--total number of purchases:
SELECT COUNT(transaction_id),
--total cost of all purchases:
SUM(amount::numeric),
--minimum and maximum purchase cost:
MIN(amount), MAX(amount),
--average value, median, and standard deviation of purchase cost:
ROUND(AVG(amount)::numeric, 2) AS avg, PERCENTILE_DISC(0.5::float) WITHIN GROUP(ORDER BY amount) AS median, ROUND(STDDEV(amount)::numeric, 2) AS stand_dev
FROM fantasy.events;

-- 2.2: Anomalous zero-value purchases:
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN amount = 0 THEN 1 ELSE 0 END) AS empty_rows,
    -- Calculate the share as a percentage
    ROUND(SUM(CASE WHEN amount = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS empty_amount_share
FROM fantasy.events;

-- 2.3: Popular epic items:
SELECT e.item_code, i.game_items, COUNT(e.amount) AS item_amount,
--Total number of in-game sales in absolute and relative values:
    ROUND(COUNT(amount) * 100.0 / (SELECT COUNT(*) FROM fantasy.events WHERE amount > 0), 2) AS relative_share,
--Share of players who bought this item at least once, out of the total number of in-game buyers:
    ROUND(COUNT(DISTINCT id) * 100.0 / (SELECT COUNT(DISTINCT id) FROM fantasy.events WHERE amount > 0), 2) AS users_share
FROM fantasy.events AS e
LEFT JOIN fantasy.items AS i ON e.item_code = i.item_code
WHERE e.amount > 0
GROUP BY e.item_code, i.game_items
ORDER BY COUNT(e.amount) DESC;


--PART 2. AD-HOC QUERIES
WITH user_calc AS 
    (SELECT race_id, 
    COUNT(DISTINCT id) AS users_total
    FROM fantasy.users
    GROUP BY race_id),

--CTE2 Number of players who make in-game purchases:
buying_user_calc AS 
    (SELECT u.race_id, 
    COUNT(DISTINCT e.id) AS buying_users,
    COUNT(DISTINCT CASE WHEN u.payer = 1 THEN u.id END) AS paying_users,
    
--Average number of purchases per 1 player, average cost of 1 purchase per 1 player, average total cost of all purchases for 1 player
ROUND(COUNT(e.transaction_id)::numeric / COUNT(DISTINCT e.id), 2) AS avg_purchase_count,
ROUND(SUM(e.amount)::numeric / COUNT(e.transaction_id), 2) AS avg_purchase_value,
ROUND(SUM(e.amount)::numeric / COUNT(DISTINCT e.id), 2) AS avg_purchase_sum_value
FROM fantasy.users AS u
LEFT JOIN fantasy.events AS e ON u.id = e.id
WHERE e.amount > 0
GROUP BY u.race_id)

--Main query, including calculation of: 1) share of players making in-game purchases out of the total number of registered players; 2) share of paying players among players making in-game purchases;
SELECT uc.race_id, r.race,
uc.users_total, 
bc.buying_users,
ROUND(bc.buying_users::numeric * 100 / uc.users_total, 2) AS buying_user_share,
bc.paying_users, 
ROUND(bc.paying_users::numeric * 100 / bc.buying_users, 2) AS paying_user_share,
bc.avg_purchase_count, 
bc.avg_purchase_value, 
bc.avg_purchase_sum_value
FROM user_calc AS uc
LEFT JOIN buying_user_calc AS bc ON uc.race_id = bc.race_id
LEFT JOIN fantasy.race AS r ON uc.race_id = r.race_id
ORDER BY race_id;

--Calculation of the most popular purchased items (top-5) and the number of players who bought them:
SELECT e.item_code, i.game_items, COUNT(e.amount) AS item_amount,

--Total number of in-game sales in absolute and relative values:

    ROUND(COUNT(amount) * 100.0 / (SELECT COUNT(*) FROM fantasy.events WHERE amount > 0), 2) AS relative_share,
    
--Share of players who bought this item at least once, out of the total number of in-game buyers:
    ROUND(COUNT(DISTINCT id) * 100.0 / (SELECT COUNT(DISTINCT id) FROM fantasy.events WHERE amount > 0), 2) AS users_share
FROM fantasy.events AS e
LEFT JOIN fantasy.items AS i ON e.item_code = i.item_code
WHERE e.amount > 0
GROUP BY e.item_code, i.game_items
ORDER BY COUNT(e.amount) DESC;

--Total number of purchases by race:
SELECT u.race_id,
COUNT(e.transaction_id) AS total_buys
FROM fantasy.events AS e
LEFT JOIN fantasy.users as u ON e.id=u.id
GROUP BY u.race_id
ORDER BY total_buys DESC;

--Top anomalous purchases (top-50 in descending order):
SELECT *
FROM fantasy.events
ORDER BY amount DESC
LIMIT 50;

--Checking the dependence of player activity in purchasing epic items on character race:
SELECT u.race_id, race,
COUNT(e.transaction_id) AS total_buys
FROM fantasy.events AS e
LEFT JOIN fantasy.users AS u ON e.id=u.id
LEFT JOIN fantasy.race AS r ON u.race_id=r.race_id
GROUP BY u.race_id, race
ORDER BY total_buys DESC;

-- Investigation of anomalously high purchases (amount > (AVG(amount)+Stdev=3043.04) broken down by epic items:
WITH anomaly_calc AS (SELECT e.transaction_id, e.id, e.item_code, i.game_items, e.amount, e.seller_id,
COUNT(*) OVER() AS total_rows_in_report
FROM fantasy.events AS e
LEFT JOIN fantasy.items AS i ON e.item_code = i.item_code  
WHERE e.amount > 3043.34
ORDER BY e.amount DESC)

-- Main query
SELECT game_items,
COUNT(transaction_id) AS purchase_count,
SUM(amount) AS total_purchase_amount,
SUM(COUNT(transaction_id)) OVER() AS total_anomaly_count,
COUNT(*) OVER() AS anomaly_item_count
FROM anomaly_calc
GROUP BY game_items
ORDER BY total_purchase_amount DESC
LIMIT 5;

--Investigation of anomalously high purchases (amount > (AVG+Stdev)) broken down by players:
-- CTE1: Filter the transaction database, cutting off highly anomalous purchases (the threshold is 3043.04, which corresponds to AVG(amount)+stdev):
WITH amount_calc AS (SELECT id, transaction_id, amount
FROM fantasy.events
WHERE amount > 3043.04),

-- CTE2: Calculate indicators
metric_calc AS (SELECT id AS user_id, COUNT(transaction_id) AS purchase_count, 
SUM(amount) AS total_purchase_value
FROM amount_calc
GROUP BY user_id),

-- CTE3: Rank users
ranked_users AS (SELECT *,
ROW_NUMBER() OVER (ORDER BY total_purchase_value DESC) AS user_rank
FROM metric_calc)

-- Main query: Calculate the cumulative sum only for those users whose rank is <= 10
SELECT 
user_id,
purchase_count,
total_purchase_value,
user_rank,
CASE 
WHEN user_rank <= 10 THEN SUM(total_purchase_value) OVER (ORDER BY user_rank ASC)
ELSE NULL 
END AS cumulative_top_10,
COUNT(*) OVER () AS anomaly_user_count
FROM ranked_users
ORDER BY user_rank ASC;

--Calculation of the number of users who generate 80% of revenue (Pareto principle). Note: 80% of revenue was calculated in section 1.2: 549,948,703.088)
--CTE1 Calculate the total purchase value broken down by players:
WITH amount_per_user_calc AS (SELECT id AS user_id, SUM(amount) AS total_purchase_value
FROM fantasy.events 
GROUP BY id),

--CTE2 Calculate the rank of players depending on the total purchase value, and the cumulative purchase value in the game:
purchase_calc AS (SELECT user_id, 
RANK() OVER(ORDER BY total_purchase_value DESC) AS user_rank, 
total_purchase_value,
SUM(total_purchase_value) OVER(ORDER BY total_purchase_value DESC) AS cumulative_purchase_value
FROM amount_per_user_calc)

--main query Add a filter, cutting off players who collectively provided 80% of revenue (note: 80% of revenue value: 549292032 monetary units, based on calculation in section 1.2):
SELECT *,
COUNT(*) OVER() AS count_users
FROM purchase_calc
WHERE cumulative_purchase_value < 549948703.088;
