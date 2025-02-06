################# Packages #################

# For building apps from source
AddPackage base-devel # Basic tools to build Arch Linux packages

# For using git
AddPackage git # the fast distributed version control system

# Simple text editor
AddPackage nano # Pico editor clone with enhancements

# For connecting to wifi
AddPackage networkmanager # Network connection manager and user applications
# Remember to enable and start the service after install
# sudo nmcli dev wifi connect [network-ssid] --ask

# For connecting through ssh
AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
# Remember to enable and start the service after install

# For creating and restoring snapshots
AddPackage timeshift # A system restore utility for Linux

# An ok browser
AddPackage firefox # Fast, Private & Safe Web Browser

# Very customizable app launcher
AddPackage rofi-wayland # A window switcher, run dialog and dmenu replacement - fork with wayland support
# If Albert laucher app have a option to app a prefix (for use with uwsm) it is best than rofi

# A better-than-bash shell
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX

# Some good nerd font
AddPackage ttf-jetbrains-mono-nerd # Patched font JetBrains Mono from nerd fonts library

# For changing wallpaper
AddPackage hyprpaper # a blazing fast wayland wallpaper utility with IPC controls
# Remember to start the service `systemctl --user enable --now hyprpaper.service`.
# Reference: https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/

# For sending notifications
AddPackage libnotify # Library for sending desktop notifications

# For getting battery info
AddPackage acpi # Client for battery, power, and thermal readings
# primarilly used as a dependency for the battery user scripts

# For setting the cursor and other settings for gtk
AddPackage nwg-look # GTK settings editor adapted to work on wlroots-based compositors


################# Foreign #################

# The aconfmgr it self
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

# Main package manager
AddPackage --foreign paru # Feature packed AUR helper
AddPackage --foreign paru-debug # Detached debugging symbols for paru

# For using systemd timer instead of cron jobs for timeshift
AddPackage --foreign timeshift-systemd-timer # Add systemd support for timeshift
# Remember to enable `sudo systemctl enable --now timeshift-hourly.timer`

# These are the cursor files (xcursor and hyprcursor)
AddPackage --foreign bibata-cursor-git # Bibata Cursor Themes, including hyprcursor and Xcursor
# You need to soft link the Bibata-Modern-Ice theme from `/usr/share/icons` to `~/.local/share/icons`
# for hyprcursor to work. You can delete other unused theme files


################# Files ###################

# Changed to allow hibernating
CopyFile /etc/mkinitcpio.conf.d/hooks.conf

# Timeshift configuration
CopyFile /etc/timeshift/timeshift.json
# Remember to correct the device uuid for the machine

# To make hyprland service itself to be placed into "session.slice" instead of "app.slice"
CopyFile /usr/share/wayland-sessions/hyprland-uwsm.desktop
# Reference: https://github.com/Vladimir-csp/uwsm?tab=readme-ov-file#3-applications-and-slices
# This is the recommended by UWSM.
# I tried to use environment variables but they weren't working, so I added the "-S"
# option in the ".desktop" file
