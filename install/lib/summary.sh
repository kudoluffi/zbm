#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/summary.sh
# Version   : v0.1.0-alpha
# Revision  : 1
# Purpose   : Installation summary library
# ==========================================================

readonly ZBM_LIB_SUMMARY_VERSION="1.0.0"

declare -ag ZBM_SUMMARY_ITEMS=()

zbm_summary_version() {
    printf "%s\n" "${ZBM_LIB_SUMMARY_VERSION}"
}

zbm_summary_add() {
    local status="$1"
    local message="$2"

    ZBM_SUMMARY_ITEMS+=("${status}|${message}")
}

zbm_summary_ok() {
    zbm_summary_add "OK" "$1"
}

zbm_summary_warn() {
    zbm_summary_add "WARN" "$1"
}

zbm_summary_error() {
    zbm_summary_add "ERROR" "$1"
}

zbm_summary_print() {

    local item
    local status
    local message

    zbm_separator
    zbm_title "Installation Summary"
    zbm_separator

    if [[ ${#ZBM_SUMMARY_ITEMS[@]} -eq 0 ]]; then
        zbm_warn "No summary information available."
        return 0
    fi

    for item in "${ZBM_SUMMARY_ITEMS[@]}"
    do
        status="${item%%|*}"
        message="${item#*|}"

        case "${status}" in
            OK)
                zbm_success "${message}"
                ;;
            WARN)
                zbm_warn "${message}"
                ;;
            ERROR)
                zbm_error "${message}"
                ;;
            *)
                printf "[%s] %s\n" "${status}" "${message}"
                ;;
        esac
    done

    zbm_separator

    printf "%-20s : %s\n" "Project"  "${ZBM_PROJECT_NAME}"
    printf "%-20s : %s\n" "Version"  "${ZBM_VERSION}"
    printf "%-20s : %s\n" "Hostname" "$(zbm_hostname)"
    printf "%-20s : %s\n" "Finished" "$(zbm_timestamp)"

    zbm_separator
}
