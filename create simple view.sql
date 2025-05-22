--Join tables for easy access and query only view_domains_info_all
CREATE OR REPLACE VIEW view_domains_info_all AS

SELECT did.domain, 
        cid.ip, 
        qst.status, 
        qst.details
FROM domain_by_id did
LEFT JOIN query_storage qs
	      ON qs.domain = did.id
LEFT JOIN client_by_id cid
	      ON cid.id = qs.client
	LEFT JOIN query_status qst
	      ON qst.id = qs.status

SELECT * 
FROM view_domains_info_all

-- first seen domain in the last 10 days
	
CREATE OR REPLACE VIEW new_activity_10_days AS
SELECT domain, TO_TIMESTAMP(MIN(timestamp)) AS first_seen
FROM view_domains_info_all
GROUP BY domain
HAVING MIN(timestamp) >= EXTRACT(EPOCH FROM NOW() - INTERVAL '10 day')

-- first seen domain in the last 24 hours
SELECT domain, TO_TIMESTAMP(MIN(timestamp)) AS first_seen
FROM view_domains_info_all
GROUP BY domain
HAVING MIN(timestamp) >= EXTRACT(EPOCH FROM NOW() - INTERVAL '1 day')
