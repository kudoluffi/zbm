#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/common.sh
# Version   : v0.1.0-alpha
# Revision  : R002
# Purpose   : Common helper functions for installer
# ==========================================================
#
# Revision History
#
# R001
#   - Initial release.
# R002
#   - Add debag & fatal function.

readonly ZBM_LIB_COMMON_VERSION="1.0.0"

readonly ZBM_VERSION="v0.1.0-alpha"
readonly ZBM_PROJECT_NAME="Zimbra Backup Manager"
readonly ZBM_SHORT_NAME="ZBM"

zbm_common_version() {
    printf "%s\n" "${ZBM_LIB_COMMON_VERSION}"
}

zbm_timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

zbm_date() {
    date +"%Y-%m-%d"
}

zbm_hostname() {
    hostname -f 2>/dev/null || hostname
}

zbm_current_user() {
    id -un
}

zbm_is_root() {
    [[ "$(id -u)" -eq 0 ]]
}

zbm_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

zbm_require_command() {
    local cmd="$1"

    if ! zbm_command_exists "${cmd}"; then
        zbm_error "Required command not found: ${cmd}"
        return 1
    fi

    return 0
}

zbm_separator() {
    zbm_hr
}

zbm_pause() {
    read -r -p "Press ENTER to continue..."
}

zbm_die() {
    local message="$1"
    local code="${2:-1}"

    zbm_error "${message}"
    exit "${code}"
}

zbm_print_environment() {

    zbm_separator
    zbm_title "Environment Information"
    zbm_separator

    printf "%-20s : %s\n" "Project"     "${ZBM_PROJECT_NAME}"
    printf "%-20s : %s\n" "Version"     "${ZBM_VERSION}"
    printf "%-20s : %s\n" "Hostname"    "$(zbm_hostname)"
    printf "%-20s : %s\n" "User"        "$(zbm_current_user)"
    printf "%-20s : %s\n" "Date"        "$(zbm_timestamp)"
}

zbm_yes_no() {

    local answer

    while true
    do
        read -r -p "$1 [y/n]: " answer

        case "${answer}" in
            y|Y|yes|YES)
                return 0
                ;;
            n|N|no|NO)
                return 1
                ;;
            *)
                zbm_warn "Please answer y or n."
                ;;
        esac
    done
}

###############################################################################
# debug
#
# Display debug message.
#
# Arguments:
#   $1 Message
#
# Returns:
#   0 Always
###############################################################################

debug()
{
    [[ "${DEBUG:-0}" != "1" ]] && return 0

    printf "[DEBUG] %s\n" "$1"

    return 0
}

###############################################################################
# fatal
#
# Display fatal error message.
#
# Arguments:
#   $1 Message
#
# Returns:
#   Never
###############################################################################

fatal()
{
    error "$1"

    exit "${EXIT_ERROR}"
}
