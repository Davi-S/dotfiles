# Desktop applications
# ====================
# Desktop applications and user-level config
#
# Installs various desktop utilities. Usually UI applications.


AddPackage rofi # A window switcher, application launcher and dmenu replacement


# For using rofi as a calculator
AddPackage rofi-calc # Do calculations in rofi
CopyFile /home/davi/.config/qalculate/qalc.cfg '' davi davi
SetFileProperty /home/davi/.config/qalculate group davi
SetFileProperty /home/davi/.config/qalculate owner davi


# Scientific calculator with gui
AddPackage qalculate-gtk # GTK frontend for libqalculate
CopyFile /home/davi/.config/qalculate/qalculate-gtk.cfg '' davi davi


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

# This is a systemd service to start the easyeffects interfaceless.
# The link to enable it is in the systemd aconfmgr config file
CopyFile /home/davi/.config/systemd/user/easyeffects.service '' davi davi
# Optional plugins for easy effects
AddPackage lsp-plugins # Collection of open-source plugins
AddPackage --foreign libdeep_filter_ladspa-git # A Low Complexity Speech Enhancement Framework for Full-Band Audio (48kHz) using Deep Filtering (Git version) - ladspa plugin

# General electron flags
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
