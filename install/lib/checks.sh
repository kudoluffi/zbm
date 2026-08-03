#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/checks.sh
# Version   : v0.1.0-alpha
# Revision  : 1
# Purpose   : Environment validation library
# ==========================================================

readonly ZBM_LIB_CHECKS_VERSION="1.0.0"

readonly ZBM_MIN_BASH_MAJOR=5
readonly ZBM_SUPPORTED_UBUNTU=("22.04" "24.04")

zbm_checks_version() {
    printf "%s\n" "${ZBM_LIB_CHECKS_VERSION}"
}

zbm_check_root() {
    if zbm_is_root; then
        zbm_success "Running as root"
        return 0
    fi

    zbm_error "Installer must be executed as root."
    return 1
}

zbm_check_bash() {
    local major="${BASH_VERSINFO[0]}"

    if (( major < ZBM_MIN_BASH_MAJOR )); then
        zbm_error "Bash ${ZBM_MIN_BASH_MAJOR}.x or newer is required."
        return 1
    fi

    zbm_success "Bash ${BASH_VERSION}"
    return 0
}

zbm_check_os() {

    if [[ ! -f /etc/os-release ]]; then
        zbm_error "/etc/os-release not found."
        return 1
    fi

    # shellcheck disable=SC1091
    source /etc/os-release

    if [[ "${ID}" != "ubuntu" ]]; then
        zbm_error "Unsupported OS: ${ID}"
        return 1
    fi

    local supported=0

    for ver in "${ZBM_SUPPORTED_UBUNTU[@]}"; do
        if [[ "${VERSION_ID}" == "${ver}" ]]; then
            supported=1
            break
        fi
    done

    if [[ "${supported}" -eq 0 ]]; then
        zbm_error "Ubuntu ${VERSION_ID} is not supported."
        return 1
    fi

    zbm_success "Ubuntu ${VERSION_ID}"
}

zbm_check_zimbra_user() {

    if id zimbra >/dev/null 2>&1; then
        zbm_success "User 'zimbra' found"
        return 0
    fi

    zbm_error "User 'zimbra' does not exist."
    return 1
}

zbm_check_zimbra_installation() {

    if [[ ! -d /opt/zimbra ]]; then
        zbm_error "/opt/zimbra not found."
        return 1
    fi

    if [[ ! -x /opt/zimbra/bin/zmcontrol ]]; then
        zbm_error "zmcontrol not found."
        return 1
    fi

    zbm_success "Zimbra installation detected"
    return 0
}

zbm_check_required_commands() {

    local commands=(
        bash
        mkdir
        cp
        chmod
        chown
        tar
        gzip
        awk
        sed
        grep
    )

    local failed=0

    for cmd in "${commands[@]}"; do
        if zbm_command_exists "${cmd}"; then
            zbm_success "Dependency: ${cmd}"
        else
            zbm_error "Missing dependency: ${cmd}"
            failed=1
        fi
    done

    return "${failed}"
}

zbm_run_preflight_checks() {

    zbm_separator
    zbm_title "Running Preflight Checks"
    zbm_separator

    zbm_check_root                || return 1
    zbm_check_os                  || return 1
    zbm_check_bash                || return 1
    zbm_check_required_commands   || return 1
    zbm_check_zimbra_user         || return 1
    zbm_check_zimbra_installation || return 1

    zbm_success "All preflight checks passed."

    return 0
}
