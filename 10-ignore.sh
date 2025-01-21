## Unknown packages ##

# These packages are installed during OS instalation
IgnorePackage amd-ucode
IgnorePackage base
IgnorePackage btrfs-progs
IgnorePackage efibootmgr
IgnorePackage grub
IgnorePackage linux
IgnorePackage linux-firmware
IgnorePackage linux-lts
IgnorePackage sudo

## Unknown foreign packages ##

## New / changed files ##

IgnorePath "/boot/EFI/*"

# TODO: Manage GRUB themes
IgnorePath "/boot/grub/*"

IgnorePath "/boot/initramfs-linux-fallback.img"
IgnorePath "/boot/initramfs-linux-lts-fallback.img"
IgnorePath "/boot/initramfs-linux-lts.img"
IgnorePath "/boot/initramfs-linux.img"

IgnorePath "/boot/vmlinuz-linux"
IgnorePath "/boot/vmlinuz-linux-lts"

IgnorePath "/etc/.pwd.lock"
IgnorePath "/etc/.updated"
IgnorePath "/etc/NetworkManager/*"
IgnorePath "/etc/adjtime"

IgnorePath "/etc/ca-certificates/*"

IgnorePath "/etc/fonts/*"

IgnorePath "/etc/fstab"
IgnorePath "/etc/group"
IgnorePath "/etc/group-"
IgnorePath "/etc/gshadow"
IgnorePath "/etc/gshadow-"
IgnorePath "/etc/hostname"
IgnorePath "/etc/ld.so.cache"
IgnorePath "/etc/locale.conf"
IgnorePath "/etc/locale.gen"
IgnorePath "/etc/localtime"
IgnorePath "/etc/machine-id"

IgnorePath "/etc/mkinitcpio.d/*"

IgnorePath "/etc/os-release"

IgnorePath "/etc/pacman.d/*"

IgnorePath "/etc/passwd"
IgnorePath "/etc/passwd-"
IgnorePath "/etc/resolv.conf"

IgnorePath "/etc/shadow"
IgnorePath "/etc/shadow-"

IgnorePath "/etc/shells"

IgnorePath "/etc/ssh/*"

IgnorePath "/etc/ssl/*"

IgnorePath "/etc/subgid"
IgnorePath "/etc/subgid-"
IgnorePath "/etc/subuid"
IgnorePath "/etc/subuid-"

IgnorePath "/etc/sudoers"

# Systemd services
IgnorePath "/etc/systemd/*"

IgnorePath "/etc/vconsole.conf"

IgnorePath "/swap/*"

IgnorePath "/usr/lib/*"
IgnorePath "/usr/share/*"

IgnorePath "/var/.updated"
IgnorePath "/var/db/*"
IgnorePath "/var/lib/*"
IgnorePath "/var/log/*"
IgnorePath "/var/tmp/*"

## New file properties

IgnorePath "/boot/amd-ucode.img"
IgnorePath "/usr/bin/*"
IgnorePath "/var/log/*"
IgnorePath "/var/tmp/*"
