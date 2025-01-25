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

# For qt5 support on sddm (and suport on general stuf)
AddPackage layer-shell-qt5 # Qt 5 component to allow applications to make use of the Wayland wl-layer-shell protocol
AddPackage qt5-quickcontrols2 # Next generation user interface controls based on Qt Quick
AddPackage layer-shell-qt # Qt component to allow applications to make use of the Wayland wl-layer-shell protocol

# Notification deamon
AddPackage swaync # A simple GTK based notification daemon for Sway

# Bellow are pipiwire and related packages recomended by the Arch Wiki
AddPackage pipewire # Low-latency audio/video router and processor
AddPackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-audio # Low-latency audio/video router and processor - Audio support
AddPackage pipewire-jack # Low-latency audio/video router and processor - JACK replacement
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wireplumber # Session / policy manager implementation for PipeWire

# XDG Desktop Portal for hyprland
AddPackage xdg-desktop-portal-hyprland # xdg-desktop-portal backend for hyprland

# Authenticatior agent for hyprland
AddPackage hyprpolkitagent # Simple polkit authentication agent for Hyprland, written in QT/QML
# Remember to enabled hyprpolkitagent service (https://wiki.hyprland.org/Hypr-Ecosystem/hyprpolkitagent/)

################# Foreign #################

# The aconfmgr it self
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux

# Main package manager
AddPackage --foreign paru # Feature packed AUR helper
AddPackage --foreign paru-debug # Detached debugging symbols for paru

# For managing hyprland and systemd
AddPackage --foreign uwsm # A standalone Wayland session manager


################# Files ###################

# Timeshift configuration
CopyFile /etc/timeshift/timeshift.json
# Remember to correct the device uuid for the machine

# Changed to allow hibernating
CopyFile /etc/mkinitcpio.conf.d/hooks.conf

# Set SDDM itself to run on wayland
CopyFile /etc/sddm.conf.d/10-wayland.conf

# Set SDDM theme
CopyFile /etc/sddm.conf.d/20-theme.conf

# Sddm themes files
CopyFile /usr/share/sddm/themes/minesddm/Main.qml
CopyFile /usr/share/sddm/themes/minesddm/components/CustomButton.qml
CopyFile /usr/share/sddm/themes/minesddm/components/CustomText.qml
CopyFile /usr/share/sddm/themes/minesddm/components/PasswordTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/components/SessionHandler.qml
CopyFile /usr/share/sddm/themes/minesddm/components/TextFieldBackground.qml
CopyFile /usr/share/sddm/themes/minesddm/components/UsernameTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/images/background.png
CopyFile /usr/share/sddm/themes/minesddm/images/button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/disabled_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/selected_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/metadata.desktop
CopyFile /usr/share/sddm/themes/minesddm/minesddm_preview_3.png
CopyFile /usr/share/sddm/themes/minesddm/resources/MinecraftRegular-Bmg3.otf
CopyFile /usr/share/sddm/themes/minesddm/resources/Monocraft.otf
CopyFile /usr/share/sddm/themes/minesddm/theme.conf

# Environment variables for UWSM
CopyFile /etc/profile.d/uwsm.sh
