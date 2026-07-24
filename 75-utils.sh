# Utilities and helper packages
# ====================================
# Installs system-level helper and user-level helpers packages that don't
# neatly fit into the other files.
#
# This grouping contains tools for system restore, package building, AUR support
# utility daemons, helpers, and a few user-oriented tools.
#
# Most stuff here are indirectly used by the user, or are dependencies of the
# system/config files. Important stuff.
#
# Small and not so important utilities belong somewhere else.

AddPackage --foreign paru       # Feature packed AUR helper
AddPackage --foreign paru-debug # Detached debugging symbols for paru

AddPackage libnotify # Library for sending desktop notifications

# Primarily used to build packages from code
AddPackage base-devel # Basic tools to build Arch Linux packages

# For controlling brightness
AddPackage brightnessctl # Lightweight brightness control tool

# The aconfmgr itself
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

# For saving and managing clipboard history
AddPackage cliphist # wayland clipboard manager
# The link to enable the service is in 70-systemd.sh file
CopyFile /home/davi/.config/systemd/user/cliphist.service '' davi davi

# Good to have
AddPackage arch-wiki-docs # Pages from Arch Wiki optimized for offline browsing

# Enable hibernation
CopyFile /etc/mkinitcpio.conf.d/hooks.conf

# For taking screen shots
AddPackage hyprshot # Hyprland screenshot utility
# This will replace grim and slurp by automating the processes of taking the
# screenshot and saving it

# For locking the pc
AddPackage hyprlock # hyprland's GPU-accelerated screen locking utility
CopyFile /home/davi/.config/hypr/hyprlock.conf '' davi davi

# For managing idle time. It reduces brightness, locks, and suspends the pc when idle
AddPackage hypridle # hyprland's idle daemon
CopyFile /home/davi/.config/hypr/hypridle.conf '' davi davi

# For not letting the PC suspend or lock screen
AddPackage --foreign expresso # A Rofi-based system awake and sleep inhibition utility
CopyFile /home/davi/.config/expresso/expresso.conf '' davi davi
SetFileProperty /home/davi/.config/expresso group davi
SetFileProperty /home/davi/.config/expresso owner davi

# For forcing the PC to suspend after some time
AddPackage --foreign decaf # A Rofi-based sleep timer utility

# To view system usage
AddPackage btop # A monitor of system resources, bpytop ported to C++
CopyFile /home/davi/.config/btop/btop.conf '' davi davi
CopyFile /home/davi/.config/btop/themes/catppuccin-mocha.theme '' davi davi
SetFileProperty /home/davi/.config/btop/themes group davi
SetFileProperty /home/davi/.config/btop/themes owner davi
SetFileProperty /home/davi/.config/btop group davi
SetFileProperty /home/davi/.config/btop owner davi

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

# For unzipping zip files
AddPackage unzip # For extracting and viewing files in .zip archives

# This is a "replacement" for rm.
# See the .bashrc file for the alises used alongside this
AddPackage trash-cli # Command line trashcan (recycle bin) interface

# Included multilib (primarily to install a Minecraft launcher)
CopyFile /etc/pacman.conf

# To see PDF files on the terminal
AddPackage --foreign tdf # A TUI-based PDF viewer
