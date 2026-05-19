# Grub and related
# ================
# GRUB bootloader configuration and theme assets
#
# Installs GRUB and related utilities.

AddPackage grub # GNU GRand Unified Bootloader (2)
# GRUB dependency
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager
# Update the grub config
CopyFile /etc/default/grub

# For adding Windows in the GRUB menu
AddPackage os-prober # Utility to detect other OSes on a set of drives

# Set the minegrub theme on grub
# Download the AUR packages
AddPackage --foreign grub-theme-minegrub           # A Grub Theme in the style of Minecraft!
AddPackage --foreign minegrub-theme-update-service # A systemd service that automatically updates the minegrub theme
# Pillow and fastfetch primarily used as a dependency of the "minegrub" GRUB theme
AddPackage python-pillow # Python Imaging Library (PIL) fork
AddPackage fastfetch     # A feature-rich and performance oriented neofetch like system information tool
# This command will set the console background for the theme
# Reference: https://github.com/Lxtharia/minegrub-theme?tab=readme-ov-file#setting-the-console-background
sudo sed --in-place -E 's/(.*)elif(.*"x\$GRUB_BACKGROUND" != x ] && [ -f "\$GRUB_BACKGROUND" ].*)/\1fi; if\2/' "$(GetPackageOriginalFile grub /etc/grub.d/00_header)"
SetFileProperty /etc/grub.d/00_header mode 775
