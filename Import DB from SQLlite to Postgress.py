import sqlite3
import psycopg2

SQLITE_DB_PATH = "/home/Lazarov/coffeetime/piholev6/etc-pihole/pihole-FTL.db"

PG_CONN = {
    "host": "192.168.0.140",
    "port": 5432,
    "database": "pihole",
    "user": "your_username",
    "password": "your_password"
}

TABLE_MAPPINGS = {
    "client_by_id": "client_by_id(id, ip, name)",
    "domain_by_id": "domain_by_id(id, domain)",
    "network": "network(id, hwaddr, interface, firstSeen, lastQuery, numQueries, macVendor, aliasclient_id)",
    "network_addresses": "network_addresses(network_id, ip, lastSeen, name, nameUpdated)",
    "query_storage": "query_storage(id, timestamp, type, status, domain, client, forward, additional_info, reply_type, reply_time, dnssec, list_id, ede)"
}

def copy_table(sqlite_conn, pg_conn, source_table, dest_table_def):
    dest_table = dest_table_def.split("(")[0]
    columns = dest_table_def.split("(", 1)[1].rstrip(")")
    placeholders = ", ".join(["%s"] * len(columns.split(",")))

    print(f"Syncing {source_table} → {dest_table}...")

    sqlite_cur = sqlite_conn.cursor()
    pg_cur = pg_conn.cursor()

    sqlite_cur.execute(f"SELECT {columns} FROM {source_table}")
    rows = sqlite_cur.fetchall()

    pg_cur.execute(f"TRUNCATE {dest_table} RESTART IDENTITY CASCADE")
    pg_cur.executemany(
        f"INSERT INTO {dest_table} ({columns}) VALUES ({placeholders})", rows
    )
    pg_conn.commit()
    print(f"Inserted {len(rows)} rows into {dest_table}.")

def main():
    print("Connecting to SQLite...")
    sqlite_conn = sqlite3.connect(SQLITE_DB_PATH)

    print("Connecting to PostgreSQL...")
    pg_conn = psycopg2.connect(**PG_CONN)

    try:
        for sqlite_table, pg_table_def in TABLE_MAPPINGS.items():
            copy_table(sqlite_conn, pg_conn, sqlite_table, pg_table_def)

    finally:
        sqlite_conn.close()
        pg_conn.close()
        print("All done!")

if __name__ == "__main__":
    main()
#Start the script:
#python3 copy_pihole_to_postgres.py
#in /home/Lazarov/coffeetime/piholev6/
