#!/usr/bin/env bash

# Hyprland Autostart Script
# =========================
# This script automates the execution of processes and settings that you would
# typically configure in your Hyprland configuration file.
# The use of a bash script allows to a more elaborated logic
#
# This file should contain only graphical applications. Hyprland is a window manager,
# so if an application does not need a window, it does not need hyprland. There is 
# no need to bind a application/setting to hyprland when it is not needed.
# If you need to autostart a service or application that does not need a window, use systemd.
 

# Remember to always start applications and processes using uwsm
# Reference: https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#3-applications-and-slices
uwsm="uwsm app -t service --"


# When using other window managers alongside with hyprland they can overide this
# environment variable. It is good to set this everytime hyprland starts to prevent
# any errors. This is commented here just to clarify. The actual exporting is made
# on the hyprland config files.
# export XDG_CURRENT_DESKTOP=Hyprland


################################
### Start apps and processes ###
################################

# Starting it here and not automatically because one may
# want to use other idle service when using other Desktop
# environment. Hypridle is too much hyprland oriented
systemctl --user start hypridle.service

# Notification deamon
$uwsm swaync &

# Listen to clipboard changes
$uwsm wl-paste --watch cliphist store  

# Web browser
# $uwsm firefox
$uwsm zen-browser

# Obsidian
$uwsm obsidian

# Git TUI for the main obsidian vault
$uwsm kitty lazygit -p ~/Documents/ObsidianAllInVault/
# Move the window to the correct workspace. This can't be done by using windowrules
# because the title of the window is dynamic; and because we only want to move it
# once, and not every time is opens
sleep 1 && hyprctl dispatch movetoworkspacesilent 9,title:lazygit

