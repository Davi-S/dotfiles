# Hyprland and Must-Have apps
# ===========================
# These are the "must-have" apps for Hyprland to work rightly and smoothly.
# Utilities and "good-to-have" packages are found in other the files
#
# Reference: https://wiki.hyprland.org/Useful-Utilities/Must-have/


AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
CopyFile /home/davi/.config/hypr/hyprland-autostart.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-autostart.sh '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-eyecandy.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-input.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-keybindings.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-monitors.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-windowrules.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprland.conf '' davi davi
SetFileProperty /home/davi/.config/hypr group davi
SetFileProperty /home/davi/.config/hypr owner davi


AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal emulator
CopyFile /home/davi/.config/kitty/current-theme.conf '' davi davi
CopyFile /home/davi/.config/kitty/kitty.conf '' davi davi
SetFileProperty /home/davi/.config/kitty group davi
SetFileProperty /home/davi/.config/kitty owner davi


AddPackage swaync # A simple GTK based notification daemon for Sway
# TODO: replaced with the notification daemon from AGS when possible
CopyFile /home/davi/.config/swaync/config.json '' davi davi
CopyFile /home/davi/.config/swaync/style.css '' davi davi
SetFileProperty /home/davi/.config/swaync group davi
SetFileProperty /home/davi/.config/swaync owner davi


# For audio and video
# These are all the packages recommended by the Arch Wiki
# Reference: https://wiki.archlinux.org/title/PipeWire
AddPackage pipewire # Low-latency audio/video router and processor
AddPackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-audio # Low-latency audio/video router and processor - Audio support
AddPackage pipewire-jack # Low-latency audio/video router and processor - JACK replacement
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wireplumber # Session / policy manager implementation for PipeWire
# There are other packages used for better audio lister in other files. These ones are just the essential ones


AddPackage xdg-desktop-portal-hyprland # xdg-desktop-portal backend for hyprland


AddPackage hyprpolkitagent # Simple polkit authentication agent for Hyprland, written in QT/QML


# This is essential for this setup. It will manage the applications using systemd
# Reference: https://github.com/Vladimir-csp/uwsm
AddPackage uwsm # A standalone Wayland session manager
# Use the commands `check-hyprland-slice`, `list-user-units-type`, and `uuctl` (on ~/bin)
# to check if UWSM is working as expected.
# Bellow are symlinks to places where uwsm is used.
CreateLink /home/davi/.config/uwsm/hyprland-autostart.sh /home/davi/.config/hypr/hyprland-autostart.sh davi davi
CreateLink /home/davi/.config/uwsm/hyprland-keybindings.conf /home/davi/.config/hypr/hyprland-keybindings.conf davi davi
SetFileProperty /home/davi/.config/uwsm group davi
SetFileProperty /home/davi/.config/uwsm owner davi
