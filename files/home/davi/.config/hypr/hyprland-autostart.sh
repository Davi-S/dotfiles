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

# Obsidian workflow using nvim
# Set a custom class to be able to set window rules for it 
$uwsm kitty --class obsidian_tui --session /home/davi/.config/kitty/sessions/obsidian_tui.session

# Whatsapp on the terminal
# Set a custom class to be able to set window rules for it
$uwsm kitty --class nchat --session /home/davi/.config/kitty/sessions/nchat.session
