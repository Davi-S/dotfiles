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


# For synching the Obsidian vault between the computer and the phone
AddPackage syncthing # Open Source Continuous Replication / Cluster Synchronization Thing


# For connecting the phone to the laptop
AddPackage kdeconnect # Adds communication between KDE and your smartphone


AddPackage qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
CopyFile /home/davi/.config/qBittorrent/ayuDark.qbtheme '' davi davi
SetFileProperty /home/davi/.config/qBittorrent group davi
SetFileProperty /home/davi/.config/qBittorrent owner davi


AddPackage --foreign zen-browser-bin # Performance oriented Firefox-based web browser


AddPackage obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files


# Installed this to have noise reduction
# It is useful for other audio effects too
AddPackage easyeffects # Audio Effects for Pipewire applications
CopyFile /home/davi/.config/easyeffects/db/easyeffectsrc 600 davi davi
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


# To view system usage
AddPackage htop # Interactive process viewer
CopyFile /home/davi/.config/htop/htoprc 600 davi davi
SetFileProperty /home/davi/.config/htop group davi
SetFileProperty /home/davi/.config/htop mode 700
SetFileProperty /home/davi/.config/htop owner davi


# Installed when I was looking for what was taking up my storage space
AddPackage ncdu # Disk usage analyzer with an ncurses interface


# Whatsapp for terminal
AddPackage --foreign nchat # console-based chat client with support for Telegram
CopyFile /home/davi/.config/nchat/app.conf 600 davi davi
CopyFile /home/davi/.config/nchat/ui.conf 600 davi davi
CopyFile /home/davi/.config/nchat/usercolor.conf '' davi davi
SetFileProperty /home/davi/.config/nchat group davi
SetFileProperty /home/davi/.config/nchat mode 700
SetFileProperty /home/davi/.config/nchat owner davi


# File explorer for terminal
AddPackage yazi # Blazing fast terminal file manager written in Rust, based on async I/O
CopyFile /home/davi/.config/yazi/keymap.toml '' davi davi
CopyFile /home/davi/.config/yazi/yazi.toml '' davi davi
SetFileProperty /home/davi/.config/yazi group davi
SetFileProperty /home/davi/.config/yazi owner davi
# Dependency for PDF preview on yazi
AddPackage poppler # PDF rendering library based on xpdf 3.0


# This is a video player, but I'm also using it as an image player. I'm doing
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
CreateLink /home/davi/.local/bin/subliminal /home/davi/.local/share/pipx/venvs/subliminal/bin/subliminal davi davi


# For editing images
AddPackage gimp # GNU Image Manipulation Program


# Doom that runs on the terminal
CopyFile /home/davi/Games/terminal-doom/.savegame/doomsav0.dsg '' davi davi
CopyFile /home/davi/Games/terminal-doom/zig-out/bin/terminal-doom 755 davi davi
SetFileProperty /home/davi/Games group davi
SetFileProperty /home/davi/Games owner davi
SetFileProperty /home/davi/Games/terminal-doom group davi
SetFileProperty /home/davi/Games/terminal-doom owner davi
SetFileProperty /home/davi/Games/terminal-doom/.savegame group davi
SetFileProperty /home/davi/Games/terminal-doom/.savegame owner davi
SetFileProperty /home/davi/Games/terminal-doom/zig-out group davi
SetFileProperty /home/davi/Games/terminal-doom/zig-out owner davi
SetFileProperty /home/davi/Games/terminal-doom/zig-out/bin group davi
SetFileProperty /home/davi/Games/terminal-doom/zig-out/bin owner davi
