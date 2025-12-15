# System utilities and helper packages
# ====================================
# Installs system-level helper packages that don't neatly fit into the other files.
# 
# This grouping contains tools for system restore, package building, AUR support
# utility daemons, helpers, and a few user-oriented tools.
#
# Most stuff here are indirectly used by the user, or are dependencies of the
# system/config files. Important stuff.
# 
# Small and not so important utilities belong somewhere else.


AddPackage timeshift # A system restore utility for Linux
AddPackage --foreign timeshift-systemd-timer # Add systemd support for timeshift
CopyFile /etc/timeshift/timeshift.json '' '' ''


AddPackage --foreign paru # Feature packed AUR helper
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
AddPackage hyprlock # hyprland’s GPU-accelerated screen locking utility
CopyFile /home/davi/.config/hypr/hyprlock.conf '' davi davi


# For managing idle time. It reduces brightness, locks, and suspends the pc when idle
AddPackage hypridle # hyprland’s idle daemon 
CopyFile /home/davi/.config/hypr/hypridle.conf '' davi davi
