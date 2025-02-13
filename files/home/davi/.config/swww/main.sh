#!/usr/bin/env bash

# Main Swww Script
# ================
# This script automates the start and configuration of swww

# Check if swww-daemon is already running and start it
if ! pgrep -x "swww-daemon" &> /dev/null; then
    echo "Starting swww-daemon..."
    uwsm app -t service -- swww-daemon --format xrgb

    # Verify the daemon is running
    if ! swww query &> /dev/null; then
        echo "Failed to start swww-daemon."
        exit 1
    fi
else
    echo "swww-daemon is already running."
fi

# Set background
# swww img ~/Pictures/wallpapers/{wallpaper_file}
swww clear 101319
