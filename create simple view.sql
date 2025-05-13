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
