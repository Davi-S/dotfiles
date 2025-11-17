#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -AlhF --group-directories-first --color=auto'
alias grep='grep --color=auto'
alias trm='trash-put'
PS1='[\u@\h \W]\$ '

# Avoid using rm. Use trash-cli instead.
# use `\rm file-without-hope` to bypass this alias.
alias rm='echo "Use trash-put instead of rm. Use \rm to bypass this warning"; false'

# Alias for hibernation
alias hibernate='sudo systemctl hibernate'

# My scripts
export PATH="$HOME/bin:$PATH"

# Created by `pipx` on 2025-10-22 13:52:46
export PATH="$PATH:/home/davi/.local/bin"

