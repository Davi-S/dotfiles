# This file contains my home folder and personal dotfiles


SetFileProperty /home/davi group davi
SetFileProperty /home/davi mode 700
SetFileProperty /home/davi owner davi


CopyFile /home/davi/.bash_profile '' davi davi
CopyFile /home/davi/.bashrc '' davi davi


CopyFile /home/davi/.zcompdump '' davi davi
CopyFile /home/davi/.zprofile '' davi davi
CopyFile /home/davi/.zshenv '' davi davi
CopyFile /home/davi/.zshrc '' davi davi


CopyFile /home/davi/.gitconfig '' davi davi


CopyFile /home/davi/Pictures/wallpapers/wallpaper_1.png '' davi davi
CopyFile /home/davi/Pictures/wallpapers/wallpaper_2.png '' davi davi
SetFileProperty /home/davi/Pictures group davi
SetFileProperty /home/davi/Pictures owner davi
SetFileProperty /home/davi/Pictures/wallpapers group davi
SetFileProperty /home/davi/Pictures/wallpapers owner davi


CopyFile /home/davi/colorschemes/aphelion '' davi davi
CopyFile /home/davi/colorschemes/lovelace '' davi davi
CopyFile /home/davi/colorschemes/README.md '' davi davi
SetFileProperty /home/davi/colorschemes group davi
SetFileProperty /home/davi/colorschemes owner davi


CopyFile /home/davi/bin/uuctl '' davi davi
CopyFile /home/davi/bin/check-hyprland-slice '' davi davi
CopyFile /home/davi/bin/list-user-units-type '' davi davi
SetFileProperty /home/davi/bin group davi
SetFileProperty /home/davi/bin owner davi


SetFileProperty /home/davi/.config group davi
SetFileProperty /home/davi/.config owner davi


CopyFile /home/davi/.config/dconf/user '' davi davi
SetFileProperty /home/davi/.config/dconf group davi
SetFileProperty /home/davi/.config/dconf mode 700
SetFileProperty /home/davi/.config/dconf owner davi


CopyFile /home/davi/.config/environment.d/uwsm.conf '' davi davi
SetFileProperty /home/davi/.config/environment.d group davi
SetFileProperty /home/davi/.config/environment.d owner davi


CopyFile /home/davi/.config/hypr/hyprland.conf '' davi davi
CopyFile /home/davi/.config/hypr/hyprpaper.conf '' davi davi
SetFileProperty /home/davi/.config/hypr group davi
SetFileProperty /home/davi/.config/hypr owner davi


CopyFile /home/davi/.config/kanata/kanata.kbd '' davi davi
SetFileProperty /home/davi/.config/kanata group davi
SetFileProperty /home/davi/.config/kanata owner davi


CopyFile /home/davi/.config/fontconfig/fonts.conf '' davi davi
SetFileProperty /home/davi/.config/fontconfig group davi
SetFileProperty /home/davi/.config/fontconfig owner davi


CopyFile /home/davi/.config/kitty/colors.conf '' davi davi
CopyFile /home/davi/.config/kitty/kitty.conf '' davi davi
SetFileProperty /home/davi/.config/kitty group davi
SetFileProperty /home/davi/.config/kitty owner davi


CopyFile /home/davi/.config/rofi/colors.rasi '' davi davi
CopyFile /home/davi/.config/rofi/config.rasi '' davi davi
SetFileProperty /home/davi/.config/rofi group davi
SetFileProperty /home/davi/.config/rofi owner davi


CopyFile /home/davi/.config/swaync/config.json '' davi davi
CopyFile /home/davi/.config/swaync/style.css '' davi davi
SetFileProperty /home/davi/.config/swaync group davi
SetFileProperty /home/davi/.config/swaync owner davi

