# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Defines the prompt that appears in your terminal before typing a command
PS1='[\w]\$ '
# Prompt Toggles
alias prompt-min='export PS1="[\w]\$ "'
alias prompt-full='export PS1="[\u@\h \W]\$ "'


# Common aliases
alias ls='ls --color=auto'
alias ll='ls -AlhF --group-directories-first --color=auto'
alias grep='grep --color=auto'
alias c='clear'

# I can't remember the name of this cli tui, so use a intuitive name
alias nettui='impala'

# Avoid using rm. Use trash-cli instead.
# use `\rm file-without-hope` to bypass this alias.
alias rm='echo "Use trash-put instead of rm, or use \rm to bypass this warning"; false'
alias trm='trash-put'

# Alias for hibernation
alias hibernate='sudo systemctl hibernate'

# "y" aliases for yazi terminal file explorer
function y() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd" || return
    trm -f -- "$tmp"
}

# Use mpv as an image viewer (https://github.com/occivink/mpv-image-viewer)
# Also set class so it is pickable with `hyprctl clients`
alias mvi='mpv --config-dir=$HOME/.config/mvi --wayland-app-id=mvi'

# My scripts
export PATH="$HOME/bin:$PATH"

# Created by `pipx` on 2025-10-22 13:52:46
export PATH="$PATH:/home/davi/.local/bin"

# Set nvim as the editor
export EDITOR='nvim'
# Visual is for historical reasons. Good to have.
export VISUAL='nvim'
