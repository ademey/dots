#!/usr/bin/env bash
#
# pass-menu.sh - Password selector using tofi
#
# Requirements:
#   pass, tofi, wl-copy, gpg-agent (for authentication)
#
# Usage:
#   Bind to a key in your Hyprland config:
#   bind = $mainMod, P, exec, pass-menu.sh
#

set -euo pipefail

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

function notify() {
    if command -v notify-send &>/dev/null; then
        notify-send "$1" "$2"
    fi
}

function list_passwords() {
    # Find all .gpg files and strip the prefix and suffix
    find "$PASSWORD_STORE_DIR" -type f -name '*.gpg' 2>/dev/null | \
        sed -e "s|$PASSWORD_STORE_DIR/||" -e 's|\.gpg$||' | \
        sort
}

function main() {
    local passwords
    passwords=$(list_passwords)

    if [ -z "$passwords" ]; then
        notify "Pass Menu" "No passwords found in store"
        exit 1
    fi

    # Show password list in tofi
    local selected
    selected=$(echo "$passwords" | tofi --prompt-text=" pass: ") || exit 0

    if [ -z "$selected" ]; then
        exit 0
    fi

    # If called from GUI (no TTY), open terminal for GPG auth
    if [ ! -t 0 ]; then
        kitty --class "pass-prompt" -e bash -c "pass -c '$selected' && notify-send 'Pass Menu' 'Copied $selected to clipboard (45s)' || notify-send 'Pass Menu' 'Failed to copy password'"
    else
        # Copy password to clipboard (pass -c copies for 45 seconds by default)
        if pass -c "$selected"; then
            notify "Pass Menu" "Copied $selected to clipboard (45s)"
        else
            notify "Pass Menu" "Failed to copy password"
            exit 1
        fi
    fi
}

main "$@"
