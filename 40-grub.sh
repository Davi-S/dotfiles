# Grub and related
# ================
# GRUB bootloader configuration and theme assets
#
# Installs GRUB and related utilities.

AddPackage grub # GNU GRand Unified Bootloader (2)
# GRUB dependency
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager

# For adding Windows in the GRUB menu
AddPackage os-prober # Utility to detect other OSes on a set of drives
CopyFile /etc/default/grub.d/enable-os-prober.cfg

# Set the minegrub theme on grub
CopyFile /etc/default/grub.d/minegrub.cfg
CopyFile /etc/default/grub

# This will set the console background for the theme
# Reference: https://github.com/Lxtharia/minegrub-theme?tab=readme-ov-file#setting-the-console-background
sudo sed --in-place -E 's/(.*)elif(.*"x\$GRUB_BACKGROUND" != x ] && [ -f "\$GRUB_BACKGROUND" ].*)/\1fi; if\2/' "$(GetPackageOriginalFile grub /etc/grub.d/00_header)"
SetFileProperty /etc/grub.d/00_header mode 644

# Minegrub theme files
CopyFile /boot/grub/themes/minegrub/assets/logo_clear.png 755
CopyFile /boot/grub/themes/minegrub/assets/MinecraftRegular-Bmg3.otf 755
CopyFile /boot/grub/themes/minegrub/assets/Monocraft.otf 755
CopyFile /boot/grub/themes/minegrub/assets/splashes.txt 755
CopyFile /boot/grub/themes/minegrub/background.png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/.dummy_file 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.13\ -\ \[Aquatic\ update\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.14\ -\ \[Village\ and\ Pillage\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.15\ -\ \[Buzzy\ Bees\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.16\ -\ \[Nether\ Update\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.17\ -\ \[Caves\ And\ Cliffs\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.18\ -\ \[Caves\ And\ Cliffs\ 2\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.19\ -\ \[The\ Wild\ Update\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.20\ -\ \[Trails\ \&\ Tales\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/1.8\ \ -\ \[Classic\ Minecraft\].png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/Alpha.png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/Alpha\ featuring\ Herobrine.png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/pack.png.png 755
CopyFile /boot/grub/themes/minegrub/backgrounds/The\ End.png 755
CopyFile /boot/grub/themes/minegrub/dirt.png 755
CopyFile /boot/grub/themes/minegrub/item_c.png 755
CopyFile /boot/grub/themes/minegrub/item_e.png 755
CopyFile /boot/grub/themes/minegrub/item_n.png 755
CopyFile /boot/grub/themes/minegrub/item_ne.png 755
CopyFile /boot/grub/themes/minegrub/item_nw.png 755
CopyFile /boot/grub/themes/minegrub/item_s.png 755
CopyFile /boot/grub/themes/minegrub/item_se.png 755
CopyFile /boot/grub/themes/minegrub/item_sw.png 755
CopyFile /boot/grub/themes/minegrub/item_w.png 755
CopyFile /boot/grub/themes/minegrub/logo.png 755
CopyFile /boot/grub/themes/minegrub/Minecraft24.pf2 755
CopyFile /boot/grub/themes/minegrub/Minecraft30.pf2 755
CopyFile /boot/grub/themes/minegrub/Monocraft22.pf2 755
CopyFile /boot/grub/themes/minegrub/selected_item_c.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_e.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_n.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_ne.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_nw.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_s.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_se.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_sw.png 755
CopyFile /boot/grub/themes/minegrub/selected_item_w.png 755
CopyFile /boot/grub/themes/minegrub/static_bar.png 755
CopyFile /boot/grub/themes/minegrub/term_e.png 755
CopyFile /boot/grub/themes/minegrub/term_n.png 755
CopyFile /boot/grub/themes/minegrub/term_ne.png 755
CopyFile /boot/grub/themes/minegrub/term_nw.png 755
CopyFile /boot/grub/themes/minegrub/term_s.png 755
CopyFile /boot/grub/themes/minegrub/term_se.png 755
CopyFile /boot/grub/themes/minegrub/term_sw.png 755
CopyFile /boot/grub/themes/minegrub/term_w.png 755
CopyFile /boot/grub/themes/minegrub/theme.txt 755
CopyFile /boot/grub/themes/minegrub/update_theme.py 755
# This is the service to update the background and logo text on boot
CopyFile /etc/systemd/system/minegrub-update.service
