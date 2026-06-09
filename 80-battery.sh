# Battery life and duration
# =========================
# TLP and other battery management options and programs
#
# Defines the packages and configurations for these battery related apps

AddPackage ethtool       # Utility for controlling network drivers and hardware
AddPackage smartmontools # Control and monitor S.M.A.R.T. enabled ATA and SCSI Hard Drives
AddPackage tlp           # Linux Advanced Power Management
AddPackage tlp-pd        # Linux Advanced Power Management - Power Profiles Daemon

# Configs for TLP
CopyFile /etc/tlp.d/processor.conf
CopyFile /etc/tlp.d/radio-device-switching.conf
CopyFile /etc/tlp.d/usb-autosuspend.conf
