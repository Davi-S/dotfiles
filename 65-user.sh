# User
# ====
# User scripts, executables and per-user configuration

# My scripts
CopyFile /home/davi/bin/airplane-mode-control 755 davi davi
CopyFile /home/davi/bin/brightness-control 755 davi davi
CopyFile /home/davi/bin/check-hyprland-slice 755 davi davi
CopyFile /home/davi/bin/datetime-notify 755 davi davi
CopyFile /home/davi/bin/find-obsidian-dead-links 755 davi davi
CopyFile /home/davi/bin/list-user-units-type 755 davi davi
CopyFile /home/davi/bin/test-nerd-fonts 755 davi davi
CopyFile /home/davi/bin/utils.sh '' davi davi
CopyFile /home/davi/bin/volume-control 755 davi davi
CopyFile /home/davi/bin/toggle-float-app 755 davi davi
CopyFile /home/davi/bin/toggle-bluetooth-mic 755 davi davi
SetFileProperty /home/davi/bin group davi
SetFileProperty /home/davi/bin owner davi

# My script published on AUR to notify about the battery
AddPackage --foreign simple-battery-notify # A customizable, D-Bus driven battery notification daemon and CLI

# A script to easily use the phone as the laptop webcam
CopyFile /home/davi/bin/phone-as-webcam 755 davi davi
AddPackage linux-headers      # Headers and scripts for building modules for the Linux kernel
AddPackage v4l2loopback-dkms  # v4l2-loopback device - module sources
AddPackage v4l2loopback-utils # v4l2-loopback device - utilities only

# Service for automatically mounting the phone to the PC when it is connected
CopyFile /home/davi/.config/systemd/user/phone-automount@.service '' davi davi
# Used to connect the phone to the PC
AddPackage --foreign simple-mtpfs # A FUSE filesystem that supports reading/writing from MTP devices
# Script to automatically mount the phone to the PC
CopyFile /home/davi/bin/phone-automount 755 davi davi
# Not a user file, but is used with user files. It acts alongside the
# phone-automount service.
CopyFile /etc/udev/rules.d/99-phone-mount.rules

# To automatically mount pendrives
AddPackage udiskie # Removable disk automounter using udisks
CopyFile /home/davi/.config/systemd/user/udiskie.service '' davi davi

# Primarily used as a dependency of the battery scripts
AddPackage acpi # Client for battery, power, and thermal readings

# Bash config files.
# It is placed here because bash is installed automatically with the packages above,
# so it is only logical to place its config here
CopyFile /home/davi/.bash_profile '' davi davi
CopyFile /home/davi/.bashrc '' davi davi

# A Python script to derive my colors from the catppuccin theme. I use the same
# theme, but with slightly "saturated" colors.
CopyFile /home/davi/.config/colors/create_catppuccin_high_contrast_version.py '' davi davi
SetFileProperty /home/davi/.config/colors group davi
SetFileProperty /home/davi/.config/colors owner davi

# Some generic and unspecific file and folder properties
SetFileProperty /home/davi/.config group davi
SetFileProperty /home/davi/.config owner davi
SetFileProperty /home/davi group davi
SetFileProperty /home/davi mode 700
SetFileProperty /home/davi owner davi
SetFileProperty /home/davi/.local/share group davi
SetFileProperty /home/davi/.local/share owner davi
SetFileProperty /home/davi/.local group davi
SetFileProperty /home/davi/.local owner davi
