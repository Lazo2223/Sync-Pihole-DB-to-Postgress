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
