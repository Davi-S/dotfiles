# Desktop applications
# ====================
# Desktop applications and user-level config
#
# Installs various desktop utilities. Usually UI applications.

AddPackage rofi # A window switcher, application launcher and dmenu replacement

# Scientific calculator with gui
AddPackage qalculate-gtk # GTK frontend for libqalculate
CopyFile /home/davi/.config/qalculate/qalc.cfg '' davi davi
CopyFile /home/davi/.config/qalculate/qalculate-gtk.cfg '' davi davi
SetFileProperty /home/davi/.config/qalculate group davi
SetFileProperty /home/davi/.config/qalculate owner davi

# For connecting the phone to the laptop
AddPackage kdeconnect # Adds communication between KDE and your smartphone

AddPackage --foreign superseedr # A BitTorrent Client in your Terminal
CopyFile /home/davi/bin/superseedr-magnet-handler.sh 755 davi davi
CopyFile /home/davi/.local/share/applications/superseedr.desktop '' davi davi
SetFileProperty /home/davi/.local/share/applications group davi
SetFileProperty /home/davi/.local/share/applications mode 700
SetFileProperty /home/davi/.local/share/applications owner davi

AddPackage --foreign zen-browser-bin # Performance oriented Firefox-based web browser

AddPackage obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files

# Installed this to have noise reduction
# It is useful for other audio effects too
AddPackage easyeffects # Audio Effects for Pipewire applications
CreateDir /home/davi/.config/easyeffects/autoload '' davi davi
SetFileProperty /home/davi/.config/easyeffects group davi
SetFileProperty /home/davi/.config/easyeffects owner davi
SetFileProperty /home/davi/.config/easyeffects/db group davi
SetFileProperty /home/davi/.config/easyeffects/db owner davi
CopyFile /home/davi/.config/easyeffects/db/deepfilternetrc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/echoCancellerrc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/filterrc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/gaterc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/rnnoiserc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/speexrc 600 davi davi
CopyFile /home/davi/.config/easyeffectsrc 600 davi davi
CopyFile /home/davi/.config/easyeffects/db/easyeffectsrc 600 davi davi
# This is a systemd service to start the easyeffects interfaceless.
# The link to enable it is in the systemd aconfmgr config file
CopyFile /home/davi/.config/systemd/user/easyeffects.service '' davi davi
# Optional plugins for easy effects
AddPackage lsp-plugins                         # Collection of open-source plugins
AddPackage --foreign libdeep_filter_ladspa-git # A Low Complexity Speech Enhancement Framework for Full-Band Audio (48kHz) using Deep Filtering (Git version) - ladspa plugin

# General electron apps flags
# Set electron apps so use wayland
CopyFile /home/davi/.config/electron-flags.conf '' davi davi

# This is for setting default apps
CopyFile /home/davi/.config/mimeapps.list 599 davi davi
SetFileProperty /home/davi/.config/mimeapps.list mode 600

# This is a video player, but I'm also using it as an image viewer. I'm doing
# this by setting a custom config directory with many dedicated scripts and
# configs. Also, I'm setting a aliases and custom wayland class name for it
AddPackage mpv # a free, open source, and cross-platform media player
CopyFile /home/davi/.config/mpv/fonts/Material-Design-Iconic-Font.ttf '' davi davi
CopyFile /home/davi/.config/mpv/input.conf '' davi davi
CopyFile /home/davi/.config/mpv/mpv.conf '' davi davi
CopyFile /home/davi/.config/mpv/scripts-opts/thumbfast.conf '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosub.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosubsync/autosubsync.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosubsync/helpers.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosubsync/main.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosubsync/menu.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosubsync/subtitle.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/modernx.lua '' davi davi
CopyFile /home/davi/.config/mpv/scripts/thumbfast.lua '' davi davi
CopyFile /home/davi/.config/mvi/README.md '' davi davi
CopyFile /home/davi/.config/mvi/UNLICENSE '' davi davi
CopyFile /home/davi/.config/mvi/input.conf '' davi davi
CopyFile /home/davi/.config/mvi/mpv.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/crop.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/delete_file.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/detect_image.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/image_positioning.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/minimap.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/ruler.conf '' davi davi
CopyFile /home/davi/.config/mvi/script-opts/status_line.conf '' davi davi
CopyFile /home/davi/.config/mvi/scripts/crop.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/delete_file.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/detect-image.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/equalizer.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/freeze-window.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/image-positioning.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/minimap.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/ruler.lua '' davi davi
CopyFile /home/davi/.config/mvi/scripts/status-line.lua '' davi davi
SetFileProperty /home/davi/.config/mpv group davi
SetFileProperty /home/davi/.config/mpv owner davi
SetFileProperty /home/davi/.config/mpv/fonts group davi
SetFileProperty /home/davi/.config/mpv/fonts owner davi
SetFileProperty /home/davi/.config/mpv/scripts group davi
SetFileProperty /home/davi/.config/mpv/scripts owner davi
SetFileProperty /home/davi/.config/mpv/scripts-opts group davi
SetFileProperty /home/davi/.config/mpv/scripts-opts owner davi
SetFileProperty /home/davi/.config/mpv/scripts/autosubsync group davi
SetFileProperty /home/davi/.config/mpv/scripts/autosubsync owner davi
SetFileProperty /home/davi/.config/mvi group davi
SetFileProperty /home/davi/.config/mvi owner davi
SetFileProperty /home/davi/.config/mvi/script-opts group davi
SetFileProperty /home/davi/.config/mvi/script-opts owner davi
SetFileProperty /home/davi/.config/mvi/scripts group davi
SetFileProperty /home/davi/.config/mvi/scripts owner davi
# subliminal installed with pipx used for automatically downloading subtitles
# for mpv

# For editing images
AddPackage gimp # GNU Image Manipulation Program

# Bisq and Bisq2 for trading bitcoin. Requires that jre21
AddPackage --foreign bisq2        # The Decentralized Trading Platform
AddPackage --foreign bisq-desktop # Cross-platform desktop application that allows users to trade national currency (dollars, euros, etc) for bitcoin without relying on centralized exchanges

# This folder keeps being created. These are for gtk theming
CreateDir /home/davi/.config/gtk-3.0 700 davi davi
CopyFile /home/davi/.config/gtk-3.0/settings.ini '' davi davi
CreateDir /home/davi/.config/gtk-4.0 700 davi davi
SetFileProperty /home/davi/.config/gtk-4.0 group davi

# Minecraft launcher
AddPackage prismlauncher # Minecraft launcher with ability to manage multiple instances

# Steam laucher. Requires enabling the multilib repository
AddPackage steam # Valve's digital software delivery system
