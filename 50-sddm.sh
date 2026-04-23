# SDDM and related
# ================
# Display manager and session theme assets
#
# Installs SDDM and the auxiliary components.

AddPackage sddm # QML based X11 and Wayland display manager

# Necessary to make the themes work properly
AddPackage --foreign layer-shell-qt5 # Qt 5 component to allow applications to make use of the Wayland wl-layer-shell protocol
AddPackage layer-shell-qt            # Qt component to allow applications to make use of the Wayland wl-layer-shell protocol
AddPackage qt5-quickcontrols2        # Next generation user interface controls based on Qt Quick

# Config file for themes
CopyFile /etc/sddm.conf.d/20-theme.conf

# MineSDDM theme files
CopyFile /usr/share/sddm/themes/minesddm/components/CustomButton.qml
CopyFile /usr/share/sddm/themes/minesddm/components/CustomText.qml
CopyFile /usr/share/sddm/themes/minesddm/components/Formatter.qml
CopyFile /usr/share/sddm/themes/minesddm/components/PasswordTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/components/SessionHandler.qml
CopyFile /usr/share/sddm/themes/minesddm/components/TextFieldBackground.qml
CopyFile /usr/share/sddm/themes/minesddm/components/UsernameTextField.qml
CopyFile /usr/share/sddm/themes/minesddm/images/background.png
CopyFile /usr/share/sddm/themes/minesddm/images/button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/disabled_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/disabled_small_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/selected_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/selected_small_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/images/small_button_background.png
CopyFile /usr/share/sddm/themes/minesddm/Main.qml
CopyFile /usr/share/sddm/themes/minesddm/metadata.desktop
CopyFile /usr/share/sddm/themes/minesddm/minesddm_preview_3.png
CopyFile /usr/share/sddm/themes/minesddm/resources/MinecraftRegular-Bmg3.otf
CopyFile /usr/share/sddm/themes/minesddm/resources/Monocraft.otf
CopyFile /usr/share/sddm/themes/minesddm/theme.conf
CopyFile /usr/share/sddm/themes/minesddm/theme.conf.user

# Primarily used as a dependency of the "minegrub" GRUB theme
AddPackage python-pillow # Python Imaging Library (PIL) fork

# Primarily used as a dependency of the "minegrub" GRUP theme,
AddPackage fastfetch # A feature-rich and performance oriented neofetch like system information tool
