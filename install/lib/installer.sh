#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/installer.sh
# Version   : v0.1.0-alpha
# Revision  : R001
# Purpose   : Installation engine library
# ==========================================================
#
# Revision History
#
# R001
#   - Initial release.
#

set -Eeuo pipefail

###############################################################################
# Global Variables
###############################################################################

declare -ag CREATED_DIRECTORIES=()
declare -ag INSTALLED_FILES=()

###############################################################################
# Private Functions
###############################################################################

###############################################################################
# _directory_exists
#
# Check whether a directory exists.
#
# Arguments:
#   $1 Directory path
#
# Returns:
#   0 Directory exists
#   1 Directory does not exist
###############################################################################

_directory_exists()
{
    local directory="$1"

    [[ -d "${directory}" ]]

    if [[ -d "${directory}" ]]; then
        return 0
    fi

return 1
}

###############################################################################
# _file_exists
#
# Check whether a file exists.
#
# Arguments:
#   $1 File path
#
# Returns:
#   0 File exists
#   1 File does not exist
###############################################################################

_file_exists()
{
    local file="$1"

    [[ -f "${file}" ]]

    if [[ -d "${directory}" ]]; then
        return 0
    fi

return 1
}

###############################################################################
# _create_directory
#
# Create a directory.
#
# Arguments:
#   $1 Directory path
#
# Returns:
#   0 Success
#   1 Failure
###############################################################################

_create_directory()
{
    local directory="$1"

    if _directory_exists "${directory}"; then
        debug "Directory already exists: ${directory}"
        return 0
    fi

    info "Creating directory: ${directory}"

    if ! mkdir -p "${directory}"; then
        error "Failed to create ${directory}"
        return 1
    fi

    chmod "${ZBM_DIR_MODE}" "${directory}"
    chown "${ZBM_OWNER}:${ZBM_GROUP}" "${directory}"

    CREATED_DIRECTORIES+=("${directory}")

    success "Created ${directory}"

    return 0
}

###############################################################################
# _copy_file
#
# Copy a file.
#
# Arguments:
#   $1 Source
#   $2 Destination
#
# Returns:
#   0 Success
#   1 Failure
###############################################################################

_copy_file()
{
    local source="$1"
    local destination="$2"

    if ! _file_exists "${source}"; then
        error "Source file not found: ${source}"
        return 1
    fi

    info "Installing $(basename "${destination}")"

    if ! install \
        -m "${ZBM_FILE_MODE}" \
        "${source}" \
        "${destination}"
    then
        error "Unable to install ${destination}"
        return 1
    fi

    INSTALLED_FILES+=("${destination}")

    success "Installed ${destination}"

    return 0
}

###############################################################################
# _install_file
#
# Install a file with specified permission.
#
# Arguments:
#   $1 Source file
#   $2 Destination file
#   $3 Permission
#
# Returns:
#   0 Success
#   1 Failure
###############################################################################

_install_file()
{
    local source="$1"
    local destination="$2"
    local permission="$3"

    if ! _file_exists "${source}"; then
        error "Source file not found: ${source}"
        return 1
    fi

    info "Installing ${destination}"

    if ! install \
        -m "${permission}" \
        "${source}" \
        "${destination}"
    then
        error "Unable to install ${destination}"
        return 1
    fi

    INSTALLED_FILES+=("${destination}")

    success "Installed ${destination}"

    return 0
}

###############################################################################
# _copy_directory
#
# Copy directory recursively.
#
# Arguments:
#   $1 Source directory
#   $2 Destination directory
#
# Returns:
#   0 Success
#   1 Failure
###############################################################################

_copy_directory()
{
    local source="$1"
    local destination="$2"

    if [[ ! -d "${source}" ]]; then
        error "Directory not found: ${source}"
        return 1
    fi

    info "Copying ${source}"

    if ! cp -a "${source}/." "${destination}/"; then
        error "Unable to copy ${source}"
        return 1
    fi

    success "Copied ${source}"

    return 0
}

###############################################################################
# _install_cron
#
# Install ZBM cron scheduler.
#
# Arguments:
#   None
#
# Returns:
#   0 Success
#   1 Failure
###############################################################################

_install_cron()
{
    cat > "${ZBM_CRON_FILE}" <<EOF
# ==========================================================
# Zimbra Backup Manager (ZBM)
# Auto generated - DO NOT EDIT
# ==========================================================

# Daily Backup
0 1 * * * root ${ZBM_BIN_DIR}/backup.sh daily >/dev/null 2>&1

# Weekly Backup
0 2 * * 0 root ${ZBM_BIN_DIR}/backup.sh weekly >/dev/null 2>&1

# Monthly Backup
0 3 1 * * root ${ZBM_BIN_DIR}/backup.sh monthly >/dev/null 2>&1
EOF

    chmod 644 "${ZBM_CRON_FILE}"

    success "Cron installed."

    return 0
}

###############################################################################
# _rollback_installation
#
# Rollback installation if any step fails.
#
# Arguments:
#   None
#
# Returns:
#   0 Always
###############################################################################

_rollback_installation()
{
    warning "Rolling back installation..."

    local file

    for file in "${INSTALLED_FILES[@]}"; do

        [[ -f "${file}" ]] && rm -f "${file}"

    done

    local directory

    for (( directory=${#CREATED_DIRECTORIES[@]}-1; directory>=0; directory-- ))
    do

        rmdir "${CREATED_DIRECTORIES[directory]}" 2>/dev/null || true

    done

    success "Rollback completed."

    return 0
}

###############################################################################
# _cleanup_installation
#
# Cleanup temporary installation data.
#
# Arguments:
#   None
#
# Returns:
#   0 Always
###############################################################################

_cleanup_installation()
{
    CREATED_DIRECTORIES=()

    INSTALLED_FILES=()

    return 0
}
