#!/usr/bin/env bash

# Hyprland Autostart Script
# =========================
# This script automates the execution of processes and settings that you would
# typically configure in your Hyprland configuration file.
# The use of a bash script allows to a more elaborated logic
#
# This file should contain only graphical applications. Hyprland is a window
# manager, so if an application does not need a window, it does not need
# hyprland. There is no need to bind a application/setting to hyprland when it
# is not needed. If you need to autostart a service or application that does
# not need a window, use systemd.


# Remember to always start applications and processes using uwsm
# Reference: https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#3-applications-and-slices
uwsm="uwsm app -t service --"


# When using other window managers alongside with hyprland they can overide this
# environment variable. It is good to set this everytime hyprland starts to
# prevent any errors. This is commented here just to clarify. The actual
# exporting is made on the hyprland config files.
# export XDG_CURRENT_DESKTOP=Hyprland


################################
### Start apps and processes ###
################################


# Web browser
$uwsm zen-browser


# Open a kitty instance with a window for
# - Git TUI (lazygit) for the main obsidian vault
# - nvim (replacing the obsidian app)
# This instance will have the stack layout. This means that each window will
# take the whole screen while the others are hidden.
#
# Write the configuration to a temporary file in /tmp
cat <<EOF > /tmp/obsidiantui.conf
layout stack
cd ~/Documents/ObsidianAllInVault/
launch sh -c "nvim -c 'Daily' .; exec bash"
launch sh -c "lazygit; exec bash"
EOF
# Launch Kitty pointing to that file
# Set a custom class to be able to move it later
$uwsm kitty --class obsidiantui --session /tmp/obsidiantui.conf


# Whatsapp on terminal
# Write the configuration to a temporary file in /tmp
cat <<EOF > /tmp/nchat.conf
launch sh -c "nchat; exec bash"
EOF
# Set a custom class to be able to move it later
$uwsm kitty --class nchat --session /tmp/nchat.conf


# Move the windows to the correct workspaces. This can't be done by using
# windowrules because the title of the window is dynamic; and because we only
# want to move it once, and not every time is opens
sleep 1
hyprctl dispatch movetoworkspacesilent 9, class:nchat
hyprctl dispatch movetoworkspacesilent 10, class:obsidiantui

