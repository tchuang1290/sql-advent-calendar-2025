-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

SELECT *
FROM(

SELECT 
  user_name,
  DATE(sent_at) AS message_date,
  COUNT(message_id) AS message_count,
  RANK() OVER(
    PARTITION BY DATE(sent_at)
    ORDER BY COUNT(message_id) DESC
  ) AS most_active
FROM npn_users u
INNER JOIN npn_messages m
  ON u.user_id = m.sender_id
GROUP BY u.user_name, DATE(m.sent_at)) AS messages_per_day

WHERE most_active = 1
