#!/bin/bash
# Strip any literal single or double quotes passed by the browser
CLEAN_LINK="${1//\'/}"
CLEAN_LINK="${CLEAN_LINK//\"/}"

# Add the magnet link to Superseedr's queue silently
superseedr add "$CLEAN_LINK"
# Check if the main Superseedr TUI is running with pgrep. If it doesn't find it
# launch it.
if ! pgrep -x "superseedr" >/dev/null; then
    kitty superseedr
fi


