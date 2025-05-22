CREATE INDEX ON query_status(status)
CREATE INDEX ON query_storage(domain, timestamp)
CREATE INDEX ON domain_by_id(domain)
CREATE INDEX ON client_by_id(ip, name)
  
-- test before and after index on domain_by_id(domain)
EXPLAIN ANALYZE
SELECT domain FROM domain_by_id
WHERE domain = 'a1931.dscgi3.akamai.net'

SELECT relname, relkind
FROM pg_class
WHERE relkind = 'i'
