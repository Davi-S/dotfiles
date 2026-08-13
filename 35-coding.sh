# Coding
# ======
# Developer tooling and configuration.
# Packages, editor configs and helper utilities used for development.

# Python package managers
AddPackage uv          # An extremely fast Python package installer and resolver written in Rust
AddPackage python-pip  # The PyPA recommended tool for installing Python packages
AddPackage python-pipx # Install and Run Python Applications in Isolated Environments

AddPackage git # the fast distributed version control system
CopyFile /home/davi/.gitconfig '' davi davi

# Primarily required by git for some commands. Is not a mandatory dependency
AddPackage less # A terminal based program for viewing text files

# Initially installed for the Revelo LLM Projects
AddPackage docker # Pack, ship and run any application as a lightweight container

# Initially installed for a university assignment
AddPackage valgrind # Tool to help find memory-management problems in programs

# VScode from microsoft
AddPackage --foreign visual-studio-code-bin # Visual Studio Code (vscode): Editor for building and debugging modern web and cloud applications (official binary version)

# Git terminal user interface
AddPackage lazygit # Simple terminal UI for git commands
CopyFile /home/davi/.config/lazygit/config.yml '' davi davi
SetFileProperty /home/davi/.config/lazygit group davi
SetFileProperty /home/davi/.config/lazygit owner davi

# Configuration for the C lang formatter
CopyFile /home/davi/.clang-format '' davi davi

# Google terminal AI for using Gemini
AddPackage --foreign antigravity-cli # Google's agentic development platform (CLI companion)

# For linting and formatting python
AddPackage ruff # An extremely fast Python linter, written in Rust
