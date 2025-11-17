# Network configuration
# =====================
# Network configuration files and packages
#
# Declares network-related configuration and packages. The setup uses iwd
# for wireless management, and systemd-network for wired/wireless management.


CopyFile /etc/systemd/network/20-wired.network
CopyFile /etc/systemd/network/25-wireless.network


# iwd is a good replacement for NetworkManager (if combined with some systemd services).
# AddPackage iwd # Internet Wireless Daemon
# iwd is already added in the `20-base.sh` file.
CopyFile /var/lib/iwd/126-5G.psk 600
CopyFile /var/lib/iwd/C3SL.8021x
CopyFile /var/lib/iwd/eduroam.8021x
CopyFile /var/lib/iwd/Nobreza\ DDOS.psk 600
CopyFile /var/lib/iwd/Uai\ Fai.psk 600
CreateDir /etc/iwd
CreateDir /var/lib/iwd/hotspot 700
CreateFile /var/lib/iwd/UFPR-SEM-FIO.open 600 > /dev/null
SetFileProperty /var/lib/iwd mode 700


# Required to make hotspots and simple DHCP/DNS forwarding work
AddPackage dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server


# Bluetooth stack
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack


AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
CopyFile /home/davi/.ssh/known_hosts 600 davi davi
SetFileProperty /home/davi/.ssh group davi
SetFileProperty /home/davi/.ssh mode 700
SetFileProperty /home/davi/.ssh owner davi
