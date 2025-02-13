#!/usr/bin/env bash

# Hyprland Autostart Script
# =========================
# This script automates the execution of processes and settings that you would
# typically configure in your Hyprland configuration file.
# The use of a bash script allows to a more elaborated logic

# Remember to always start applications and processes using uwsm
# Reference: https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#3-applications-and-slices
UWSM="uwsm app -t service --"


# Start necessary processes
$UWSM swaync &
~/.config/swww/main.sh &

# Set cursor theme and size using hyprctl
hyprctl setcursor "Bibata-Modern-Ice" 20

# Set cursor theme and size using gsettings (to make cursor work with gtk apps)
gsettings set org.gnome.desktop.interface cursor-size 20
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
