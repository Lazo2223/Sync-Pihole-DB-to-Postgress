# 📊 Sync Pi-hole DB to PostgreSQL + Grafana

This project serves as a personal learning journey to deepen knowledge in PostgreSQL, database architecture, and practical observability using Grafana. It also lays the foundation for a scalable DNS monitoring stack for a home network.

---

## 🎯 Goals

- Learn PostgreSQL fundamentals:
  - Schema design  
  - Views and materialized views  
  - Indexing  
  - Stored procedures  
- Design and implement a functioning PostgreSQL database  
- Continuously sync DNS queries from Pi-hole’s SQLite database into PostgreSQL  
- Enable custom DNS monitoring via Grafana dashboards  
- Build anomaly detection and alerting (new/unusual domain activity)  

---

## ✅ Progress So Far

- ✅ PostgreSQL and Grafana running on Fedora 40 server  
- ✅ Scripted sync from Pi-hole SQLite to PostgreSQL **(deduplicated)**  
  _To do: automate with `cron` or `systemd` timer_  
- ✅ Grafana connected to PostgreSQL  
- ✅ Custom dashboards built:
  - **New domain activity (last 24h / last 10 days)** — _Anomaly detection_  
  - **Most reached domains by IP (client)**  
  - **Top 10 blocked and allowed domains**  

---

## 📌 Steps Overview

1. **Review the Pi-hole SQLite schema**  
   → [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/Untitled.png](#)  
2. **Create a PostgreSQL schema**  
   → [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/create%20Schema%20on%20Postgress.sql](#)  
3. **Write and test a sync script** to copy data incrementally  
   → [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/Import%20DB%20from%20SQLlite%20to%20Postgress.py](#)  
4. **Deploy PostgreSQL and Grafana containers** on Fedora 40  
   → [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/docker-compose.yaml](#)  
     [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/Install%20Postgress%20DB](#)


5. **Build dashboards in Grafana** using SQL queries to PostgreSQL  
   → [https://github.com/Lazo2223/Sync-Pihole-DB-to-Postgress/blob/main/SQL%20for%20the%20dashboards.sql](#)  

---


## 💡 Requirements

- 🖥️ **Fedora 40** or any Linux server  
- 🧠 **Pi-hole** with access to the `pihole-FTL.db` SQLite file  
- 🐘 **PostgreSQL** (tested on 16.x)  
- 📈 **Grafana OSS** or **Grafana Cloud**  
- 🐍 Python for syncing (script provided)  

---

## 📂 To Do

- [ ] Automate SQLite → PostgreSQL sync (cron/systemd)  
- [ ] Add alerting for suspicious or uncommon domains  
- [ ] Store metadata like `first_seen`, `last_seen`, and domain category  
- [ ] Add support for IP reputation enrichment  

---

## 📸 Screenshots

<img src="Screenshot 2025-05-22 at 14.03.51.png" alt="New Activity Dashboard" width="800"/>  
<img src="Screenshot 2025-05-22 at 14.04.05.png" alt="Top Domains Dashboard" width="800"/>  

---
