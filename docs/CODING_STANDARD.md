# Zimbra Backup Manager (ZBM)

# CODING_STANDARD.md

**Project** : Zimbra Backup Manager (ZBM)\
**Version** : v0.1.0-alpha\
**Revision** : R001

------------------------------------------------------------------------

# 1. Purpose

Dokumen ini mendefinisikan standar penulisan source code untuk seluruh
proyek **Zimbra Backup Manager (ZBM)**.

Tujuan:

-   Konsisten
-   Mudah dibaca
-   Mudah dipelihara
-   ShellCheck friendly
-   Production Ready

------------------------------------------------------------------------

# 2. Bash Version

Minimal:

``` text
Bash 5.x
```

------------------------------------------------------------------------

# 3. File Header

``` bash
#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/checks.sh
# Version   : v0.1.0-alpha
# Revision  : R001
# Purpose   : Environment validation library
# ==========================================================
#
# Revision History
#
# R001
#   - Initial release.
```

------------------------------------------------------------------------

# 4. Strict Mode

``` bash
set -Eeuo pipefail
```

------------------------------------------------------------------------

# 5. Section Order

1.  Header
2.  Strict Mode
3.  Constants
4.  Global Variables
5.  Private Functions
6.  Validation Functions
7.  Public Functions
8.  Main
9.  Entry Point

------------------------------------------------------------------------

# 6. Function Documentation

Setiap function wajib memiliki dokumentasi.

------------------------------------------------------------------------

# 7. Naming Convention

-   Function : `snake_case`
-   Variable : `lower_snake_case`
-   Constant : `UPPER_SNAKE_CASE`
-   Semua constant menggunakan `readonly`.

------------------------------------------------------------------------

# 8. Quoting

Selalu gunakan:

``` bash
"${variable}"
```

------------------------------------------------------------------------

# 9. Command Substitution

Gunakan:

``` bash
value="$(command)"
```

------------------------------------------------------------------------

# 10. Indentation

-   4 spaces
-   Tidak menggunakan TAB

------------------------------------------------------------------------

# 11. Logging

Gunakan helper dari `common.sh`.

    info
    success
    warning
    error
    debug

------------------------------------------------------------------------

# 12. Error Handling

-   `return` di dalam function
-   `exit` hanya di entry point

------------------------------------------------------------------------

# 13. Exit Codes

Semua exit code didefinisikan sebagai constant.

------------------------------------------------------------------------

# 14. Directory Constant

Tidak boleh hardcode path.

------------------------------------------------------------------------

# 15. ShellCheck

Semua source wajib lolos ShellCheck.

------------------------------------------------------------------------

# 16. TODO Format

``` bash
# TODO(v0.2.0):
#   Implement checksum verification.
```

------------------------------------------------------------------------

# 17. No Magic Number

Gunakan constant untuk angka yang dipakai berulang.

------------------------------------------------------------------------

# 18. Commit Message

Gunakan Conventional Commits.

Contoh:

``` text
feat(installer): add installer library
fix(backup): improve logging
docs: update coding standard
```

------------------------------------------------------------------------

# 19. Repository Structure

``` text
backup/
docs/
examples/
install/
restore/
verify/
```

------------------------------------------------------------------------

# 20. Definition of Done

Sebuah file dianggap selesai apabila:

-   Mengikuti Coding Standard
-   ShellCheck clean
-   Tidak memiliki placeholder
-   Siap di-commit

------------------------------------------------------------------------

# 21. Philosophy

> Readable code is more valuable than clever code.
