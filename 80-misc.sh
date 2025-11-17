# For saving and managing clipboard history
# Miscellaneous and other configurations
# =====================================
# Miscellaneous packages and helper utilities
#
# A grab-bag of utilities and configuration that don't fit neatly into other modules


# For unzipping zip files
AddPackage unzip # For extracting and viewing files in .zip archives


# This is a "replacement" for rm.
# See the .bashrc file for the alises used alongside this
AddPackage trash-cli # Command line trashcan (recycle bin) interface


# Initially installed for a university assignment.
AddPackage --foreign logisim-evolution # An educational tool for designing and simulating digital logic circuits
CopyFile /usr/share/applications/logisim-evolution.desktop

# App to design digital circuits. It is an alternative to "logisim"
AddPackage --foreign digital # A digital logic designer and circuit simulator.
CopyFile /home/davi/.config/.digital.cfg '' davi davi
CopyFile /usr/share/applications/digital.desktop