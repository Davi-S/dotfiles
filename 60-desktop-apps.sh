# Desktop applications
# ====================
# Desktop applications and user-level config
#
# Installs various desktop utilities. Usually UI applications.

# App launcher and clipboard history menus (replaced rofi). The launcher is my
# own script.
AddPackage fzf # Command-line fuzzy finder
CopyFile /home/davi/.config/fzf/launcher '' davi davi
SetFileProperty /home/davi/.config/fzf group davi
SetFileProperty /home/davi/.config/fzf owner davi
CopyFile /home/davi/bin/app-launcher 755 davi davi
# Needed to open terminal apps from the app launcher
AddPackage xdg-terminal-exec # Proposal for XDG Default Terminal Execution Specification and shell-based reference implementation

# Scientific calculator with gui
AddPackage qalculate-gtk # GTK frontend for libqalculate
CopyFile /home/davi/.config/qalculate/qalc.cfg '' davi davi
CopyFile /home/davi/.config/qalculate/qalculate-gtk.cfg '' davi davi
SetFileProperty /home/davi/.config/qalculate group davi
SetFileProperty /home/davi/.config/qalculate owner davi

# For connecting the phone to the laptop
AddPackage kdeconnect # Adds communication between KDE and your smartphone

# Torrent client for magnetic links on the browser
AddPackage --foreign superseedr # A BitTorrent Client in your Terminal
CopyFile /home/davi/bin/superseedr-magnet-handler.sh 755 davi davi
CopyFile /home/davi/.local/share/applications/superseedr.desktop '' davi davi
SetFileProperty /home/davi/.local/share/applications group davi
SetFileProperty /home/davi/.local/share/applications mode 700
SetFileProperty /home/davi/.local/share/applications owner davi

# Torrent client for searching and downloading without browser
AddPackage --foreign torlink # A sleek, zero-setup torrent finder and downloader that lives right in your terminal
CopyFile /home/davi/.config/torlink/config.json '' davi davi
SetFileProperty /home/davi/.config/torlink group davi
SetFileProperty /home/davi/.config/torlink owner davi

AddPackage --foreign zen-browser-bin # Performance oriented Firefox-based web browser
AddPackage chromium # A web browser built for speed, simplicity, and security

# Office suite ("fresh" is the branch with the newest features)
AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements

AddPackage obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files

# General electron apps flags
# Set electron apps so use wayland
CopyFile /home/davi/.config/electron-flags.conf '' davi davi

# This is for setting default apps
CopyFile /home/davi/.config/mimeapps.list 600 davi davi

# This is a video player, but I'm also using it as an image viewer. I'm doing
# this by setting a custom config directory with many dedicated scripts and
# configs. Also, I'm setting a aliases and custom wayland class name for it
AddPackage mpv # a free, open source, and cross-platform media player
CopyFile /home/davi/.config/mpv/.gitignore '' davi davi
CopyFile /home/davi/.config/mpv/.gitmodules '' davi davi
CopyFile /home/davi/.config/mpv/input.conf '' davi davi
CopyFile /home/davi/.config/mpv/mpv.conf '' davi davi
CopyFile /home/davi/.config/mpv/script-opts/modernx.conf '' davi davi
CopyFile /home/davi/.config/mpv/script-opts/thumbfast.conf '' davi davi
CopyFile /home/davi/.config/mpv/scripts/autosub.lua '' davi davi
CopyFile /home/davi/.config/mpv/update.sh 755 davi davi
CopyFile /home/davi/.config/mpv/vendor/ModernX/.git '' davi davi
CopyFile /home/davi/.config/mpv/vendor/ModernX/README.md '' davi davi
CopyFile /home/davi/.config/mpv/vendor/ModernX/fluent-system-icons.ttf '' davi davi
CopyFile /home/davi/.config/mpv/vendor/ModernX/modernx.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/ModernX/preview.png '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/.git '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/.gitignore '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/LICENSE '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/README.md '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/autosubsync.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/helpers.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/main.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/menu.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/autosubsync-mpv/subtitle.lua '' davi davi
CopyFile /home/davi/.config/mpv/vendor/thumbfast/.git '' davi davi
CopyFile /home/davi/.config/mpv/vendor/thumbfast/LICENSE '' davi davi
CopyFile /home/davi/.config/mpv/vendor/thumbfast/README.md '' davi davi
CopyFile /home/davi/.config/mpv/vendor/thumbfast/thumbfast.conf '' davi davi
CopyFile /home/davi/.config/mpv/vendor/thumbfast/thumbfast.lua '' davi davi
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
CreateLink /home/davi/.config/mpv/fonts/fluent-system-icons.ttf ../vendor/ModernX/fluent-system-icons.ttf davi davi
CreateLink /home/davi/.config/mpv/scripts/autosubsync ../vendor/autosubsync-mpv davi davi
CreateLink /home/davi/.config/mpv/scripts/modernx.lua ../vendor/ModernX/modernx.lua davi davi
CreateLink /home/davi/.config/mpv/scripts/thumbfast.lua ../vendor/thumbfast/thumbfast.lua davi davi
SetFileProperty /home/davi/.config/mpv group davi
SetFileProperty /home/davi/.config/mpv owner davi
SetFileProperty /home/davi/.config/mpv/fonts group davi
SetFileProperty /home/davi/.config/mpv/fonts owner davi
SetFileProperty /home/davi/.config/mpv/script-opts group davi
SetFileProperty /home/davi/.config/mpv/script-opts owner davi
SetFileProperty /home/davi/.config/mpv/scripts group davi
SetFileProperty /home/davi/.config/mpv/scripts owner davi
SetFileProperty /home/davi/.config/mpv/scripts/autosubsync group davi
SetFileProperty /home/davi/.config/mpv/scripts/autosubsync owner davi
SetFileProperty /home/davi/.config/mpv/vendor group davi
SetFileProperty /home/davi/.config/mpv/vendor owner davi
SetFileProperty /home/davi/.config/mpv/vendor/ModernX group davi
SetFileProperty /home/davi/.config/mpv/vendor/ModernX owner davi
SetFileProperty /home/davi/.config/mpv/vendor/autosubsync-mpv group davi
SetFileProperty /home/davi/.config/mpv/vendor/autosubsync-mpv owner davi
SetFileProperty /home/davi/.config/mpv/vendor/thumbfast group davi
SetFileProperty /home/davi/.config/mpv/vendor/thumbfast owner davi
SetFileProperty /home/davi/.config/mvi group davi
SetFileProperty /home/davi/.config/mvi owner davi
SetFileProperty /home/davi/.config/mvi/script-opts group davi
SetFileProperty /home/davi/.config/mvi/script-opts owner davi
SetFileProperty /home/davi/.config/mvi/scripts group davi
SetFileProperty /home/davi/.config/mvi/scripts owner davi

# subliminal is installed with pipx used for automatically downloading subtitles
# for mpv
AddPackage --foreign alass # Automatic Language-Agnostic Subtitle Synchronization

# For downloading videos (also lets mpv play URLs)
AddPackage yt-dlp # A youtube-dl fork with additional features and fixes
CopyFile /home/davi/.config/yt-dlp/config 600 davi davi
SetFileProperty /home/davi/.config/yt-dlp group davi
SetFileProperty /home/davi/.config/yt-dlp mode 700
SetFileProperty /home/davi/.config/yt-dlp owner davi

# For editing images
AddPackage gimp # GNU Image Manipulation Program

# Bisq and Bisq2 for trading bitcoin. Requires that jre21
AddPackage --foreign bisq2        # The Decentralized Trading Platform
AddPackage --foreign bisq-desktop # Cross-platform desktop application that allows users to trade national currency (dollars, euros, etc) for bitcoin without relying on centralized exchanges

# GTK theme. The theme name is also set in gsettings, which is not a file and
# is not tracked here.
AddPackage adw-gtk-theme # Unofficial GTK 3 port of the libadwaita theme
CreateDir /home/davi/.config/gtk-3.0 700 davi davi
CopyFile /home/davi/.config/gtk-3.0/gtk.css '' davi davi
CopyFile /home/davi/.config/gtk-3.0/settings.ini '' davi davi
CreateDir /home/davi/.config/gtk-4.0 700 davi davi
CopyFile /home/davi/.config/gtk-4.0/gtk.css '' davi davi
SetFileProperty /home/davi/.config/gtk-4.0 group davi

# Qt theme
AddPackage qt6ct # Qt 6 Configuration Utility
CopyFile /home/davi/.config/qt6ct/colors/catppuccin-mocha.conf '' davi davi
CopyFile /home/davi/.config/qt6ct/qt6ct.conf '' davi davi
SetFileProperty /home/davi/.config/qt6ct/colors group davi
SetFileProperty /home/davi/.config/qt6ct/colors owner davi
SetFileProperty /home/davi/.config/qt6ct group davi
SetFileProperty /home/davi/.config/qt6ct owner davi

# Cursor theme
AddPackage --foreign catppuccin-cursors-mocha # Soothing pastel mouse cursors - Mocha

# Minecraft launcher
AddPackage prismlauncher # Minecraft launcher with ability to manage multiple instances

# Steam laucher. Requires enabling the multilib repository
AddPackage steam # Valve's digital software delivery system

# Used to control audio input/output via TUI
AddPackage pulsemixer # CLI and curses mixer for pulseaudio
CopyFile /home/davi/.config/pulsemixer.cfg '' davi davi

# Settings for the Galaxy Buds 
AddPackage --foreign galaxybudsclient-bin # Unofficial manager for the Samsung Galaxy Buds, Buds+, Buds Live and Buds Pro

# Configures gaming mice
AddPackage piper # GTK application to configure gaming mice
