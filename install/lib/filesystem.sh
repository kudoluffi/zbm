#!/usr/bin/env bash
#
# ==========================================================
# Zimbra Backup Manager (ZBM)
# File      : install/lib/filesystem.sh
# Version   : v0.1.0-alpha
# Revision  : 1
# Purpose   : Filesystem helper library
# ==========================================================

readonly ZBM_LIB_FILESYSTEM_VERSION="1.0.0"

zbm_filesystem_version(){ printf "%s
" "$ZBM_LIB_FILESYSTEM_VERSION"; }

zbm_directory_exists(){ [[ -d "$1" ]]; }
zbm_file_exists(){ [[ -f "$1" ]]; }

zbm_create_directory(){
    local dir="$1"
    local mode="${2:-755}"
    local owner="${3:-root:root}"
    if zbm_directory_exists "$dir"; then
        zbm_info "Directory exists: $dir"
    else
        mkdir -p "$dir" || return 1
        zbm_success "Created: $dir"
    fi
    chmod "$mode" "$dir"
    chown "$owner" "$dir"
}

zbm_copy_file(){
    local src="$1" dst="$2" mode="${3:-644}" owner="${4:-root:root}"
    [[ -f "$src" ]] || { zbm_error "Source not found: $src"; return 1; }
    mkdir -p "$(dirname "$dst")"
    cp -f "$src" "$dst" || return 1
    chmod "$mode" "$dst"
    chown "$owner" "$dst"
    zbm_success "Installed: $dst"
}

zbm_create_symlink(){
    local target="$1" link="$2"
    ln -sfn "$target" "$link"
    zbm_success "Symlink: $link -> $target"
}

zbm_check_writable(){
    [[ -w "$1" ]]
}

zbm_validate_path(){
    local p="$1"
    [[ -e "$p" ]] || { zbm_error "Missing path: $p"; return 1; }
    return 0
}

zbm_prepare_install_dirs(){
    local dirs=(
        /usr/local/zbm
        /usr/local/zbm/lib
        /etc/zbm
        /var/log/zbm
        /var/lib/zbm
        /var/cache/zbm
        /backup/zimbra
    )
    local d
    for d in "${dirs[@]}"; do
        zbm_create_directory "$d" 755 root:root || return 1
    done
}
