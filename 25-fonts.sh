# Fonts
# =====
# System fonts and font configuration

# This package is a dynamically patched Atkinson Hyperlegible to Nerd Font that
# I published myself
AddPackage --foreign otf-atkinson-hyperlegible-nerd # Atkinson Hyperlegible Next and Mono, all weights, patched with Nerd Fonts 3.3.0 (OTF)

CopyFile /home/davi/.config/fontconfig/fonts.conf '' davi davi
SetFileProperty /home/davi/.config/fontconfig group davi
SetFileProperty /home/davi/.config/fontconfig owner davi

# Other fallback fonts for characters that are missing in the Atkinson
AddPackage noto-fonts       # Google Noto TTF fonts
AddPackage noto-fonts-cjk   # Google Noto CJK fonts
AddPackage noto-fonts-emoji # Google Noto emoji fonts
