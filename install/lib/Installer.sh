#!/usr/bin/env bash
#
# installer.sh - ZBM Installer Library
# Version: 0.1.0-alpha

set -Eeuo pipefail

install_directories() {
    local dirs=(
        "/usr/local/zbm"
        "/usr/local/zbm/bin"
        "/usr/local/zbm/lib"
        "/usr/local/zbm/examples"
        "/etc/zbm"
        "/backup/zimbra/daily"
        "/backup/zimbra/weekly"
        "/backup/zimbra/monthly"
        "/backup/zimbra/manifest"
        "/backup/zimbra/checksum"
        "/backup/zimbra/reports"
        "/var/log/zbm"
        "/var/tmp/zbm"
        "/var/lock/zbm"
    )
    echo "Creating directories..."
    for d in "${dirs[@]}"; do
        mkdir -p "$d"
        echo "  OK  $d"
    done
}

install_libraries() {
    local src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local dst="/usr/local/zbm/lib"
    echo "Installing libraries..."
    cp -a "$src"/*.sh "$dst"/
}

install_configuration() {
    mkdir -p /etc/zbm
    if [[ ! -f /etc/zbm/zbm.conf ]]; then
cat >/etc/zbm/zbm.conf <<EOF
# ZBM Configuration
BACKUP_ROOT=/backup/zimbra
LOG_DIR=/var/log/zbm
EOF
    fi
}

install_cron() {
cat >/etc/cron.d/zbm <<EOF
# ZBM Cron
0 1 * * * root /usr/local/zbm/bin/backup.sh daily >/dev/null 2>&1
0 2 * * 0 root /usr/local/zbm/bin/backup.sh weekly >/dev/null 2>&1
EOF
}

set_permissions() {
    chmod -R 755 /usr/local/zbm
}

show_install_summary() {
cat <<EOF

Installation Summary
--------------------
Program : /usr/local/zbm
Config  : /etc/zbm
Backup  : /backup/zimbra
Log     : /var/log/zbm

EOF
}
