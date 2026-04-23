# Sway
# ====
# Sway fallback configuration
#
# Sway-related packages and configuration. Sway is only used as a fallback
# compositor for when Hyprland is unavailable.

# Only sway-specific thing belong here. Features used "also" by Sways are kept
# in other modules.

AddPackage sway     # Tiling Wayland compositor and replacement for the i3 window manager
AddPackage swayidle # Idle management daemon for Wayland
AddPackage swaylock # Screen locker for Wayland

CopyFile /home/davi/.config/sway/config '' davi davi
CopyFile /usr/share/wayland-sessions/sway-uwsm.desktop
SetFileProperty /home/davi/.config/sway group davi
SetFileProperty /home/davi/.config/sway owner davi
