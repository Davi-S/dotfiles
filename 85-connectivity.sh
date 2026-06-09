# Connectivity configuration
# =====================
# This file includes network, bluetooth and SSH configuration files and packages
#
# The setup uses iwd for wireless network management, and systemd-network for
# wired/wireless management.

CopyFile /etc/systemd/network/20-wired.network
CopyFile /etc/systemd/network/25-wireless.network

# TUI for managing wifi
AddPackage impala # TUI for managing wifi

# iwd is a good replacement for NetworkManager (if combined with some systemd
# services).
# AddPackage iwd # Internet Wireless Daemon
# iwd is already added in the `20-base.sh` file.
CopyFile /var/lib/iwd/126-5G.psk 600
CopyFile /var/lib/iwd/=484644445f322e3447.psk 600
CopyFile /var/lib/iwd/C3SL.8021x
CopyFile /var/lib/iwd/CELU.psk 600
CopyFile /var/lib/iwd/COMODORO_BURGUER.psk 600
CopyFile /var/lib/iwd/Galaxy\ S25\ 53C6.psk 600
CopyFile /var/lib/iwd/HFDD_5G.psk 600
CopyFile /var/lib/iwd/Nobreza\ DDOS.psk 600
CopyFile /var/lib/iwd/UaiFai.psk 600
CopyFile /var/lib/iwd/Uai\ Fai.psk 600
CopyFile /var/lib/iwd/eduroam.8021x
CreateDir /etc/iwd
CreateDir /var/lib/iwd/hotspot 700
CreateFile /var/lib/iwd/UFPR_SEM_FIO.open 600 >/dev/null
SetFileProperty /var/lib/iwd mode 700

# Required to make hotspots and simple DHCP/DNS forwarding work
AddPackage dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server

# Bluetooth stack
AddPackage bluez   # Daemons for the bluetooth protocol stack
AddPackage bluetui # TUI for managing bluetooth devices

AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
CopyFile /home/davi/.ssh/id_ed25519 600 davi davi
CopyFile /home/davi/.ssh/id_ed25519.pub '' davi davi
CopyFile /home/davi/.ssh/known_hosts 600 davi davi
SetFileProperty /home/davi/.ssh group davi
SetFileProperty /home/davi/.ssh mode 700
SetFileProperty /home/davi/.ssh owner davi
SetFileProperty /home/davi/.ssh/known_hosts group ''
SetFileProperty /home/davi/.ssh/known_hosts mode ''
SetFileProperty /home/davi/.ssh/known_hosts owner ''
