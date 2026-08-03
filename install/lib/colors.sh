#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/colors.sh
# Version   : v0.1.0-alpha
# Revision  : 1
# Purpose   : Color and console output library
# ==========================================================

readonly ZBM_LIB_COLORS_VERSION="1.0.0"

# ANSI colors
readonly ZBM_CLR_RESET="\033[0m"
readonly ZBM_CLR_RED="\033[0;31m"
readonly ZBM_CLR_GREEN="\033[0;32m"
readonly ZBM_CLR_YELLOW="\033[1;33m"
readonly ZBM_CLR_BLUE="\033[0;34m"
readonly ZBM_CLR_CYAN="\033[0;36m"
readonly ZBM_CLR_WHITE="\033[1;37m"
readonly ZBM_CLR_BOLD="\033[1m"

# Can be disabled with:
# export ZBM_NO_COLOR=1
if [[ -n "${ZBM_NO_COLOR:-}" ]] || [[ ! -t 1 ]]; then
    readonly ZBM_CLR_RESET=""
    readonly ZBM_CLR_RED=""
    readonly ZBM_CLR_GREEN=""
    readonly ZBM_CLR_YELLOW=""
    readonly ZBM_CLR_BLUE=""
    readonly ZBM_CLR_CYAN=""
    readonly ZBM_CLR_WHITE=""
    readonly ZBM_CLR_BOLD=""
fi

zbm_lib_version() {
    printf "%s\n" "$ZBM_LIB_COLORS_VERSION"
}

zbm_color_echo() {
    local color="$1"
    shift
    printf "%b%s%b\n" "${color}" "$*" "${ZBM_CLR_RESET}"
}

zbm_info()    { zbm_color_echo "${ZBM_CLR_BLUE}"   "[INFO]    $*"; }
zbm_success() { zbm_color_echo "${ZBM_CLR_GREEN}"  "[OK]      $*"; }
zbm_warn()    { zbm_color_echo "${ZBM_CLR_YELLOW}" "[WARN]    $*"; }
zbm_error()   { zbm_color_echo "${ZBM_CLR_RED}"    "[ERROR]   $*" >&2; }
zbm_title()   { zbm_color_echo "${ZBM_CLR_CYAN}${ZBM_CLR_BOLD}" "$*"; }

zbm_hr() {
    printf "%80s\n" "" | tr " " "="
}

zbm_banner() {
    zbm_hr
    zbm_title "Zimbra Backup Manager (ZBM)"
    printf "Version : %s\n" "v0.1.0-alpha"
    zbm_hr
}
