# Systemd links
# =============
# Systemd unit links (user and system)
#
# Lists the links to enable systemd services and timers. Custom unit files live in the
# related config files; this module only declares the links that turn units on.

############
### User ###
############

CreateLink /home/davi/.config/systemd/user/default.target.wants/easyeffects.service /home/davi/.config/systemd/user/easyeffects.service davi davi
CreateLink /home/davi/.config/systemd/user/default.target.wants/syncthing.service /usr/lib/systemd/user/syncthing.service davi davi
CreateLink /home/davi/.config/systemd/user/default.target.wants/udiskie.service /home/davi/.config/systemd/user/udiskie.service davi davi
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/cliphist.service /home/davi/.config/systemd/user/cliphist.service davi davi
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/hypridle.service /usr/lib/systemd/user/hypridle.service davi davi
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/hyprpolkitagent.service /usr/lib/systemd/user/hyprpolkitagent.service davi davi
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/swaync.service /usr/lib/systemd/user/swaync.service davi davi
CreateLink /home/davi/.config/systemd/user/timers.target.wants/auto-battery-notify.timer /home/davi/.config/systemd/user/auto-battery-notify.timer davi davi

# Files and folders properties
SetFileProperty /home/davi/.config/systemd group davi
SetFileProperty /home/davi/.config/systemd owner davi
SetFileProperty /home/davi/.config/systemd/user group davi
SetFileProperty /home/davi/.config/systemd/user owner davi
SetFileProperty /home/davi/.config/systemd/user/default.target.wants group davi
SetFileProperty /home/davi/.config/systemd/user/default.target.wants owner davi
SetFileProperty /home/davi/.config/systemd/user/graphical-session.target.wants group davi
SetFileProperty /home/davi/.config/systemd/user/graphical-session.target.wants owner davi
SetFileProperty /home/davi/.config/systemd/user/timers.target.wants group davi
SetFileProperty /home/davi/.config/systemd/user/timers.target.wants owner davi

##############
### Global ###
##############

CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.network1.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/sddm.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/graphical.target.wants/udisks2.service /usr/lib/systemd/system/udisks2.service
CreateLink /etc/systemd/system/hibernate.target.wants/minegrub-update.service /etc/systemd/system/minegrub-update.service
CreateLink /etc/systemd/system/multi-user.target.wants/iwd.service /usr/lib/systemd/system/iwd.service
CreateLink /etc/systemd/system/multi-user.target.wants/minegrub-update.service /etc/systemd/system/minegrub-update.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service
CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service
CreateLink /etc/systemd/system/sockets.target.wants/polkit-agent-helper.socket /usr/lib/systemd/system/polkit-agent-helper.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd-varlink.socket /usr/lib/systemd/system/systemd-networkd-varlink.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-resolved-monitor.socket /usr/lib/systemd/system/systemd-resolved-monitor.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-resolved-varlink.socket /usr/lib/systemd/system/systemd-resolved-varlink.socket
CreateLink /etc/systemd/system/sockets.target.wants/systemd-userdbd.socket /usr/lib/systemd/system/systemd-userdbd.socket
CreateLink /etc/systemd/system/sysinit.target.wants/kanata.service /etc/systemd/system/kanata.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-network-generator.service /usr/lib/systemd/system/systemd-network-generator.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/system/timers.target.wants/timeshift-boot.timer /usr/lib/systemd/system/timeshift-boot.timer
CreateLink /etc/systemd/system/timers.target.wants/timeshift-hourly.timer /usr/lib/systemd/system/timeshift-hourly.timer
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
