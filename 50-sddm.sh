# SDDM and related
# ================
# Display manager and session theme assets
#
# Installs SDDM and the auxiliary components.

AddPackage sddm # QML based X11 and Wayland display manager

# My SDDM theme
AddPackage --foreign sddm-minesddm-theme # A Minecraft SDDM theme
# Necessary to make the theme work properly
AddPackage --foreign layer-shell-qt5 # Qt 5 component to allow applications to make use of the Wayland wl-layer-shell protocol

# Config file for themes
CopyFile /etc/sddm.conf.d/20-theme.conf
CopyFile /usr/share/sddm/themes/minesddm/theme.conf.user
