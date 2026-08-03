# Zimbra Backup Manager (ZBM)

**Project Specification**

-   **Version:** 0.1.0-alpha
-   **Status:** Draft
-   **Current Milestone:** 1A -- Foundation

------------------------------------------------------------------------

# 1. Purpose

Zimbra Backup Manager (ZBM) is a modular backup, restore and disaster
recovery toolkit for Zimbra Open Source Edition. The primary goals are
reliability, maintainability, recoverability, auditability and
extensibility.

# 2. Supported Platform

  Component   Version
  ----------- ----------------------
  Ubuntu      22.04 LTS, 24.04 LTS
  Zimbra      OSE 10.x
  Shell       Bash 5.x

# 3. Design Principles

1.  Modular architecture.
2.  One file = one responsibility.
3.  Configuration-first.
4.  Logging-first.
5.  Fail-fast.
6.  Backward compatible whenever possible.

# 4. Standard Directories (Frozen)

  Purpose            Path
  ------------------ ------------------
  Program            `/usr/local/zbm`
  Configuration      `/etc/zbm`
  Logs               `/var/log/zbm`
  Runtime / Status   `/var/lib/zbm`
  Cache              `/var/cache/zbm`
  Backup Storage     `/backup/zimbra`

These locations are considered frozen unless a technical reason requires
a change.

# 5. Backup Layout

``` text
/backup/zimbra/
├── weekly/
│   └── ZBM-YYYYMMDD-HHMMSS/
├── daily/
│   └── YYYY-MM-DD/
└── reports/
```

# 6. Source Tree

``` text
/usr/local/zbm/
├── backup.sh
├── restore.sh
├── verify.sh
├── doctor.sh
├── report.sh
└── lib/
```

# 7. Coding Standard

-   Function names: `snake_case()`
-   Global variables: `UPPER_CASE`
-   Local variables: `lowercase`
-   Indentation: 4 spaces
-   No TAB indentation
-   Avoid direct `echo`; use logger functions.

# 8. Logging Levels

-   INFO
-   SUCCESS
-   WARN
-   ERROR
-   DEBUG

# 9. Exit Codes

  Code   Meaning
  ------ ---------------------
  0      Success
  1      Configuration Error
  2      Permission Error
  3      Dependency Error
  4      Backup Error
  5      Restore Error
  6      Verify Error

# 10. Roadmap

  Version   Target
  --------- ---------------
  0.1.0     Foundation
  0.2.0     Weekly Backup
  0.3.0     Daily Backup
  0.4.0     Restore
  0.5.0     Verify
  0.6.0     Report
  1.0.0     Production

# 11. Change Control

This document is the primary design reference for ZBM. Core architecture
changes require explicit review before implementation.
