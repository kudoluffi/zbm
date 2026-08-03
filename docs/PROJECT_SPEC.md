
# Zimbra Backup Manager (ZBM)

> **Version:** v0.1.0-alpha  
> **Status:** Draft  
> **Current Milestone:** Milestone 1A - Foundation

---

# Table of Contents

- [1. Project Overview](#1-project-overview)
- [2. Project Goals](#2-project-goals)
- [3. Supported Platform](#3-supported-platform)
- [4. Design Principles](#4-design-principles)
- [5. Standard Directory Layout](#5-standard-directory-layout)
- [6. Backup Layout](#6-backup-layout)
- [7. Source Code Layout](#7-source-code-layout)
- [8. Coding Standard](#8-coding-standard)
- [9. Logging Standard](#9-logging-standard)
- [10. Exit Codes](#10-exit-codes)
- [11. Development Roadmap](#11-development-roadmap)
- [12. Change Control](#12-change-control)

---

# 1. Project Overview

Zimbra Backup Manager (ZBM) is a modular Backup, Restore and Disaster Recovery toolkit
designed for Zimbra Open Source Edition.

The project is intended to provide a reliable and maintainable backup framework that
supports full backup, daily incremental backup, restore, verification, reporting,
and disaster recovery.

---

# 2. Project Goals

- Reliable backup
- Fast recovery
- Modular architecture
- Easy maintenance
- Production-ready design
- Migration friendly

---

# 3. Supported Platform

| Component | Supported Version |
| ---------- | ----------------- |
| Ubuntu | 22.04 LTS, 24.04 LTS |
| Zimbra | OSE 10.x |
| Bash | 5.x |

---

# 4. Design Principles

1. Modular Architecture
2. One Module = One Responsibility
3. Configuration First
4. Logging First
5. Fail Fast
6. Backward Compatibility

---

# 5. Standard Directory Layout

| Purpose | Location |
| -------- | -------- |
| Program | `/usr/local/zbm` |
| Configuration | `/etc/zbm` |
| Logs | `/var/log/zbm` |
| Runtime & Status | `/var/lib/zbm` |
| Cache | `/var/cache/zbm` |
| Backup Storage | `/backup/zimbra` |

> These paths are considered **Design Freeze**.

---

# 6. Backup Layout

```text
/backup/zimbra/
├── weekly/
│   └── ZBM-YYYYMMDD-HHMMSS/
├── daily/
│   └── YYYY-MM-DD/
└── reports/
```

---

# 7. Source Code Layout

```text
/usr/local/zbm/
├── backup.sh
├── restore.sh
├── verify.sh
├── doctor.sh
├── report.sh
└── lib/
```

---

# 8. Coding Standard

- Functions use `snake_case()`
- Global variables use `UPPER_CASE`
- Local variables use `lowercase`
- Four-space indentation
- No TAB indentation
- All output must go through the logger

---

# 9. Logging Standard

Supported log levels:

- INFO
- SUCCESS
- WARN
- ERROR
- DEBUG

Example:

```text
2026-08-03 01:00:01 [INFO] Starting Weekly Backup
2026-08-03 01:02:20 [SUCCESS] Mailbox Backup Completed
2026-08-03 01:03:10 [ERROR] SSL Backup Failed
```

---

# 10. Exit Codes

| Code | Description |
| ----: | ----------- |
| 0 | Success |
| 1 | Configuration Error |
| 2 | Permission Error |
| 3 | Dependency Error |
| 4 | Backup Error |
| 5 | Restore Error |
| 6 | Verification Error |

---

# 11. Development Roadmap

| Version | Milestone |
| -------- | --------- |
| v0.1.0 | Foundation |
| v0.2.0 | Weekly Backup |
| v0.3.0 | Daily Backup |
| v0.4.0 | Restore |
| v0.5.0 | Verification |
| v0.6.0 | Reporting |
| v1.0.0 | Production Release |

---

# 12. Change Control

This document is the primary design reference for ZBM.

Any architectural changes must be reviewed and agreed before implementation.
