# This file contains SDDM, temes, and related pakages

AddPackage sddm # QML based X11 and Wayland display manager

# For qt5 support on sddm (and suport on general stuf)
AddPackage layer-shell-qt5 # Qt 5 component to allow applications to make use of the Wayland wl-layer-shell protocol
AddPackage qt5-quickcontrols2 # Next generation user interface controls based on Qt Quick
AddPackage layer-shell-qt # Qt component to allow applications to make use of the Wayland wl-layer-shell protocol

# Set SDDM itself to run on wayland with hyprland as compositor, and set the hyprland config
CopyFile /etc/sddm.conf.d/10-wayland.conf
CopyFile /etc/sddm.conf.d/15-hyprland.conf

# Set the current SDDM theme
CopyFile /etc/sddm.conf.d/20-theme.conf

# Sddm themes files
CopyFile /usr/share/sddm/themes/minesddm/Main.qml
CopyFile /usr/share/sddm/themes/minesddm/components/CustomButton.qml
CopyFile /usr/share/sddm/themes/minesddm/components/CustomText.qml
CopyFile /usr/share/sddm/themes/minesddm/components/PasswordTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/components/SessionHandler.qml
CopyFile /usr/share/sddm/themes/minesddm/components/TextFieldBackground.qml
CopyFile /usr/share/sddm/themes/minesddm/components/UsernameTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/images/background.png
CopyFile /usr/share/sddm/themes/minesddm/images/button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/disabled_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/selected_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/metadata.desktop
CopyFile /usr/share/sddm/themes/minesddm/minesddm_preview_3.png
CopyFile /usr/share/sddm/themes/minesddm/resources/MinecraftRegular-Bmg3.otf
CopyFile /usr/share/sddm/themes/minesddm/resources/Monocraft.otf
CopyFile /usr/share/sddm/themes/minesddm/theme.conf
