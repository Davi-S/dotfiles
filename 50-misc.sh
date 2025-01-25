################# Packages #################

# For building from source
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

# My primary wayland compositor
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor

# My primary terminal emulator
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal emulator

# My primary display manager
AddPackage sddm # QML based X11 and Wayland display manager

# For qt5 support on sddm
AddPackage layer-shell-qt5 # Qt 5 component to allow applications to make use of the Wayland wl-layer-shell protocol


################# Foreign #################

# The aconfmgr it self
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

# Main package manager
AddPackage --foreign paru # Feature packed AUR helper
AddPackage --foreign paru-debug # Detached debugging symbols for paru

# For managing hyprland and systemd
AddPackage --foreign uwsm # A standalone Wayland session manager


###########################################

# Timeshift configuration
CopyFile /etc/timeshift/timeshift.json
# Remember to correct the device uuid for the machine

# Changed to allow hibernating
CopyFile /etc/mkinitcpio.conf.d/hooks.conf

# Sets SDDM itself to run on wayland
CopyFile /etc/sddm.conf.d/10-wayland.conf
