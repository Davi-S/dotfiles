# Systemd links
# =============
# Systemd unit links (user and system)
#
# Lists the links to enable systemd services and timers. Custom unit files live in the
# related config files; this module only declares the links that turn units on.

############
### User ###
############

CreateLink /home/davi/.config/systemd/user/default.target.wants/battery-notify.service /usr/lib/systemd/user/battery-notify.service davi davi             # For sending notifications about the battery
CreateLink /home/davi/.config/systemd/user/default.target.wants/udiskie.service /home/davi/.config/systemd/user/udiskie.service davi davi                 # udiskie for automatically mounting removable drives
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/cliphist.service /home/davi/.config/systemd/user/cliphist.service davi davi     # Clipboard history
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/hypridle.service /usr/lib/systemd/user/hypridle.service davi davi               # Automatically lock the screen and suspend the computer
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/hyprpolkitagent.service /usr/lib/systemd/user/hyprpolkitagent.service davi davi # Graphical authentication for apps that requires root privileges
CreateLink /home/davi/.config/systemd/user/graphical-session.target.wants/swaync.service /usr/lib/systemd/user/swaync.service davi davi                   # Notifications
CreateLink /home/davi/.config/systemd/user/default.target.wants/hyprcaffeine.service /home/davi/.config/systemd/user/hyprcaffeine.service davi davi       # For restoring the previous state after reboot

# Files and folders properties
SetFileProperty /home/davi/.config/systemd group davi
SetFileProperty /home/davi/.config/systemd owner davi
SetFileProperty /home/davi/.config/systemd/user group davi
SetFileProperty /home/davi/.config/systemd/user owner davi
SetFileProperty /home/davi/.config/systemd/user/default.target.wants group davi
SetFileProperty /home/davi/.config/systemd/user/default.target.wants owner davi
SetFileProperty /home/davi/.config/systemd/user/graphical-session.target.wants group davi
SetFileProperty /home/davi/.config/systemd/user/graphical-session.target.wants owner davi

##############
### Global ###
##############

CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service                                            # Bluetooth
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service                                                              # Bluetooth
CreateLink /etc/systemd/system/dbus-org.freedesktop.network1.service /usr/lib/systemd/system/systemd-networkd.service                                        # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service /usr/lib/systemd/system/systemd-resolved.service                                        # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/dbus-org.freedesktop.timesync1.service /usr/lib/systemd/system/systemd-timesyncd.service                                      # Sincronizes clock with internet
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/sddm.service                                                                  # Login screen
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service                                                  # Login screen for TTY if no graphical interface available
CreateLink /etc/systemd/system/graphical.target.wants/udisks2.service /usr/lib/systemd/system/udisks2.service                                                # For automatically mounting removable drives
CreateLink /etc/systemd/system/hibernate.target.wants/minegrub-update.service /etc/systemd/system/minegrub-update.service                                    # Update the theme of the SDDM
CreateLink /etc/systemd/system/multi-user.target.wants/iwd.service /usr/lib/systemd/system/iwd.service                                                       # For WiFi
CreateLink /etc/systemd/system/multi-user.target.wants/minegrub-update.service /etc/systemd/system/minegrub-update.service                                   # Update the theme of the SDDM
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target                                             # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service                                                     # SSH daemon
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-networkd.service /usr/lib/systemd/system/systemd-networkd.service                             # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service /usr/lib/systemd/system/systemd-networkd-wait-online.service # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sockets.target.wants/polkit-agent-helper.socket /usr/lib/systemd/system/polkit-agent-helper.socket                            # Graphical authentication
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd-varlink.socket /usr/lib/systemd/system/systemd-networkd-varlink.socket                  # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sockets.target.wants/systemd-networkd.socket /usr/lib/systemd/system/systemd-networkd.socket                                  # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sockets.target.wants/systemd-resolved-monitor.socket /usr/lib/systemd/system/systemd-resolved-monitor.socket                  # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sockets.target.wants/systemd-resolved-varlink.socket /usr/lib/systemd/system/systemd-resolved-varlink.socket                  # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sockets.target.wants/systemd-userdbd.socket /usr/lib/systemd/system/systemd-userdbd.socket                                    # User and groups lookup
CreateLink /etc/systemd/system/sysinit.target.wants/kanata.service /etc/systemd/system/kanata.service                                                        # Keyboard layout
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-network-generator.service /usr/lib/systemd/system/systemd-network-generator.service              # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-resolved.service /usr/lib/systemd/system/systemd-resolved.service                                # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service                              # Low level network (DNS, IP, interface, etc...)
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/wireplumber.service                                                      # Audio and video
CreateLink /etc/systemd/user/pipewire.service.wants/wireplumber.service /usr/lib/systemd/user/wireplumber.service                                            # Audio and video
CreateLink /etc/systemd/user/sockets.target.wants/p11-kit-server.socket /usr/lib/systemd/user/p11-kit-server.socket                                          # Graphical authentication
CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket                                          # Audio and video
CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket                                                      # Audio and video
