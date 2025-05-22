CREATE TABLE client_by_id(
id INTEGER PRIMARY KEY,
ip INET,
name VARCHAR(30)
);


CREATE TABLE domain_by_id(
id INTEGER PRIMARY KEY,
domain VARCHAR(300) 
);


CREATE TABLE network(
id INTEGER PRIMARY KEY NOT NULL,
hwaddr VARCHAR(40) NOT NULL UNIQUE,
interface VARCHAR(40),
firstSeen INTEGER,
lastQuery INTEGER,
numQueries INTEGER,
macVendor VARCHAR(50),
aliasclient_id INTEGER
);

CREATE TABLE network_addresses (
    network_id INTEGER,
    ip VARCHAR(40) NOT NULL UNIQUE,
    lastSeen INTEGER,
    name VARCHAR(255),
    nameUpdated INTEGER
);


CREATE TABLE query_storage (
id INTEGER PRIMARY KEY, 
timestamp INTEGER NOT NULL, 
type INTEGER NOT NULL, 
status INTEGER, 
domain INTEGER, 
client INTEGER, 
forward INTEGER, 
additional_info INTEGER, 
reply_type INTEGER, 
reply_time REAL, 
dnssec INTEGER, 
list_id INTEGER, 
ede INTEGER
);

CREATE TABLE query_status (
id INT PRIMARY KEY,
status VARCHAR(20),
details VARCHAR(250)
);

INSERT INTO query_status (id, status, details) VALUES
(0,  'Unknown', 'Unknown status (not yet known)'),
(1,  'Blocked', 'Domain contained in gravity database'),
(2,  'Allowed', 'Forwarded'),
(3,  'Allowed', 'Replied from cache'),
(4,  'Blocked', 'Domain matched by a regex denylist filter'),
(5,  'Blocked', 'Domain contained in exact denylist'),
(6,  'Blocked', 'By upstream server (known blocking page IP address)'),
(7,  'Blocked', 'By upstream server (0.0.0.0 or ::)'),
(8,  'Blocked', 'By upstream server (NXDOMAIN with RA bit unset)'),
(9,  'Blocked', 'Domain contained in gravity database. Blocked during deep CNAME inspection'),
(10, 'Blocked', 'Domain matched by a regex denylist filter. Blocked during deep CNAME inspection'),
(11, 'Blocked', 'Domain contained in exact denylist. Blocked during deep CNAME inspection'),
(12, 'Allowed', 'Retried query'),
(13, 'Allowed', 'Retried but ignored query (this may happen during ongoing DNSSEC validation)'),
(14, 'Allowed', 'Already forwarded, not forwarding again'),
(15, 'Blocked', 'Blocked (database is busy). How these queries are handled can be configured (dns.replyWhenBusy)'),
(16, 'Blocked', 'Blocked (special domain). E.g. Mozilla''s canary domain and Apple''s Private Relay domains. Handling can be configured'),
(17, 'Allowed', 'Replied from stale cache'),
(18, 'Blocked', 'By upstream server (EDE 15)');
