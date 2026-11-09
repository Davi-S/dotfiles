# Coding
# ======
# Developer tooling and configuration.
# Packages, editor configs and helper utilities used for development.

# Python package managers
AddPackage uv          # An extremely fast Python package installer and resolver written in Rust
AddPackage python-pip  # The PyPA recommended tool for installing Python packages
AddPackage python-pipx # Install and Run Python Applications in Isolated Environments

AddPackage git # the fast distributed version control system
AddPackage github-cli # The GitHub CLI
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

# For linting and formatting python
AddPackage ruff # An extremely fast Python linter, written in Rust

# For linting and formatting lua files
AddPackage lua-language-server # Lua Language Server coded by Lua
AddPackage stylua # Deterministic code formatter for Lua

# AI for coding
AddPackage --foreign claude-code # An agentic coding tool that lives in your terminal

# Haskell
AddPackage --foreign ghcup-hs-bin # an installer for the general purpose language Haskell
AddPackage ghc # The Glasgow Haskell Compiler

# Shell tools 
AddPackage bats # Bash Automated Testing System
AddPackage shfmt # Format shell programs
AddPackage shellcheck # Shell script analysis tool

# For easily publish AUR packages
AddPackage pacman-contrib # Contributed scripts and tools for pacman systems
CopyFile /home/davi/.ssh/aur_ci.pub '' davi davi

# Go
AddPackage go # Core compiler tools for the Go programming language

# npm settings
CopyFile /home/davi/.npmrc 600 davi davi
