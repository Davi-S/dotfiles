# User
# ====
# User scripts, executables and per-user configuration


# My scripts
CopyFile /home/davi/bin/airplane-mode-control 755 davi davi
CopyFile /home/davi/bin/battery-notify 755 davi davi
CopyFile /home/davi/bin/brightness-control 755 davi davi
CopyFile /home/davi/bin/caffeine 755 davi davi
CopyFile /home/davi/bin/check-hyprland-slice 755 davi davi
CopyFile /home/davi/bin/datetime-notify 755 davi davi
CopyFile /home/davi/bin/fetch-battery-info 755 davi davi
CopyFile /home/davi/bin/find-obsidian-dead-links 755 davi davi
CopyFile /home/davi/bin/list-user-units-type 755 davi davi
CopyFile /home/davi/bin/test-nerd-fonts 755 davi davi
CopyFile /home/davi/bin/utils.sh '' davi davi
CopyFile /home/davi/bin/volume-control 755 davi davi
SetFileProperty /home/davi/bin group davi
SetFileProperty /home/davi/bin owner davi


# Auto battery-notify and its services
# The link to enable these services is in the systemd aconfmgr config file
CopyFile /home/davi/.config/systemd/user/auto-battery-notify.service '' davi davi
CopyFile /home/davi/.config/systemd/user/auto-battery-notify.timer '' davi davi
CopyFile /home/davi/bin/auto-battery-notify 755 davi davi


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


# Some generic and unspecifc file and folder properties
SetFileProperty /home/davi/.config group davi
SetFileProperty /home/davi/.config owner davi
SetFileProperty /home/davi group davi
SetFileProperty /home/davi mode 700
SetFileProperty /home/davi owner davi
SetFileProperty /home/davi/.local/share group davi
SetFileProperty /home/davi/.local/share owner davi
SetFileProperty /home/davi/.local group davi
SetFileProperty /home/davi/.local owner davi


# This folder keeps being created. These are for gtk theming
CreateDir /home/davi/.config/gtk-3.0 700 davi davi
CopyFile /home/davi/.config/gtk-3.0/settings.ini '' davi davi
CreateDir /home/davi/.config/gtk-4.0 700 davi davi
SetFileProperty /home/davi/.config/gtk-4.0 group davi
