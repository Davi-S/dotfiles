# Base and system essential packages
# ==================================
# Minimal set of core packages required for a usable Arch Linux system.
#
# This file lists low-level packages that are typically installed during OS
# installation or are necessary for system boot, firmware, package management
# and basic user operations.
# 
# Keep this list lean—other utilities belong in separate feature files.


AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage btrfs-progs # BTRFS filesystem utilities
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux
AddPackage linux-lts # The LTS Linux kernel and modules
AddPackage sudo # Give certain users the ability to run some commands as root
# `nano`` is just a "fallback" for the main editor `nvim`.`
AddPackage nano # Pico editor clone with enhancements
AddPackage iwd # Internet Wireless Daemon
