# Keyboard layout and Kanata
# =========================
# Keyboard layout customization via Kanata
#
# Provides keyboard re-mapping and layout customization powered by the
# Kanata project.


AddPackage --foreign kanata # Bring the customizability of a QMK board to any keyboard near you
CopyFile /etc/kanata/kanata-linux.kbd
CopyFile /etc/kanata/kanata-linux.kbd.bak
# Service to start at boot in background
# Reference:
#  - https://github.com/jtroo/kanata?tab=readme-ov-file#usage
#  - https://github.com/jtroo/kanata/discussions/130#discussioncomment-10227272
CopyFile /etc/systemd/system/kanata.service