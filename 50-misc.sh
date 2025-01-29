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

# Ok browser
AddPackage firefox # Fast, Private & Safe Web Browser

# Very customizable app launcher
AddPackage rofi # A window switcher, application launcher and dmenu replacement
# If Albert laucher app have a option to app a prefix (for use with uwsm) it is best than rofi

################# Foreign #################

# The aconfmgr it self
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

# Main package manager
AddPackage --foreign paru # Feature packed AUR helper
AddPackage --foreign paru-debug # Detached debugging symbols for paru


################# Files ###################

# Changed to allow hibernating
CopyFile /etc/mkinitcpio.conf.d/hooks.conf

# Timeshift configuration
CopyFile /etc/timeshift/timeshift.json
# Remember to correct the device uuid for the machine
