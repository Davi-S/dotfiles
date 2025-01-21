### Packages ###

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

# The aconfmgr it self
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

#############

# Timeshift configuration
CopyFile /etc/timeshift/timeshift.json
