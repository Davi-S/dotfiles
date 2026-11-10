# Hyprland and Must-Have apps
# ===========================
# These are the "must-have" apps for Hyprland to work rightly and smoothly.
# Utilities and "good-to-have" packages are found in other the files
#
# Reference: https://wiki.hyprland.org/Useful-Utilities/Must-have/

AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
CopyFile /home/davi/.config/hypr/.luarc.json '' davi davi
CopyFile /home/davi/.config/hypr/catppuccin-mocha.conf '' davi davi
CopyFile /home/davi/.config/hypr/catppuccin-mocha.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-autostart.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-eyecandy.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-float-tuis.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-input.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-keybindings.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-monitors.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland-windowrules.lua '' davi davi
CopyFile /home/davi/.config/hypr/hyprland.lua '' davi davi
SetFileProperty /home/davi/.config/hypr group davi
SetFileProperty /home/davi/.config/hypr owner davi

AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal emulator
CopyFile /home/davi/.config/kitty/diff-mocha.conf '' davi davi
CopyFile /home/davi/.config/kitty/float-tui.conf '' davi davi
CopyFile /home/davi/.config/kitty/kitty.conf '' davi davi
CopyFile /home/davi/.config/kitty/mocha.conf '' davi davi
CopyFile /home/davi/.config/kitty/mocha-overrides.conf '' davi davi
CopyFile /home/davi/.config/kitty/sessions/nchat.session '' davi davi
CopyFile /home/davi/.config/kitty/sessions/nvim_whatsapp.session '' davi davi
CopyFile /home/davi/.config/kitty/sessions/obsidian_tui.session '' davi davi
SetFileProperty /home/davi/.config/kitty group davi
SetFileProperty /home/davi/.config/kitty owner davi
SetFileProperty /home/davi/.config/kitty/sessions group davi
SetFileProperty /home/davi/.config/kitty/sessions owner davi

AddPackage --foreign swaync-git # A simple notification daemon with a GTK panel for checking previous notifications like other DEs
# AddPackage swaync # A simple GTK based notification daemon for Sway
# TODO: replaced with the notification daemon from AGS when possible
CopyFile /home/davi/.config/swaync/config.json '' davi davi
CopyFile /home/davi/.config/swaync/style.css '' davi davi
SetFileProperty /home/davi/.config/swaync group davi
SetFileProperty /home/davi/.config/swaync owner davi

# For audio and video
# These are all the packages recommended by the Arch Wiki
# Reference: https://wiki.archlinux.org/title/PipeWire
AddPackage pipewire       # Low-latency audio/video router and processor
AddPackage pipewire-alsa  # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-audio # Low-latency audio/video router and processor - Audio support
AddPackage pipewire-jack  # Low-latency audio/video router and processor - JACK replacement
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wireplumber    # Session / policy manager implementation for PipeWire
# There are other packages used for better audio lister in other files. These ones are just the essential ones

# For controlling media players with the media keys
AddPackage playerctl # mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.

AddPackage xdg-desktop-portal-hyprland # xdg-desktop-portal backend for hyprland

AddPackage hyprpolkitagent # Simple polkit authentication agent for Hyprland, written in QT/QML
# Theme for the apps built on hyprtoolkit, like the polkit password dialog
CopyFile /home/davi/.config/hypr/hyprtoolkit.conf '' davi davi

# This is essential for this setup. It will manage the applications using
# systemd. Reference: https://github.com/Vladimir-csp/uwsm
AddPackage uwsm # A standalone Wayland session manager
# Bellow are symlinks to places where uwsm is used.
CreateLink /home/davi/.config/uwsm/hyprland-uwsm.desktop /usr/share/wayland-sessions/hyprland-uwsm.desktop davi davi
CreateLink /home/davi/.config/uwsm/sway-uwsm.desktop /usr/share/wayland-sessions/sway-uwsm.desktop davi davi
SetFileProperty /home/davi/.config/uwsm group davi
SetFileProperty /home/davi/.config/uwsm owner davi
