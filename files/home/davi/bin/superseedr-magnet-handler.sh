#!/usr/bin/env bash

# Superseedr Magnet Handler
# =========================
# A utility to add magnet links to Superseedr from the browser.
#
# Usage:
#     $0 <magnet_link>
#
# Arguments:
#     <magnet_link>    The magnet URI string.
#
# Notes:
#     - Automatically launches the Superseedr TUI in kitty if not already running.
# ==========================
### END USAGE

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
source "$SCRIPT_DIR/utils.sh"
check_help_flag "$@"

if [[ -z "$1" ]]; then
    echo "Error: No magnet link provided."
    exit 1
fi

# Strip any literal single or double quotes passed by the browser
CLEAN_LINK="${1//\'/}"
CLEAN_LINK="${CLEAN_LINK//\"/}"

# Add the magnet link to Superseedr's queue silently
superseedr add "$CLEAN_LINK"

# Check if the main Superseedr TUI is running
if ! pgrep -x "superseedr" >/dev/null; then
    kitty --class superseedr_float -e superseedr
fi
