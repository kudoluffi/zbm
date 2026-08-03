<!--
Project : Zimbra Backup Manager (ZBM)
File    : README.md
Version : v0.1.0-alpha
-->

# Zimbra Backup Manager (ZBM)

> **Version:** v0.1.0-alpha  
> **Status:** Development  
> **Current Milestone:** Milestone 1A - Foundation

A modular backup, restore and disaster recovery toolkit for **Zimbra Open Source Edition**.

---

# Features (Planned)

- ✅ Weekly Full Backup
- ✅ Daily Mailbox Backup (date-based)
- ✅ Flexible Restore (full or selective)
- ✅ Configuration Backup
- ✅ Account & Password Backup
- ✅ SSL, DKIM, LDAP Backup
- ✅ Integrity Verification
- ✅ Telegram Notification
- ✅ HTML Report
- ✅ Migration Friendly

---

# Supported Platforms

| Component | Version |
| --------- | ------- |
| Ubuntu | 22.04 LTS / 24.04 LTS |
| Zimbra | OSE 10.x |
| Bash | 5.x |

---

# Repository Layout

```text
zbm/
├── README.md
├── CHANGELOG.md
├── LICENSE
├── docs/
├── install/
├── src/
├── config/
├── tests/
└── examples/
```

---

# Documentation

| Document | Description |
| -------- | ----------- |
| docs/PROJECT_SPEC.md | Project architecture and design |
| docs/INSTALL.md | Installation guide *(coming soon)* |
| docs/BACKUP.md | Backup guide *(coming soon)* |
| docs/RESTORE.md | Restore guide *(coming soon)* |

---

# Development Roadmap

| Version | Milestone | Status |
| ------- | --------- | ------ |
| v0.1.0 | Foundation | 🚧 In Progress |
| v0.2.0 | Weekly Backup | Planned |
| v0.3.0 | Daily Backup | Planned |
| v0.4.0 | Restore | Planned |
| v0.5.0 | Verification | Planned |
| v0.6.0 | Reporting | Planned |
| v1.0.0 | Production Release | Planned |

---

# Design Goals

- Reliable
- Modular
- Recoverable
- Auditable
- Maintainable

---

# License

Internal project (license to be decided before public release).

---

# Authors

- Top Jun
- OpenAI ChatGPT (development assistant)
