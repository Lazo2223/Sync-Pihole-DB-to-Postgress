-- first seen domain in the last 10 days
CREATE OR REPLACE VIEW new_activity_10_days AS
SELECT domain, TO_TIMESTAMP(MIN(timestamp)) AS first_seen
FROM view_domains_info_all
GROUP BY domain
HAVING MIN(timestamp) >= EXTRACT(EPOCH FROM NOW() - INTERVAL '10 day')

-- first seen domain in the last 24 hours
CREATE OR REPLACE VIEW new_activity_24_hours AS
SELECT domain, TO_TIMESTAMP(MIN(timestamp)) AS first_seen
FROM view_domains_info_all
GROUP BY domain
HAVING MIN(timestamp) >= EXTRACT(EPOCH FROM NOW() - INTERVAL '1 day')

SELECT * FROM new_activity_24_hours
ORDER BY first_seen DESC


SELECT * FROM new_activity_10_days
ORDER BY first_seen DESC

--top 10 allowed domains
SELECT domain, COUNT(*) as count_allowed_domains
FROM view_domains_info_all
WHERE status = 'Allowed'
GROUP BY domain
ORDER BY count_allowed_domains DESC
LIMIT 10

---top 10 blocked domains
SELECT domain, COUNT(*) as num_of_blocked
FROM view_domains_info_all
WHERE status = 'Blocked'
GROUP BY domain
ORDER BY num_of_blocked DESC
LIMIT 10


-- Most reached domains by IP
SELECT domain, count(*) as count_domains, ip
FROM view_domains_info_all
GROUP BY domain, ip
ORDER BY count_domains DESC
