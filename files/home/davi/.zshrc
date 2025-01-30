# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/davi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
# Enable colored output for 'ls' command
alias ls='ls --color=auto'
# Enable colored output for 'grep' command
alias grep='grep --color=auto'
# List files in long format with hidden files
alias ll='ls -la'
# Ask for confirmation before deleting files
alias rm='rm -i'
# Ask for confirmation before overwriting files with 'cp'
alias cp='cp -i'
# Ask for confirmation before overwriting files with 'mv'
alias mv='mv -i'
