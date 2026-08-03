#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/constants.sh
# Version   : v0.1.0-alpha
# Revision  : R001
# Purpose   : Global constants library
# ==========================================================
#
# Revision History
#
# R001
#   - Initial release.
#

set -Eeuo pipefail

###############################################################################
# Version
###############################################################################

readonly ZBM_NAME="Zimbra Backup Manager"
readonly ZBM_SHORT_NAME="ZBM"
readonly ZBM_VERSION="v0.1.0-alpha"

###############################################################################
# Exit Codes
###############################################################################

readonly EXIT_SUCCESS=0
readonly EXIT_ERROR=1
readonly EXIT_INVALID_ARGUMENT=2
readonly EXIT_PERMISSION_DENIED=3
readonly EXIT_UNSUPPORTED_OS=4
readonly EXIT_ZIMBRA_NOT_FOUND=5
readonly EXIT_DEPENDENCY_MISSING=6
readonly EXIT_CONFIGURATION_ERROR=7

###############################################################################
# Installation Directories
###############################################################################

readonly ZBM_HOME="/usr/local/zbm"
readonly ZBM_BIN_DIR="${ZBM_HOME}/bin"
readonly ZBM_LIB_DIR="${ZBM_HOME}/lib"
readonly ZBM_EXAMPLES_DIR="${ZBM_HOME}/examples"

###############################################################################
# Configuration
###############################################################################

readonly ZBM_CONFIG_DIR="/etc/zbm"
readonly ZBM_CONFIG_FILE="${ZBM_CONFIG_DIR}/zbm.conf"

###############################################################################
# Backup Directories
###############################################################################

readonly ZBM_BACKUP_ROOT="/backup/zimbra"
readonly ZBM_DAILY_DIR="${ZBM_BACKUP_ROOT}/daily"
readonly ZBM_WEEKLY_DIR="${ZBM_BACKUP_ROOT}/weekly"
readonly ZBM_MONTHLY_DIR="${ZBM_BACKUP_ROOT}/monthly"
readonly ZBM_MANIFEST_DIR="${ZBM_BACKUP_ROOT}/manifest"
readonly ZBM_CHECKSUM_DIR="${ZBM_BACKUP_ROOT}/checksum"
readonly ZBM_REPORT_DIR="${ZBM_BACKUP_ROOT}/reports"

###############################################################################
# Runtime Directories
###############################################################################

readonly ZBM_LOG_DIR="/var/log/zbm"
readonly ZBM_TMP_DIR="/var/tmp/zbm"
readonly ZBM_LOCK_DIR="/var/lock/zbm"

###############################################################################
# Scheduler
###############################################################################

readonly ZBM_CRON_FILE="/etc/cron.d/zbm"

###############################################################################
# Ownership & Permissions
###############################################################################

readonly ZBM_OWNER="root"
readonly ZBM_GROUP="root"
readonly ZBM_DIR_MODE="755"
readonly ZBM_FILE_MODE="644"

###############################################################################
# Defaults
###############################################################################

readonly DEFAULT_RETENTION_DAILY=30
readonly DEFAULT_RETENTION_WEEKLY=8
readonly DEFAULT_RETENTION_MONTHLY=12
