##################### Unknown packages ####################

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


################# Unknown foreign packages ################




################### New / changed files ###################

# This is the redefinition of the initial ignore path list from the aconfmgr source code
# I have comented out "home". This includes it on the configuration
ignore_paths=(
    '/dev'
    # '/home'
    '/media'
    '/mnt'
    '/proc'
    '/root'
    '/run'
    '/sys'
    '/tmp'
    # '/var/.updated'
    '/var/cache'
    # '/var/lib'
    # '/var/lock'
    # '/var/log'
    # '/var/spool'
)

IgnorePath "/home/davi/.config/aconfmgr/*"
IgnorePath "/home/davi/.cargo/*"
IgnorePath "/home/davi/.bash_history"
IgnorePath "/home/davi/.cache/*"
IgnorePath "/home/davi/.local/share/*"
IgnorePath "/home/davi/.local/state/*"
IgnorePath "/home/davi/.config/systemd/*"
IgnorePath "/home/davi/.mozilla/*"

IgnorePath "/boot/amd-ucode.img"
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

IgnorePath "/usr/bin/*"
IgnorePath "/usr/lib/*"
IgnorePath "/usr/share/applications/*"
IgnorePath "/usr/share/glib-2.0/*"
IgnorePath "/usr/share/icons/*"
IgnorePath "/usr/share/info/*"
IgnorePath "/usr/share/mime/*"

IgnorePath "/var/.updated"
IgnorePath "/var/db/*"
IgnorePath "/var/lib/*"
IgnorePath "/var/log/*"
IgnorePath "/var/tmp/*"
